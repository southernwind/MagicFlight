package org.libspark.typas.acss 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.libspark.typas.*;
	
	/**
	 * キーボードです。タイピングゲームと同期して、打つべきキーを示します。
	 * @see TypeStyle
	 * @see TypeHands
	 * @author shohei909
	 */
	public class TypeKeyboard extends Sprite 
	{
		private var _typing:Typing;
		public function set typing( t:Typing ):void{ _removeTyping(); _addTyping( t ); }
		public function get typing():Typing { return _typing; }
		private function _addTyping( typing:Typing ):void {
			if (! typing ) { return; }
			_typing = typing;
			_typing.addEventListener( TypeEvent.TYPED, read );
			_typing.addEventListener( TypeEvent.WORD_ADDED, read );
			_typing.addEventListener( TypeEvent.WORD_REMOVED, read );
			_typing.addEventListener( Typing.START, read );
			if ( _typing.running ) { read( null ) }
		}
		private function _removeTyping():void {
			if (! _typing ) { return; }
			_typing.removeEventListener( TypeEvent.TYPED, read );
			_typing.removeEventListener( TypeEvent.WORD_ADDED, read );
			_typing.removeEventListener( TypeEvent.WORD_REMOVED, read );
			_typing.removeEventListener( Typing.START, read );
			_typing = null;
		}
		
		public var keys:Array = TypeData.QWERTY_KEY;
		public var shiftKeys:Array = TypeData.QWERTY_SHIFT;
		
		
		private var _board:String;
		/**
		 * キーボードの種類です。QWERTYとDVORAKがあります。
		 */
		public function get board():String{ return _board; }
		public function set board( b:String ):void{ 
			if( _board != b ){
				_board = b;
				switch( b ){
					case TypeConfig.DVORAK:
						keys = TypeData.DVORAK_KEY;
						shiftKeys = TypeData.DVORAK_SHIFT;
						break;
					case TypeConfig.QWERTY:
						keys = TypeData.QWERTY_KEY;
						shiftKeys = TypeData.QWERTY_SHIFT;
						break;
					default:
						keys = [];
						shiftKeys = [];
						break;
				}
				init();
			}
		}
			
		static public var indent:Array = TypeData.BOARD_INDENT;
		static private const keySize:Number = 40;

		public var typeKeys:Vector.<TypeKey> = new Vector.<TypeKey>;
		public var shiftKey1:TypeKey;
		public var shiftKey2:TypeKey;
		
		private var _shifted:Boolean = false;
		public function get shifted():Boolean{ return _shifted; }
		
		/**
		 * コンストラクタです。
		 * @param	typing 同期させるタイピングゲームです。
		 * @param	x 
		 * @param	y 
		 */
		function TypeKeyboard( typing:Typing = null, x:Number = 0, y:Number = 0 ) { 
			this.typing = typing;
			this.x = x;
			this.y = y;
			this.board = TypeConfig.board;
		}
		
		//typingの現状を読み込んで次に打つべきキーのヒントを出力します。
		private function read( e:Event ):void {
			if( _shifted ){ unshift() }
			for each( var key1:TypeKey in typeKeys ){ key1.up(); }
			
			var next:Array = _typing.next;
			if (! next ) { return; }
			var l:int = next.length;
			
			for ( var i:int = 0; i < l; i++ ) {
				var str:String = next[i];
				for each( var key:TypeKey in typeKeys ){
					if( key.key == str ){
						if ( i == 0) { key.down(); }
						else if( key.state == "up" && shifted == false ){ key.over(); }
					}else if ( key.shiftKey == str ) { 
						if ( i == 0) { key.down(); shiftKey1.down(); shiftKey2.down(); shift() }
						else if( key.state == "up" && shifted ){ key.over(); }
					}
				}
			}
		}
		
		private function init():void{
			while( this.numChildren > 0 ){ this.removeChildAt(0); }
			var h:int = keys.length;
			var s:Number = keySize;
			for( var i:int = 0; i < h; i++ ){
				var w:int = keys[i].length
				for( var j:int = 0; j < w; j++ ){
					var str:String = keys[i].substr(j,1)
					var code:int = 48 + TypeData.CODE48.indexOf( str );
					if( code == 47 ){ code = 65 + TypeData.CODE65.indexOf( str ) }
					if( code == 64 ){ code = 186 + TypeData.CODE186.indexOf( str ) }
					if( code == 185 ){ code = 219 + TypeData.CODE219.indexOf( str ) }
					if( code == 218 ){ code = 226 + TypeData.CODE226.indexOf( str ) }
					var mark:Boolean = i == 2 &&( j == 3  || j == 6 ) 
					var key:TypeKey= new TypeKey( s-1, s-1, str, shiftKeys[i].substr(j,1), code, mark );
					key.x = ( j + indent[i] ) * s;
					key.y = i * s;
					addChild( key );
					typeKeys.push( key );
				}
			}   
			
			
			for( i = 0; i < 3; i++ ){
				key = new TypeKey( s*indent[i]-1, s-1, "", null, [229,9,22][i] );
				key.y = i * s;
				addChild( key ); 
			}
			
			var w0:Number = keys[0].length + indent[0]; 
			var w1:Number = keys[1].length + indent[1]; 
			var w2:Number = keys[2].length + indent[2]; 
			var w3:Number = keys[3].length + indent[3]; 
			
			//back space
			key = new TypeKey( s-1, s-1, "BS", "BS", 8 );
			key.x = w0 * s;
			addChild( key );
			typeKeys.push( key );
			
			//shift
			key = new TypeKey( indent[3]*s- 1, s-1, "Shift", "Shift", 16 );
			key.y = 3 * s;
			addChild( key );
			typeKeys.push( key );
			shiftKey1 = key;
			
			key = new TypeKey(  (w0-w3+1)*s -1,   s-1, "Shift", "Shift", 16 );
			key.x = w3 * s;
			key.y = 3 * s;
			addChild( key ); 
			typeKeys.push( key );
			shiftKey2 = key;
			
			//enter
			key = new TypeEnterKey( (w0-w1+1)*s -1, (w0-w2+1)*s -1,  s-1, 2*s-1 );
			key.x = w1 * s;
			key.y = 1 * s;
			addChild( key );
			typeKeys.push( key );
			
			//space
			key = new TypeKey( 4*s -1, s-1,  " ", " ", 32 );
			key.x = indent[4] * s;
			key.y = 4 * s;
			addChild( key );
			typeKeys.push( key );
		}
		
		/** シフト状態の表示をします。 */
		public function shift():void {
			_shifted = true;
			for each( var key:TypeKey in typeKeys ){ key.shift() }
		}
		/** シフト状態を解除します。 */
		public function unshift():void {
			_shifted = false;
			for each( var key:TypeKey in typeKeys ){ key.unshift() }
		}
		
	}

}