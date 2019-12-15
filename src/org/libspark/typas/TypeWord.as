package org.libspark.typas {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	
/**
 *  タイピングゲームに単語が追加されたときに発生されるイベントです。
 *  @eventType org.libspark.typas.TypeEvent.WORD_ADDED
 */
[Event(name = "wordAdded", type = "org.libspark.typas.TypeEvent")]

/**
 *  タイピングゲームから単語が削除されたときに発生されるイベントです。
 *  @eventType org.libspark.typas.TypeEvent.WORD_REMOVED
 */
[Event(name = "wordRemoved", type = "org.libspark.typas.TypeEvent")]

/**
 *  単語が正しく入力されたときに発生されるイベントです。
 *  @eventType org.libspark.typas.TypeEvent.WORD_TYPED
 */
[Event(name = "wordTyped", type = "org.libspark.typas.TypeEvent")]

	/**
	 * タイピングゲームで使用される単語です。ダイナミッククラスなので自由にパラメータを設定して使うことができます。
	 * @author shohei909
	 */
	public dynamic class TypeWord extends EventDispatcher{	
		/** 現在配置されている、あるいは最後に配置されたtypingです。*/
		public var typing:Typing;
		
		/** この単語が標的に含まれている時にtrueになります。 */
		public var isTarget:Boolean = false;
		/** この単語が入力可能な時にtrueになります。 */
		public var isActive:Boolean = false;
		
		/** 入力されているローマ字です */
		public var typed:String;
		/** 単語の文字列です　*/
		public var word:String;
		/** かなです　*/
		public var kana:String;
		/** この単語につけられている効果音です。 */
		public var sound:Sound;
		/** この単語につけられているタグです。 */
		public var tags:Array;
		public var chosen:Boolean;
		public var roman:String;
		/**/
		public var defaultRoman:String;
		public var next:Array;
		public var obj:Object;
		
		/**
		 * コンストラクタです。対象となるタイピングゲームと、単語を表すオブジェクトを指定します。<br/>
		 * <br/>
		 * オブジェクトのパラメータがそのままこの単語のパラメータとなります。<br/>
		 * オブジェクトは必ずwordとkanaパラメータをもつように設定してください。<br/>
		 * @param	typing
		 * @param	obj
		 */
		function TypeWord( obj:Object ):void { 
			this.obj = obj;
			for ( var str:String in obj ) { 
				this[str] = obj[str];
				this.setPropertyIsEnumerable( str, true );
			}
			if ( word == null ) { 
				throw( new Error( this + "にwordがありません。" ) );
				word = "???"
			}
			if ( kana == null ) { throw( new Error( word + "にkanaがありません。" ) )}
			if( TypeConfig.space ){ kana += " " }
			this.defaultRoman = TypeUtil.simplestRoman( kana, "", TypeConfig.option );
			if ( defaultRoman == null ) { throw( new Event( kana + "は正しくない文字を含みます。") ) }
			addEventListener( TypeEvent.WORD_ADDED, _added, false, 0, true );
		}
		private function _added( e:TypeEvent ):void {
			if ( sound ) { sound.play(); }
		}
		public function match( ...ts ):Boolean {
			for each( var tag:* in ts ) { if ( tags.indexOf( tag ) < 0 ) { return false; } }
			return true;
		}
	}
}