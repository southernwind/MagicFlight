package org.libspark.typas.acss 
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import org.libspark.typas.TypeConfig;
	/**
	 * キーボードに使われるエンターキーのクラスです。
	 */
	public class TypeEnterKey extends TypeKey{
		private var w2:Number;
		private var h2:Number;
		function TypeEnterKey ( width:Number, width2:Number, height:Number, height2:Number ){
			w2 = width2; h2 = height2;
			super( width, height, "Enter", "Enter", 13 );
			key = TypeConfig.enter;
			shiftKey = TypeConfig.enter; 
		}
		override public function draw():void{
			var g:Graphics = this.graphics;
			g.clear();
			g.beginFill( fillColor, 1 );
			g.lineStyle( 2, lineColor );
			var l:Function = g.lineTo;
			var c:Function = g.curveTo;
			var r:Number = 8;
			var x0:Number = 0, x1:Number = w - w2, x2:Number = w;
			var y0:Number = 0, y1:Number = h, y2:Number = h2;
			g.moveTo( x0, y0 + r );
			l( x0, y1 - r ); c( x0, y1, x0 + r, y1 );
			l( x1 , y1 );
			l( x1, y2 - r ); c( x1, y2, x1 + r, y2 );
			l( x2 - r, y2 ); c( x2, y2, x2, y2 - r );
			l( x2, y0 + r ); c( x2, y0, x2 - r, y0 );
			l( x0 + r, y0 ); c( x0, y0, x0, y0 + r );
			 
			
			g.endFill(); 
			g.lineStyle( 1, 0xFFFFFF, 0.5 );  
			x0 = 4, x1 = w - w2 + 4, x2 = w - 4;
			y0 = 1, y1 = h - 10, y2 = h2 - 10;
			g.moveTo( x0, y0 );
			l( x0, y1 ); l( x1, y1 ); l( x1, y2 ); l( x2, y2 ); l( x2, y0 );    
		}
	}

}