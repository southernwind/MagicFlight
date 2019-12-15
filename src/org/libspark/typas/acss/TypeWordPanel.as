package org.libspark.typas.acss {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.engine.ElementFormat;
	import org.libspark.typas.TypeEvent;
	import org.libspark.typas.TypeWord;
	import org.libspark.typas.Typing;
	/**
	 * 単語を指定してその入力に連動した表示をします。
	 * @see org.libspark.typas.TypeWord
	 * @see TypeStyle
	 * @author shohei909
	 */
	public class TypeWordPanel extends Sprite {
		private var _typing:Typing;
		public function get typing():Typing { return _typing; }
		
		private var _word:TypeWord;
		public function get word():TypeWord { return _word; }
		
		//public function get isTarget():TypeWord { return _word.isTarget; }
		
		public var background:Shape = new Shape;
		
		private var _w:Number
		private var _h:Number;
		private var _text:Sprite = new Sprite;
		private var _panel:Sprite = new Sprite;

		public var wordLabel:TypeText;
		public var kanaLabel:TypeText;
		public var romanLabel:TypeGroupText;
		public var messageLabel:TypeText;
		
		static public var wordFormat:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 15, TypeStyle.color1 );
		static public var kanaFormat:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 9, TypeStyle.color1 );
		static public var untypedFormat:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 12, TypeStyle.color1 );
		static public var nextFormat:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 30, TypeStyle.color3 );
		static public var typedFormat:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 12, TypeStyle.color4 );
		static public var messageFormat:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 40, TypeStyle.color2 );
		
		public function TypeWordPanel( word:TypeWord, x:Number = 0, y:Number = 0, width:Number = 200, height:Number = 100 ) {
			this.x = x;
			this.y = y;
			_w = width; _h = height;
			
			addChild( _panel )
			
			var _mask:Shape = new Shape;
			var g:Graphics;
			g = _mask.graphics
			g.beginFill(0)
			g.drawRoundRect(0, 0, _w, _h, 30 );
			this.mask = _mask; 
			_panel.addChild( _mask );
			
			g = background.graphics
			g.lineStyle( 4, TypeStyle.color1, 1 );
			g.beginFill( TypeStyle.color5, 1 );
			g.drawRoundRect(0, 0, _w, _h, 30 );
			_panel.addChild( background )
			
			_panel.addChild( _text );
			
			kanaLabel = new TypeText( "", kanaFormat.clone() );
			wordLabel = new TypeText( "", wordFormat.clone() );
			romanLabel = new TypeGroupText( Vector.<String>( ["","",""]), Vector.<ElementFormat>([typedFormat.clone(), nextFormat.clone(), untypedFormat.clone()]) );
			messageLabel = new TypeText( "", messageFormat.clone() );
			
			_text.addChild( kanaLabel );
			_text.addChild( wordLabel );
			_text.addChild( romanLabel );
			_panel.addChild( messageLabel );
			
			_word = word;
			_typing = word.typing;
			
			kanaLabel.text = _word.kana;
			wordLabel.text = _word.word;
			
			addEventListener( Event.ADDED_TO_STAGE, _added, false, 0, true );
		}
		private function _added( e:Event ):void {
			removeEventListener( Event.ADDED_TO_STAGE, _added );
			_typing.addEventListener( TypeEvent.TYPED, _update, false, 0, true );
			_typing.addEventListener( Event.INIT, _update, false, 0, true );
			addEventListener( Event.REMOVED_FROM_STAGE, _removed, false, 0, true );
			update();
		}
		private function _removed( e:Event ):void{
			removeEventListener( Event.REMOVED_FROM_STAGE, _removed );
			_typing.removeEventListener( TypeEvent.TYPED, _update );
			_typing.removeEventListener( Event.INIT, _update );
			addEventListener( Event.ADDED_TO_STAGE, _added, false, 0, true );
		}

		
		private function _update( e:Event = null ):void { update(); }
		
		private var _typed:String = "";
		private var _untyped:String = "";
		private var _next:String = "";
		
		public function update():void {
			var typed:String, next:String, untyped:String;
			_text.alpha = 1;
			if ( _word.isActive ) {
				var l:int = typing.text.length;
				typed = typing.text;
				next = word.roman.substr( l, 1 )
				untyped = word.roman.substr( l + 1 );
				_panel.alpha = 1;
				if ( next == " " ) { 
					messageLabel.text = "SPACE";
					t = messageLabel;
					t.y = _h / 2 - t.height/ 2;
					t.x = _w / 2 - t.width / 2;
					_text.alpha = 0.23;
				}else if( messageLabel.text != "" ){ 
					messageLabel.text = "";
				}
			}else{
				typed = "";
				next = ""
				untyped = word.roman.substr( 0 );
				_panel.alpha = 0.25;
			}
			
			if( typed != _typed || next != _next || untyped != _untyped ){
				romanLabel.setText( typed, next, untyped );
				_typed = typed;
				_next = next;
				_untyped = untyped;
				
				var t:Sprite;
				var y:Number = 5;
				
				t = kanaLabel;
				if( t.visible == true && t.height > 0 ){
					t.y = y;
					t.x = _w / 2 - t.width/2;
					y += t.height + 5;
				}
				
				t = wordLabel;
				if( t.visible == true && t.height > 0 ){
					t.y = y;
					t.x = _w / 2 - t.width/2;
					y += t.height + 5;
				}
				
				t = romanLabel;
				if ( t.visible == true && t.height > 0 ) {
					t.y = y;
					t.x = _w / 2 - t.width/2;
					y += t.height + 5;
				}
				
				_text.y = ( _h - y ) / 2;
			}
		}
	}
}