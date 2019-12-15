package org.libspark.typas 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.utils.*;
	import org.libspark.typas.acss.TypeMessage;

/**
 *  TypingがTypeManagerによって終了させられる寸前に発生するイベントです。
 *  @eventType flash.events.Event.COMPLETE
 */
[Event(name = "complete", type = "flash.events.Event")]


	/**
	 * タイピングゲームへの単語の追加や、ゲームの終了を自動でおこないます。
	 * @author shohei909
	 */
	public class TypeManager extends EventDispatcher{
		/** 親となるタイピングゲームです。 */
		public function set typing( t:Typing ):void{ _removeTyping(); _addTyping( t ); }
		public function get typing():Typing { return _typing; }
		private var _typing:Typing;
		
		private var _wordLists:Vector.<TypeWordList> = new Vector.<TypeWordList>();
		/** 単語表のVector配列です。 */
		public function get wordLists():Vector.<TypeWordList> { return _wordLists; }
		
		/** 次以降に追加される単語のリスト　*/
		public var hint:Vector.<TypeWord> = new Vector.<TypeWord>;
		
		/** ヒントの数です。　*/
		public function get hintLength():int { return hint.length; }
		private var _hintLength:int = 0;
		
		/** 制限時間(ミリ秒)です。これを－1以外の値に設定したとき、制限時間に達した時点でタイピングゲームは終了となります。 */
		public var timeLimit:int = -1;		
		/** 単語の数に制限をつけます。この制限に達した時点でタイピングゲームは終了となります。　*/
		public var postLimit:int = -1;
		/** 単語の追加を行った回数 */
		public var postCount:int = 0;
		/** 単語入力の回数に制限をつけます。この制限に達した時点でタイピングゲームは終了となります。 */
		public var wordLimit:int = -1;
		/** trueにすると、typing.targetの長さが0になった時に単語が追加されます。 */
		public var zeroPost:Boolean = true;
		
		/** 単語の時間間隔です。0以上の値にすると、前回の単語追加からpostTimeの時間(ミリ秒)が経過した時点で単語の追加を行います。　*/
		public var postTime:int = -1;
		private var _lastPost:int = 0;
		
		/** ゲーム開始前の待機時間(ミリ秒)です。 */
		public function get delay():int{ return _delay }
		private var _delay:int = 0;
		
		/** カウントダウン中かどうかのBooleanです */
		public function get counting():Boolean{ return _counting }
		public function set counting( b:Boolean ):void{ _counting = b }
		private var _counting:Boolean = false;
		/** ゲームの開始予定時間です。　*/
		public var startTime:int = 0;
		
		/** カウントダウン用に現在表示してるString */
		private var _countText:String = "";
		
		/** カウントダウンのテキスト表示を行う秒数 */
		public function get countLength():int{ return _countLength }
		private var _countLength:int;
		
		/** キー入力待機中かどうかのBooleanです */
		public var isReady:Boolean = false;
		
		/** falseの場合、単語の追加は単語表の順番に従って行われます。trueの場合、単語の追加はランダムに行われます。 */
		public var random:Boolean = false;
		
		/**
		 * コンストラクタです。
		 * @param	typing　親となる、タイピングゲームです。
		 * @param	wordLists 単語表のクラスです。TypeWordListクラスのオブジェクトまたは、配列を指定ください。
		 * 配列arrを指定すると、new TypeWordList(arr)によって自動的に単語表が作成されます。
		 */
		function TypeManager( typing:Typing, ...wordLists ):void {
			for each (var list:* in wordLists) {
				if ( list is Array ) {
					_wordLists.push( new TypeWordList( list ) );
				}else {
					_wordLists.push( list );
				}
			}
			this.typing = typing;
			init();
		}
		
		/**
		 * 単語リストを指定します。この関数を使用すると今までの単語リストは取り除かれます。
		 * @param	...wordLists TypeWordListクラスのオブジェクトです。
		 */
		public function setWordList( ...wordLists ):void{
			trace( _wordLists.length )
			_wordLists.splice( 0, uint.MAX_VALUE );
			trace( _wordLists.length )
			_wordLists.push.apply( null, wordLists );
			trace( _wordLists.length )
		}
		
		/**
		 * 現在の単語リストに新たな単語リストを追加します。
		 * @param	...wordLists TypeWordListクラスのオブジェクトです。
		 */
		public function addWordList( ...wordLists ):void {
			_wordLists.push.apply( null, wordLists );
		}
		
		/**
		 * 指定した単語リストを取り除きます。
		 * @param	...wordLists TypeWordListクラスのオブジェクトです。
		 */
		public function removeWordList( ...wordLists ):void {
			for each (var list:TypeWordList in wordLists) {
				var i:int;
				if ( (i = _wordLists.indexOf( list )) != -1 ) { _wordLists.splice( i, 1 ); }
				else{ throw( new Error( "指定した単語リストはありません。" ) ) }
			}
		}
		
		/** このマネージャーが持っている単語リストの使用済み単語をすべて解放します */
		public function release():void {
			for each (var list:TypeWordList in wordLists )  list.release();
		}
		
		private function _addTyping( typing:Typing ):void {
			if (! typing ) { return; }
			_typing = typing;
			_typing.addEventListener( Typing.START, _start );
			_typing.addEventListener( TypeEvent.WORD_REMOVED, onWordRemoved );
			_typing.addEventListener( Event.ADDED_TO_STAGE, _addedToStage );
			if ( _typing.stage ) { 
				_addedToStage( null );
			}
			_typing.addEventListener( Event.ENTER_FRAME, _frame, false, 0, false );
		}
		
		private function _removeTyping():void {
			if (! _typing ) { return; }
			_typing.removeEventListener( Typing.START, _start );
			_typing.removeEventListener( TypeEvent.WORD_REMOVED, onWordRemoved );
			if ( _typing.stage ) {
				_removedFromStage( null );
			}else {
				_typing.removeEventListener( Event.ADDED_TO_STAGE, _addedToStage );
			}
			_typing.removeEventListener( Event.ENTER_FRAME, _frame );
			_typing = null;
		}
		
		private function _addedToStage( e:Event ):void {
			_typing.removeEventListener( Event.ADDED_TO_STAGE, _addedToStage );
			_typing.addEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage ); 
			_typing.stage.addEventListener( KeyboardEvent.KEY_DOWN, _onKeyDown );
		}
		private function _removedFromStage( e:Event ):void {
			_typing.removeEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage ); 
			_typing.addEventListener( Event.ADDED_TO_STAGE, _addedToStage );
			_typing.stage.removeEventListener( KeyboardEvent.KEY_DOWN, _onKeyDown );
		}
		
		/** ゲーム開始前の状態に戻ります。カウントダウン状態やスタンバイ状態の場合は中断します。 */
		public function init():void {
			_counting = false;
			isReady = false;
			hint = new Vector.<TypeWord>();
			postCount = 0;
			_delay = 0;
			release();
		}
		private function _setup():void {
			for each (var list:TypeWordList in _wordLists ) { list.release(); }
		}
		
		/**
		 * キー入力を待ってからゲームを開始させるスタンバイ状態に入ります。この関数を呼び出すと同時にtypingが初期化されます。
		 * @param	delay ゲーム開始までの待機時間(ミリ秒)です。
		 * @param	countDown カウントダウンを行う秒数です
		 */
		public function ready( delay:int = 0, countLength:int = 3 ):void {
			if ( typing.running ) { typing.stop(); }
			typing.init();
			init();
			this._delay = delay;
			this._countLength = countLength;
			this.isReady = true;
			typing.addMessage( TypeMessage.pushSpaceKey );
		}
		
		// typingにカウントダウンのメッセージを表示します。
		private function _countDown( str:String ):void {
			if( typing.sound.count ) typing.sound.count.play( 0, 0, typing.sound.transform );
			typing.addMessage( str, 1000 );
			_countText = str;
		}
		
		private function _countStart():void {
			typing.removeMessage( TypeMessage.pushSpaceKey );
			isReady = false;
			if ( delay <= 0 ) {	
				typing.start( false );
			}else { 
				startTime = getTimer() + delay;
				_counting = true;
			}
		}
		
		
		private function _onKeyDown( e:KeyboardEvent ):void {
			var c:int = e.keyCode;
			if ( isReady && c == 32 ) { _countStart(); }
		}
		
		/** 
		 * タイピングゲームへ単語の追加を行います。
		 * ヒントがある場合は、ヒントから単語の追加を行います。
		 * タグを指定して単語を追加したい場合、先にaddHint()を行ってください。 
		 **/
		public function post():TypeWord{
			var word:TypeWord;
			if ( postLimit != postCount ) {
				do{
					if( hint.length == 0 ){ addHint(); }
					word = hint[0];
					var f:Boolean = typing.addWord( word );
					hint.shift();
				}while (! f );
				_lastPost = typing.time;
				postCount++;
			}
			return word;
		}
		
		/**
		 * ヒントを追加します。
		 * @param	...tags タグを指定するとtagにマッチするもののみを選択して追加します。
		 */
		public function addHint( ...tags ):void {
			var a:uint = 0, ls:Array = [], list:TypeWordList;
			for ( var j:int = 0; a == 0; j++ ){
				if ( j > 0 ) {
					if ( j == 1 ) {
						for each ( list in _wordLists ) { list.release( tags ); }
					}else {
						throw( new Error("追加できる単語がありません。") ); return;
					}
				}
				for ( var i:int = 0, l:int = _wordLists.length; i < l; i++ ) {
					list = _wordLists[ i ];
					a += ( ls[i] = list.count( tags ) );
				}
			}
			for ( var num:int = random ? a * Math.random() : 0, c:int = ls.pop(); num >= c; num -= c, c = ls.pop() ) {}
			var word:TypeWord = list.select( num, tags );
			hint.push( word );
		}
		
		/** @private */
		protected function _start( e:Event = null ):void { _check(); }
		protected function _init( e:Event = null ):void {}
		/** @private */
		protected function _frame( e:Event = null ):void {
			if ( counting ) {
				var t2:int = startTime - getTimer();
				var t:int = Math.ceil( t2/ 1000)
				if ( t <= 0 ) {
					_counting = false;
					typing.start( false );
				}else if ( t <= countLength ) {
					var str:String = t.toString();
					if( _countText != str ){ _countDown( str ) }
				}
			}
			if( typing.running ){
				if ( timeLimit != -1 && typing.time >= timeLimit) { complete(); }
				if ( postTime != -1 && typing.time - _lastPost >= postTime ) { post(); }
			}
		}
		
		private function onWordRemoved( e:Event ):void{ _check(); }
		private function _check():void {
			if( wordLimit == typing.typedWord ){ complete(); }
			if( typing.target.length == 0 ){ 
				if( postLimit == postCount ){ complete(); }
				else if( zeroPost ){ post(); }	
			}
		}
		
		/** タイピングゲームを終了させます。 */
		public function complete():void {
			dispatchEvent( new Event( Event.COMPLETE ) );
			typing.stop();
			release();
			typing.addMessage( TypeMessage.finish );
		}
	}
}