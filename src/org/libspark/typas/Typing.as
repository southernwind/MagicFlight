
package org.libspark.typas{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import org.libspark.typas.acss.TypeMessage;
	import org.libspark.typas.util.ArrayUtil;
	
	

/**
 *  Typingが初期化された直後に発生するイベントです。
 *  @eventType flash.events.Event.INIT
 */
[Event(name = "init", type = "flash.events.Event")]

/**
 *  タイピングゲームが開始した直後に発生するイベントです。
 *  @eventType org.libspark.typas.Typing.START
 */
[Event(name = "start", type = "flash.events.Event")]

/**
 *  タイピングゲームが停止した直後に発生するイベントです。
 *  @eventType org.libspark.typas.Typing.STOP
 */
[Event(name = "stop", type = "flash.events.Event")]

/**
 *  タイピングゲームが一時停止した直後に発生するイベントです。
 *  @eventType org.libspark.typas.Typing.PAUSE
 */
[Event(name = "pause", type = "flash.events.Event")]

/**
 *  タイピングゲームが再開した直後に発生するイベントです。
 *  @eventType org.libspark.typas.Typing.RESUME
 */
[Event(name = "resume", type = "flash.events.Event")]

/**
 *  タイピングゲームのメッセージが変更された直後に発生するイベントです。
 *  @eventType org.libspark.typas.Typing.MESSAGE
 */
[Event(name = "message", type = "flash.events.Event")]

/**
 *  タイピングゲームに新しい単語が追加されたときに発生されるイベントです。
 *  @eventType org.libspark.typas.TypeEvent.WORD_ADDED
 */
[Event(name = "wordAdded", type = "org.libspark.typas.TypeEvent")]

/**
 *  タイピングゲームから単語が追加されたときに発生されるイベントです。
 *  @eventType org.libspark.typas.TypeEvent.WORD_REMOVED
 */
[Event(name = "wordRemoved", type = "org.libspark.typas.TypeEvent")]

/**
 *  単語が正しくタイプされたときに発生されるイベントです。
 *  @eventType org.libspark.typas.TypeEvent.WORD_TYPED
 */
[Event(name = "wordTyped", type = "org.libspark.typas.TypeEvent")]

/**
 *  キーが正しくタイプされたときに発生されるイベントです。
 *  @eventType org.libspark.typas.TypeEvent.TYPED
 */
[Event(name = "typed", type = "org.libspark.typas.TypeEvent")]

/**
 *  キーが間違ってタイプされたときに発生されるイベントです。
 *  @eventType org.libspark.typas.TypeEvent.MISSED
 */
[Event(name = "missed", type = "org.libspark.typas.TypeEvent")]

	/**
	 * このライブラリのコアとなるタイピングゲームのクラスです。
	 * @author shohei909
	 */
	public class Typing extends Sprite {
		static public const MESSAGE:String = "message";
		static public const START:String = "start";
		static public const STOP:String = "stop";
		static public const PAUSE:String = "pause";
		static public const RESUME:String = "resume";
		
		/** 標的として登録されている単語 */
		public var target:Vector.<TypeWord>;
		/** 現在入力可能な単語 */
		public var active:Vector.<TypeWord>;
		/** この配列に加えられたキーコードは入力を無視されます。　*/
		public var ignore:Vector.<int> = new Vector.<int>();
		
		
		/**　ミスタイプの回数　*/
		public var miss:int = 0;
		/** 正しいタイプの回数 */
		public var correct:int = 0;
		/** スタートからの経過時間(ミリ秒)　*/
		public var time:int = 0;
		/** 単語入力の回数　*/
		public var typedWord:int = 0;
		/** 単語追加の回数　*/
		public var addedWord:int = 0;
		//現在の時間
		private var _timer:int = 0;
		
		/** 最後に正しくキータイプした時間(ミリ秒)です。　*/
		public var lastType:int = 0;
		/** 最後に単語入力終えた時間(ミリ秒)です。　*/
		public var lastWord:int = 0;
		/** 現在の単語入力を開始した時間(ミリ秒)です。　*/
		public var startWord:int = 0;
		/** 現在、何連続でミスタイプをしているかを表す値です。　*/
		public var keyMiss:int = 0;
		/** 現在入力中の単語で何回ミスをしているかを表す値です。　*/
		public var wordMiss:int = 0;
		
		/** 効果音 */
		public var sound:TypeSound = new TypeSound; 
		
		/** タイピングゲーム中かどうかのBoolean値です */
		public function get running():Boolean { return _running; }
		private var _running:Boolean;
		
		/** 現在、ポーズ中かどうかのBoolean値です。 */
		public function get paused():Boolean { return _paused; }
		private var _paused:Boolean; 
		
		/** 現在タイプされている文のString値です。　*/
		public function get text():String{ return _text; }
		private var _text:String;
		
		/** 次にタイプ可能なキーの配列です。　*/
		public function get next():Array { return _next; }
		private var _next:Array;
		/**
		 * メッセージのリストです。
		 * @see Typing#addMessage()
		 * @see Typing#removeMessage()
		 */
		public function get messageList():Array { return _messageList }
		private var _messageList:Array = [];
		
		private var _nihongo:Boolean = false;
		/**
		 * 最も優先度の高いメッセージです。
		 * @see org.libspark.typas.acss.TypeMessage
		 */
		public function get message():String {
			var l:int = messageList.length;
			if ( l == 0 ) { return null; }
			return messageList[l-1];
		}
		
		private var _useKeyboard:Boolean;
		/**
		 * コンストラクタです
		 * @param	useKeyboard キーボードからの入力を受けるかどうかのBooleanです。
		 */
		function Typing( useKeyboard:Boolean = true ) {
			_useKeyboard = useKeyboard;
			addEventListener( Event.ADDED_TO_STAGE, _addedToStage, false, 0, true );
			init();
		}
		
		private function _addedToStage( e:Event ):void {
			removeEventListener( Event.ADDED_TO_STAGE, _addedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage, false, 0, true ); 
			addEventListener( Event.ENTER_FRAME, onFrame, false, 0, true );
			if( _useKeyboard ){ stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true ); }
		}
		
		private function _removedFromStage( e:Event ):void {
			removeEventListener( Event.REMOVED_FROM_STAGE, _removedFromStage ); 
			removeEventListener( Event.ENTER_FRAME, onFrame );
			addEventListener( Event.ADDED_TO_STAGE, _addedToStage, false, 0, true );
			if( _useKeyboard ){ stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown ); }
		}
		
		/** ゲームの初期化を行います。この関数はstart()を実行すると同時に実行されます。 */
		public function init():void {
			while( _messageList.length > 0 ){ removeMessage( _messageList[0] ) }; 
			_next = [];
			
			_text = "";
			_running = false;
			_nihongo = false;
			
			time = 0;
			addedWord = 0;
			typedWord = 0; 
			correct = 0;
			miss = 0;
			lastType = 0;
			lastWord = 0;
			startWord = 0;
			keyMiss = 0;
			wordMiss = 0;
			
			target = new Vector.<TypeWord>();
			active = new Vector.<TypeWord>(); 
			
			dispatchEvent( new Event( Event.INIT ) );
		}
		
		/** 
		 * targetに新たな単語を追加します。
		 * すでに同じ単語が含まれている場合は単語の追加に失敗して、falseが返されます。
		 * @return 単語の追加に成功したかどうかです。
		 **/
		public function addWord( word:TypeWord ):Boolean {
			if ( target.indexOf( word ) >= 0 ) { return false; }
			word.typing = this;
			addedWord++;
			target.push( word );
			word.isTarget = true;
			word.next = TypeUtil.next( word.kana, text, TypeConfig.option );
			word.isActive = ( word.next.length > 0 );
			if( word.isActive ){ active.push( word ); }
			word.roman = TypeUtil.simplestRoman( word.kana, text, TypeConfig.option );
			if ( word.roman == null ) { word.roman = word.defaultRoman; }
			ArrayUtil.blend( _next, word.next );
			
			dispatchEvent( new TypeEvent( TypeEvent.WORD_ADDED, time, "", word ) );
			word.dispatchEvent( new TypeEvent( TypeEvent.WORD_ADDED, time, "", word ) );
			return true;
		}
		
		/** targetから指定した単語を取り除きます。 */
		public function removeWord( word:TypeWord ):void{
			var index:int = target.indexOf( word );
			removeAt( index );
		}
		
		/** targetから指定した位置の単語を取り除きます。 */
		public function removeAt( index:int ):void{
			var word:TypeWord = target[index] 
			if ( index != -1 ) { 
				word.isTarget = false;
				target.splice( index, 1 ); 
				if( (index = active.indexOf(word)) != -1 ){
					word.isActive = false;
					active.splice( index, 1 );
				}
				_wordsUpdate();
				var e:TypeEvent = new TypeEvent( TypeEvent.WORD_REMOVED, time, "", word);
				word.dispatchEvent( e );
				dispatchEvent( e );
			}
		}
		
		/** targetからすべての位置の単語を取り除きます。 */
		public function removeAll():void {
			while ( target.length > 0 ) { removeAt( 0 ); }
		}
		
		
		/**
		 * タイピングゲームを開始します。　
		 * @param	initilize スタート時に記録の初期化を行うかどうかのBool値です。
		 */
		public function start( initilize:Boolean = true ):void {
			if( initilize ){ init() };
			if( !running ){
				_running = true;
				_timer = getTimer();
				dispatchEvent( new Event( START ) );
				if ( sound.start ) sound.start.play( 0, 0, sound.transform );
			}else {
				dispatchEvent( new Event( START ) );
			}
		}
		
		
		/** タイピングゲームを停止します。　*/
		public function stop():void {
			if ( _running ) {
				_running = false;
				dispatchEvent( new Event( STOP ) );
				if( sound.stop ) sound.stop.play( 0, 0, sound.transform );
			}else {	dispatchEvent( new Event( STOP ) ); }
		}
		
		private function onFrame( e:Event ):void {
			if ( _running ) {
				var t:int = getTimer();
				time += t - _timer;
				_timer = t;
			}
		}
		
		/**
		 * タイピングゲームを一時停止します。
		 */
		public function pause():void {
			if ( running && !_paused ) {
				_paused = true;
				addMessage( TypeMessage.pause );
				dispatchEvent( new Event(PAUSE) );
				if( sound.pause ) sound.pause.play( 0, 0, sound.transform );				
			}
		}
		
		/**
		 * タイピングゲームを再開します。
		 */
		public function resume():void {
			if ( running && _paused ) {
				_paused = false;
				_timer = getTimer();
				removeMessage( TypeMessage.pause );
				dispatchEvent( new Event(RESUME) );
				if( sound.resume ) sound.resume.play( 0, 0, sound.transform );				
			}
		}
		
		/** キーをタイプしたときに呼び出されるイベントハンドラです。この関数を呼び出すことでキーをタイプしたときと同じ挙動をさせることが可能になります。 */
		public function onKeyDown( evt:KeyboardEvent ):void {
			var k:int = evt.keyCode;
			if ( k == 229 ) {
				if (! _nihongo ) {
					_nihongo = true;
					addMessage( TypeMessage.nihongo );
				}
			}else {
				if ( _nihongo ) {
					_nihongo = false;
					removeMessage( TypeMessage.nihongo );
				}
			}
			if ( _nihongo ) { return; }
			if( ignore && ignore.indexOf(k) >= 0 ){ return }
				
			if( _running && !_paused ){
				var s:String = String.fromCharCode( evt.charCode );
				if ( k == 16 || k == 17 || s == "" ) { return; }
				if ( k == Keyboard.BACKSPACE ) { _backSpace(); return; }
				
				var nx:int = next.indexOf( s );
				var e:TypeEvent;
				var t:int;
				var gt:int = getTimer();
				time += gt - _timer;
				_timer = gt;
				
				if ( nx == -1 ) {
					miss++;
					keyMiss++;
					wordMiss++;
					dispatchEvent( new TypeEvent( TypeEvent.MISSED, time, s, null, keyMiss )  );
					addMessage( TypeMessage.miss, 100 );
					if( sound.missType )sound.missType.play( 0, 0, sound.transform );
				}else {
					correct++;
					_text += s;
					if ( _text.length == 1 ) { startWord = time; }
					var flag:Boolean = false;
					var l:uint = active.length;
					var c:uint = 0;
					_next = [];
					
					
					for( var i:uint = 0; i < l; i++ ) {
						var word:TypeWord = active[i];
						word.next = TypeUtil.next( word.kana, _text, TypeConfig.option );
						word.isActive = ( word.next.length > 0 );
						ArrayUtil.blend( _next, word.next ); 
						if( word.roman == _text ) {
							flag = true;
							_text = "";
							removeWord( word );
							break;
						}
						if ( word.isActive ) { 
							word.roman = TypeUtil.simplestRoman( word.kana, _text, TypeConfig.option ); }
						else { 
							word.roman = word.defaultRoman; 
							active.splice( i, 1 );
							i--; l--;
						}
					}
					
					lastType = time;
					dispatchEvent( new TypeEvent( TypeEvent.TYPED, time, s, null, keyMiss )  );
					if( flag ){
						typedWord++;
						lastWord = time;
						e = new TypeEvent( TypeEvent.WORD_TYPED, time, word.roman, word, wordMiss );
						word.dispatchEvent( e );
						dispatchEvent( e );
						wordMiss = 0;
						if( sound.wordType ){ sound.wordType.play( 0, 0, sound.transform ); }
					}else {
						if ( sound.type ) { sound.type.play( 0, 0, sound.transform ); }
					}
					keyMiss = 0;
				}	
			}
		}
		
		//単語をアップデートする。
		private function _wordsUpdate():void {
			var l:uint = target.length;
			active = new Vector.<TypeWord>();
			_next = [];
			for ( var i:uint = 0; i < l; i++ ) {
				var word:TypeWord = target[i];
				word.isActive = true;
				active.push( word );
				word.next = TypeUtil.next( word.kana, _text, TypeConfig.option );
				ArrayUtil.blend( _next, word.next ); 
				word.roman = word.defaultRoman;
			}
		}
		
		private function _backSpace():void {
			if ( _text.length == 0 ) {
				miss++
			}
		}
		
		private function _miss():void {
			
		}
		
		/**
		 * メッセージを追加します。
		 * @see org.libspark.typas.acss.TypeMessage
		 * @param	str　追加するメッセージです。
		 * @param	time　メッセージを表示する時間(ミリ秒)です。負の数を設定するとメッセージの除去を自動でおこないません。
		 */
		public function addMessage( str:String, time:int = -1 ):void {
			if ( str == "" ) { return; }
			messageList.push( str );
			if ( time >= 0 ) { setTimeout( removeMessage, time, str ); }
			dispatchEvent( new Event( MESSAGE ) );
		}
		
		/** 
		 * 指定されたメッセージを除去します。
		 * @see org.libspark.typas.acss.TypeMessage
		 * @param	str　削除するメッセージです。
		 **/
		public function removeMessage( str:String ):Boolean {
			if ( str == "" ) { return false; }
			var index:int = messageList.indexOf( str );
			if ( index != -1 ) { 
				messageList.splice( index, 1 );
				dispatchEvent( new Event( MESSAGE ) );
				return true;
			}
			return false;
		}
	}
}