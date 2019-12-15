package org.libspark.typas.acss 
{
	import flash.display.Graphics;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.engine.ElementFormat;
	/**
	 * TypeStyleに従ったボタンのクラスです。
	 * @see TypeStyle
	 * @author shohei909
	 */
	public class TypeButton extends SimpleButton{
		static public var defaultFormat:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 15, TypeStyle.color1 );
		
		function TypeButton( text:String, onDown:Function = null, x:Number = 0, y:Number = 0, width:Number = 150, height:Number = 30 ) {
			if ( onDown != null ) { addEventListener( MouseEvent.MOUSE_DOWN, onDown ); }
			this.x = x;
			this.y = y;
			var s:Sprite;
			var g:Graphics, l:TypeText;
			var u:Sprite = new Sprite();
			var d:Sprite = new Sprite();
			var o:Sprite = new Sprite();
			var t:Number = 2;
			var r:Number = 10;
			
			s = u;
			g = s.graphics;
			g.beginFill( TypeStyle.color3 );
			g.lineStyle( t, TypeStyle.color1 )
			g.drawRoundRect( 0, 0, width, height, r );
			l = new TypeText( text, defaultFormat.clone(), width/2, 0, "center" );
			l.y = (height - l.height) / 2;
			s.addChild(l);
			
			s = o;
			g = s.graphics;
			g.beginFill( TypeStyle.color3 );
			g.lineStyle( t, TypeStyle.color1 )
			g.drawRoundRect( 0, 0, width, height, r );
			l = new TypeText( text, defaultFormat.clone() );
			l.x = (width - l.width) / 2;
			l.y = (height - l.height) / 2;
			s.addChild(l);
			
			s = d;
			g = s.graphics;
			g.beginFill( TypeStyle.color4 );
			g.lineStyle( t, TypeStyle.color1 )
			g.drawRoundRect( 0, 0, width, height, r );
			l = new TypeText( text, defaultFormat.clone() );
			l.x = (width - l.width) / 2;
			l.y = (height - l.height) / 2;
			s.addChild(l);
			
			
			super( u, o, d, o );
		}
		
	}

}