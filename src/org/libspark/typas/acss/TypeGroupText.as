package org.libspark.typas.acss 
{
	import flash.display.Sprite;
	import flash.text.engine.ContentElement;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.GroupElement;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;
	/**
	 * ...
	 * @author shohei909
	 */
	public class TypeGroupText extends Sprite
	{
		public var element:GroupElement;
		public var line:TextLine;
		
		public function get text():String { 
			return element.text;
		}
		function TypeGroupText( texts:Vector.<String>, formats:Vector.<ElementFormat> = null){
			var elements:Vector.<ContentElement> = new Vector.<ContentElement>;
			var l:int = texts.length;
			for ( var i:int = 0; i < l;  i++ ) {
				var format:ElementFormat = formats[i];
				if ( formats ) { format = formats[i]; }
				if( !format ){ format = new ElementFormat( TypeStyle.font, 40, TypeStyle.color1 ); };
				elements.push( new TextElement( texts[i], format ) );
			}
			element = new GroupElement( elements );
		}
		public function setText( ...texts ):void {
			var l:int = texts.length;
			for ( var i:int = 0; i < l;  i++ ) {
				TextElement( element.getElementAt( i ) ).text = texts[i]; 
			}
			update();
		}
		public function update():void {
			if ( line ) { removeChild( line ); }
			line = new TextBlock( element ).createTextLine();
			if( line ){
				line.y = line.ascent;
				addChild( line );
			}
		}
	}

}