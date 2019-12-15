package org.libspark.typas.acss 
{
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;
	import flash.display.Graphics;
	import flash.display.Sprite;
	/**
	 * キーボードに使われるキーのクラスです。
	 */
	public class TypeKey extends Sprite 
	{
		public var upFill:uint = TypeStyle.color5;
		public var downFill:uint = TypeStyle.color3;
		public var overFill:uint = TypeStyle.color4;
		public var disableFill:uint = 0x666666;//TypeStyle.disableFill;
		
		public var fillColor:uint = upFill;
		public var lineColor:uint = TypeStyle.color1;
		
		private var textLine:TextLine;
		public var textElement:TextElement;
		
		
		public var state:String = "up";
		
		protected var w:Number;
		protected var h:Number;
		
		public var label:String;
		public var shiftLabel:String;
		public var key:String;
		public var shiftKey:String;
		public var code:int; 
		public var shifted:Boolean; 
		public var mark:Boolean;
		
		static private var _format:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 14, TypeStyle.color1 );
		static public function get format():ElementFormat { return _format; }
		
		function TypeKey( width:Number, height:Number, key:String, shiftKey:String, code:Number, mark:Boolean = false ){
			w = width; h = height; this.label = key; this.shiftLabel = shiftKey; this.key = key; this.shiftKey = shiftKey; this.code = code; this.mark = mark
			var format:ElementFormat = _format.clone();
			textElement = new TextElement( "a", format );
			
			draw();
			drawText();
		}

		public function draw():void{
			var g:Graphics = this.graphics;
			g.clear();
			g.beginFill( fillColor, 1 );
			g.lineStyle( 2, lineColor );
			g.drawRoundRect( 0,0, w, h, 8 );
			g.endFill(); 
			
			if( mark ){
				var cw:Number = w/2;
				g.lineStyle( 1, lineColor, 0.8 );
				g.moveTo( cw + 4, h - 13 );
				g.lineTo( cw - 4, h - 13 );
			}

			g.lineStyle( 1, 0xFFFFFF, 0.5 );
			g.moveTo( 5, 1 );
			g.lineTo( 5, h-10 );
			g.lineTo( w-5 , h-10 );
			g.lineTo( w-5 , 1 );
		}
		
		public function drawText():void {
			if( textLine && contains(textLine) ){ removeChild( textLine ); }
			if( shifted ){ textElement.text = shiftLabel; }
			else { textElement.text = label; }
			textLine = new TextBlock( textElement ).createTextLine()
			if (textLine) {
				textLine.x = 8;
				textLine.y = 4 + textLine.ascent;
				addChild( textLine );
			}
		}
		public function down():void{
			fillColor = downFill;
			state = "down";
			draw();
		}
		public function over():void{
			fillColor = overFill;
			state = "over";
			draw();
		}
		public function up():void{
			fillColor = upFill;
			state = "up";
			draw();
		}
		public function disable():void{
			fillColor = disableFill;
			state = "disable";
			draw();
		}
		public function shift():void{
			shifted = true;
			drawText();
		}
		public function unshift():void{
			shifted = false;
			drawText();
		}
	}
}