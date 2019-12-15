package org.libspark.typas 
{
	/**
	 * タイピングの記録です。SharedObjectにしても記録が損なわれません。
	 * @author shohei909
	 */
	public class TypeLog {
		public var type:Array = [];
		public var time:Array = [];
		public var word:Array = [];
		public var typed:Array = [];
		
		public function add( event:TypeEvent ):void {
			type.push( event.type );
			time.push( event.time );
			typed.push( event.typed );
			if( event.word ){
				word.push( event.word.obj );
			}else {
				word.push( null );
			}
		}
		
		public function getEvent( i:int ):TypeEvent {
			return new TypeEvent( type[i], time[i], typed[i], word[i] );
		}
	}
}