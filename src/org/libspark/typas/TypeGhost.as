package org.libspark.typas {
/**
 *  TypingがTypeGhostによって終了させられる寸前に発生するイベントです。
 *  @eventType flash.events.Event.COMPLETE
 */
[Event(name = "complete", type = "flash.events.Event")]

	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import org.libspark.typas.util.ArrayUtil;

	/**　
	 * TypeLogとして記録された過去のデータを使って、タイピングを再現します。
	 * @author shohei909
	 */
	public class TypeGhost extends TypeManager{
		public var log:TypeLog;
		public var position:int = 0;
		/**
		 * コンストラクタです。
		 * @param	typing　再現に使うタイピングゲームです。
		 * @param	log　過去のデータです。
		 */
		function TypeGhost( typing:Typing, log:TypeLog ) {
			super( typing, [] );
			zeroPost = false;
			this.log = log;
		}
		
		override protected function _start( e:Event = null ):void {}
		override protected function _init( e:Event = null ):void {
			super._init( e );
			position = 0;
		}
		
		override protected function _frame( e:Event = null ):void {
			super._frame( e );
			if (! typing.running ) { return; }
			if ( log.time.length <= position ) { complete(); }
			while( typing.time >= log.time[ position ] ) {
				switch( log.type[position] ) {
					case TypeEvent.TYPED:
					case TypeEvent.MISSED:
						typing.onKeyDown( new KeyboardEvent( "keyDown", true, false, log.typed[position].charCodeAt() ) );
						break;
					case TypeEvent.WORD_ADDED:
						typing.addWord( new TypeWord( log.word[position] ) );
						break;
				}
				if ( log.time.length <= ++position ) { complete(); break; }
			}
		}
	}
}