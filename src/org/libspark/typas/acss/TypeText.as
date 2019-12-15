package org.libspark.typas.acss 
{
	import flash.display.Sprite;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;
	/**
	 * TypeStyleに従って作成されるテキストです。
	 * @author shohei909
	 */
	public class TypeText extends Sprite{
		public var element:TextElement;
		public function set text( s:String ):void { element.text = s; update(); }
		public function get text():String { return element.text; }
		public var block:TextBlock;
		
		static public var defaultFormat:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 20, TypeStyle.color1 );
		
		private var _align:String = "left"
		public function set align( s:String ):void { _align = s; update(); }
		public function get align():String { return _align; }
		
		public var ALIGN_LEFT:String = "left";
		public var ALIGN_CENTER:String = "center";
		public var ALIGN_RIGHT:String = "right";
		
		function TypeText( text:String = "", format:ElementFormat = null, x:Number = 0, y:Number = 0, align:String = "left" ){
			this.x = x;
			this.y = y;
			this._align = align;
			if (! format ) { format = defaultFormat.clone(); } 
			element = new TextElement( text, format );
			update();
		}
		
		/** フォーマットの設定を反映させます */
		public function update():void {
			if( block ){
				var l:TextLine = block.firstLine;
				while ( l ) {
					removeChild( l );
					l = l.nextLine;
				}
			}
			block = new TextBlock( element )
			l = block.createTextLine();
			var y:Number = 0;
			while( l ){
				l.y = l.ascent + y;
				switch( _align ){
					case ALIGN_LEFT:
						l.x = 0;
						break;
					case ALIGN_CENTER:
						l.x = -l.width / 2;
						break;
					case ALIGN_RIGHT:
						l.x = -l.width;
						break
				}
				y += l.height + 1;
				addChild( l );
				l = block.createTextLine( l );
			}
		}
	}

}