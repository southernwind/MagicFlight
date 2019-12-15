package org.libspark.typas 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	/**
	 * タイピングゲームで使われるイベントです。
	 * @author shohei909
	 */
	public class TypeEvent extends Event {
		public static const WORD_REMOVED:String = "wordRemoved";		
		public static const WORD_TYPED:String = "wordTyped";
		public static const WORD_ADDED:String = "wordAdded";
		public static const MISSED:String = "missed";
		public static const TYPED:String = "typed"
		
		
		/** イベントが発生した時のゲームの経過時間(ミリ秒)です。 */
		public var time:int;
		/** タイプされたキーを表すStringです。 */
		public var typed:String;
		/** タイプされた単語です。 */
		public var word:TypeWord;
		/** この単語またはキーを入力するのにミスをした回数です。 */
		public var miss:int;
		
		/**
		 * コンストラクタです。
		 * @param	type
		 * @param	time
		 * @param	typed
		 * @param	word
		 * @param	keyboardEvent
		 */
		function TypeEvent( type:String, time:int, typed:String, word:TypeWord = null, miss:int = 0 ) { 
			super( type );
			this.typed = typed;
			this.time = time;
			this.word = word;
			this.miss = miss;
		}
	}
}