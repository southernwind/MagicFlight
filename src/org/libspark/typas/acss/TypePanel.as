package org.libspark.typas.acss 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.engine.ElementFormat;
	import org.libspark.typas.TypeEvent;
	import org.libspark.typas.TypeWord;
	import org.libspark.typas.Typing;

	/**
	 * Typingを監視して、タイプ中の単語を自動で表示します。
	 * @see TypeStyle
	 * @author shohei909
	 */
	public class TypePanel extends Sprite{
		private var _typing:Typing;
		public function set typing( t:Typing ):void{ _removeTyping(); _addTyping( t ); }
		public function get typing():Typing { return _typing; }
		
		public var background:Shape = new Shape;
		
		public var _w:Number
		public var _h:Number;
		public var _text:Sprite = new Sprite;
		private var _panel:Sprite = new Sprite;
		
		
		public var word:TypeText;
		public var kana:TypeText;
		public var roman:TypeGroupText;
		public var message:TypeText;
		
		static public var wordFormat:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 20, TypeStyle.color1 );
		static public var kanaFormat:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 11, TypeStyle.color1 );
		static public var untypedFormat:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 15, TypeStyle.color1 );
		static public var nextFormat:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 15, TypeStyle.color1 ); //new ElementFormat( TypeStyle.font.clone(), 38, TypeStyle.color3 );
		static public var typedFormat:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 15, TypeStyle.color4 );
		static public var messageFormat:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 50, TypeStyle.color2 );
		
		/**
		 * ssi
		 * @param	typing タイピングゲーム
		 * @param	width パネルの幅
		 * @param	height パネルの高さ
		 */
		function TypePanel( typing:Typing, x:Number = 0, y:Number = 0, width:Number = 600, height:Number = 120 ){
			this.typing = typing;
			this.x = x;
			this.y = y;
			_w = width;
			_h = height;
			
			addChild( _panel )
			
			var _mask:Shape = new Shape;
			var g:Graphics;
			g = _mask.graphics
			g.beginFill(0)
			g.drawRoundRect(0, 0, _w, _h, 30 );
			this.mask = _mask; 
			//_panel.addChild( _mask );
			
			g = background.graphics
			g.beginFill( TypeStyle.color5 );
			g.drawRoundRect(0, 0, _w, _h, 30 );
			//_panel.addChild( background )
			
			_panel.addChild( _text )
			
			kana = new TypeText( "", kanaFormat.clone() );
			word = new TypeText( "", wordFormat.clone() );
			roman = new TypeGroupText( Vector.<String>( ["","",""]), Vector.<ElementFormat>([typedFormat.clone(), nextFormat.clone(), untypedFormat.clone()]) );
			message = new TypeText( "", messageFormat.clone() );
			
			_text.addChild( kana );
			_text.addChild( word );
			_text.addChild( roman );
			_panel.addChild( message );
			
		}

		private function _addTyping( typing:Typing ):void {
			if (! typing ) { return; }
			_typing = typing
			_typing.addEventListener( TypeEvent.WORD_ADDED , _update, false, 0, true );
			_typing.addEventListener( TypeEvent.WORD_REMOVED, _update, false, 0, true );
			_typing.addEventListener( TypeEvent.TYPED, _update, false, 0, true );
			_typing.addEventListener( Typing.MESSAGE, _update, false, 0, true );
			_typing.addEventListener( Event.INIT, _update, false, 0, true );
		}
		private function _removeTyping():void {
			if (! _typing ) { return; }
			_typing.removeEventListener( TypeEvent.WORD_ADDED , _update );
			_typing.removeEventListener( TypeEvent.WORD_REMOVED, _update );
			_typing.removeEventListener( TypeEvent.TYPED, _update );
			_typing.removeEventListener( Typing.MESSAGE, _update );
			_typing.removeEventListener( Event.INIT, _update );
		}
		
		private function _update( e:Event = null ):void {
			var typed:String, next:String, untyped:String;
			if( typing.active.length == 1 ){
				var wd:TypeWord = typing.active[0];
				var l:int = typing.text.length;
				kana.text = wd.kana;
				word.text = wd.word;
				typed = typing.text;
				next = wd.roman.substr( l, 1 )
				untyped = wd.roman.substr( l+1 );
			}else{
				kana.text = "";
				word.text = "";
				typed = typing.text;
				next = "";
				untyped = "";
			}
			roman.setText( typed, next, untyped );
			
			var t:Sprite;
			var y:Number = 0;
			
			if ( next == " " ) { 
				message.text = "SPACE";
				t = message;
				t.y = _h / 2 - t.height/ 2;
				t.x = _w / 2 - t.width / 2;
				_text.alpha = 0.23;
			}else if( message.text != "" ){ 
				message.text = "";
				_text.alpha = 1;
			}
			
			t = kana;
			t.y = y;
			t.x = _w / 2 - t.width/2;
			y += t.height + 5;
			
			t = word;
			t.y = y;
			t.x = _w / 2 - t.width/2;
			y += t.height + 5;
			
			t = roman;
			t.y = y;
			t.x = _w / 2 - t.width/2;
			y += t.height + 5;
			
			_text.y = _h / 2 - y / 2;
		}
	}
}