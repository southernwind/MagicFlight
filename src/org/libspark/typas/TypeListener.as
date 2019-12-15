package org.libspark.typas 
{
	import org.libspark.typas.TypeEvent;
	import flash.events.Event;
	/**
	 * タイピングゲームの進行状況を詳細に記録するクラス。
	 * ゲームの記録はTypeLogとして得ることができます。
	 * @author shohei909
	 */
	public class TypeListener {
		private var _typing:Typing;
		public function set typing( t:Typing ):void{ _removeTyping(); _addTyping( t ); }
		public function get typing():Typing { return _typing; }
		private function _addTyping( typing:Typing ):void {
			if (! typing ) { return; }
			_typing = typing;
			_typing.addEventListener( "wordAdded", _onTypeEvent );
			_typing.addEventListener( "wordRemoved", _onTypeEvent );
			_typing.addEventListener( "wordTyped", _onTypeEvent );
			_typing.addEventListener( "typed", _onTypeEvent );
			_typing.addEventListener( "missd", _onTypeEvent );
			_typing.addEventListener( Event.INIT, _init );
		}
		private function _removeTyping():void {
			if (! _typing ) { return; }
			_typing.removeEventListener( "wordAdded", _onTypeEvent );
			_typing.removeEventListener( "wordRemoved", _onTypeEvent );
			_typing.removeEventListener( "wordTyped", _onTypeEvent );
			_typing.removeEventListener( "typed", _onTypeEvent );
			_typing.removeEventListener( "missd", _onTypeEvent );
			_typing.removeEventListener( Event.INIT, _init );
			_typing = null;
		}
		
		/** タイピングの記録です。タイピングゲームが初期化されると古い記録は消去され、新しい記録が取られます。　*/
		public var log:TypeLog;
		
		/**
		 * コンストラクタです。
		 * @param	typing 記録をとるタイピングゲームです。
		 */
		function TypeListener( typing:Typing ):void{
			this.typing = typing;
			_init( null );
		}
		
		private function _onTypeEvent( e:TypeEvent ):void {
			log.add( e );
		}
		
		private function _init( e:Event ):void{
			log = new TypeLog;
		}
	}
}