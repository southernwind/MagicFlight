package org.libspark.typas.acss 
{
	import flash.display.*;
	import flash.events.Event;
	import org.libspark.typas.*;
	/**
	 *　タイピングゲームに同期して、使用する指を表示します。
	 * @see TypeStyle
	 * @see TypeKeyboard
	 * @author shohei909
	 */
	public class TypeHands extends Sprite {
		/** 親となるタイピングゲームです。 */
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
		
		private var _fingers:Vector.<TypeFinger> = new Vector.<TypeFinger>;
		static private const L:Array = [ 30, 35, 35, 35, 25, 25, 35, 35, 35, 30 ];
		static private const X:Array = [ 70, 40, 40, 40, 40, 60, 40, 40, 40, 40 ];
		
		private var _board:String;
		/**
		 * キーボードの種類です。
		 * @see org.libspark.typas.TypeConfig.board
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
				_init();
			}
		}
		
		function TypeHands( typing:Typing = null, x:Number = 0, y:Number = 0 ) {
			this.typing = typing
			this.x = x;
			this.y = y;
			this.board = TypeConfig.board;
		}
		
		
		//typingの現状を読み込んで次に打つべきキーのヒントを出力します。
		private function read( e:Event ):void {
			for each( var f:TypeFinger in _fingers ) { f.up(); }
			var next:Array = _typing.next;
			if (! next ) { return; }
			var l:int = next.length;
			
			for ( var i:int = 0; i < l; i++ ) {
				var str:String = next[i];
				for each( f in _fingers ) {
					if( f.key.indexOf( str ) != -1 ){
						if ( i == 0) { f.down(); }
						else if( f.state == "up" ){ f.over(); }
					}else if ( f.shift.indexOf( str ) != -1 ) { 
						if ( i == 0) { f.down(); _fingers[0].down(); _fingers[9].down() }
						else if( f.state == "up" ){ f.over(); }
					}
				}
			}
		}
		
		private function _init():void{
			var m:Shape = new Shape;
			m.graphics.beginFill( 0xFF );
			m.graphics.drawRect( 0, 0, 600, 40 );
			addChild( m );
			mask = m;
			
			var f:Sprite;
			var x:Number = 0;
			
			for ( var i:Number = 0; i < 10; i++ ) {
				f = new TypeFinger( L[i] );
				x += X[i];
				f.x = x;
				_fingers.push( f );
				addChild( f );
			}
			
			var row:String, l:int;
			for each( row in keys ) {
				l = row.length;
				for ( i = 0; i < l; i++ ) {
					_fingers[ TypeData.FINGER[i] ].key += row.substr( i, 1 );
				}
			}
			for each( row in shiftKeys ) {
				l = row.length;
				for ( i = 0; i < l; i++ ) {
					_fingers[ TypeData.FINGER[i] ].shift += row.substr( i, 1 );
				}
			}
			_fingers[ 4 ].key = " ";
			_fingers[ 5 ].key = " ";
		}
		
	}
}

import flash.display.*;
import org.libspark.typas.acss.TypeStyle;
class TypeFinger extends Sprite{
	private var shapes:Vector.<Shape> = new Vector.<Shape>;
	public var state:String = "";
	public var key:String = "";
	public var shift:String = "";
	function TypeFinger( length:Number ) {
		var h:Number = 40;
		var w:Number = 40;
		
		for ( var i:int = 0; i < 3; i++ ) {
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.lineStyle( 2, TypeStyle.color1 );
			g.beginFill( [TypeStyle.color5, TypeStyle.color4, TypeStyle.color3][i] );
			g.drawRoundRect( 0, h - length, w-2, length + 30, 30 );
			shapes.push( s );
			addChild( s );
		}
		shapes[1].visible = false;
		shapes[2].visible = false;
	}
	public function down():void{
		shapes[0].visible = false;
		shapes[1].visible = false;
		shapes[2].visible = true;
		state = "down"
	}
	public function over():void{
		shapes[0].visible = false;
		shapes[1].visible = true;
		shapes[2].visible = false;
		state = "over"
	}
	public function up():void{
		shapes[0].visible = true;
		shapes[1].visible = false;
		shapes[2].visible = false;
		state = "up"
	}
}