package org.libspark.typas.acss {
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontWeight;
	import flash.text.TextFormat;
	
	/**
	 * タイピング用アクセサリのスタイルを設定するための静的クラスです。
	 * @see TypePanel 
	 * @see TypeWordPanel 
	 * @see TypeKeyboard 
	 * @see TypeHands 
	 * @see TypeButton 
	 * @see TypeText 
	 * @author shohei909
	 */
	public class TypeStyle{
		/** クリーム系の配色です。　*/
		static public const CREAM:Object = 
		{ color5:0xFDF0D0, color4:0xDDBB99, color3:0xDDAA77, color1:0x665544, color2:0xEE9955 }
		/** 暗いの配色です。　*/
		static public const DARK:Object = 
		{ color5:0x111116, color4:0x1155CC, color3:0xFF4411, color1:0xDDDDEE, color2:0xDD3333 }
		/** 配色です。 */
		static public const SWEET:Object = 
		{ color5:0x3D7F7F, color4:0x858383, color3:0xA38282, color2:0xC28080, color1:0xFFFFFF }
		/** 配色です。 */
		static public const ITALIAN:Object = 
		{ color4:0xA62424, color5:0xBF863F, color3:0x43732D, color1:0xFFFFFF, color2:0x8C4820 }
		/** 配色です。 */
		static public const TIGER:Object = 
		{ color1:0x000000, color2:0x646639, color4:0xB29B2E, color5:0xF2E971, color3:0xD9561C }
		/** 配色です。 */
		static public const SWALLOW:Object = 
		{ color1:0xFFFFFF, color2:0xEEEFFF, color4:0x5C6173, color5:0x010712, color3:0x961227 }
		/** 配色です。 */
		static public const MINT:Object = 
		{ color5:0x649670, color2:0x36291E, color1:0x000000, color4:0x92E57C, color3:0xC5FF84 }
		/** 配色です。 */
		static public const SAKURA:Object = 
		{ color3:0x3C4631, color1:0x9A746F, color4:0xF8A2AB, color5:0xF4C6B3, color2:0xFFFED1 }
		/** 配色です。 */
		static public const COOKIE:Object = 
		{ color3:0x468966, color5:0xFFF0A5, color4:0xFFB03B, color2:0xB64926, color1:0x8E2800 }
		/** 配色です。 */
		static public const MONOTONE:Object = 
		{ color3:0x444444, color5:0xFFFFFF, color4:0xCCCCCC, color2:0x888888, color1:0x000000 }
		/** 配色です。 */
		static public const SEPIA:Object = 
		{ color1:0x322E25, color2:0x40392C, color3:0x706350, color4:0xB2A489, color5:0xEEDBBB }
		/** 配色です。 */
		static public const CHOCOLATE:Object = 
		{ color1:0xFFF1CC, color2:0xDBD1BC, color3:0x4999C3, color4:0xAB926D, color5:0x45291A }
		
		static private const DEFAULT:Object = CREAM;
		
		/** 色1　通常の文字など */
		static public var color1:uint = DEFAULT.color1;
		/** 色2 メッセージの文字など　*/
		static public var color2:uint = DEFAULT.color2;
		/** 色3 アクティブな文字、アクセサリなど　*/
		static public var color3:uint = DEFAULT.color3;
		/** 色4 準アクティブな文字、アクセサリなど　*/
		static public var color4:uint = DEFAULT.color4;
		/** 色5　アクセサリの通常色など　*/
		static public var color5:uint =  DEFAULT.color5;
		
		static private var _font:FontDescription = new FontDescription( "ヒラギノ角ゴ Pro W3,メイリオ,Osaka-Mono,Takaoフォント,IPAフォント,MS PGothic,MS Gothic,,_serif"/*, FontWeight.BOLD*/ );
		static public function get font():FontDescription { return _font; }
		
		/**
		 * オブジェクトを指定してスタイルを一括設定します。styleに指定できるオブジェクトはCREAMとDARKがあります。
		 * @param	style
		 */
		static public function setStyle( style:Object ):void {
			TypeStyle.color5 = style.color5;
			TypeStyle.color4 = style.color4;
			TypeStyle.color3 = style.color3;
			TypeStyle.color1 = style.color1;
			TypeStyle.color2 = style.color2;
			
			var formats:Array;
			var f:ElementFormat;
			
			//color1 
			formats = [
				TypePanel.wordFormat,
				TypePanel.kanaFormat,
				TypePanel.untypedFormat,
				TypeWordPanel.wordFormat,
				TypeWordPanel.kanaFormat,
				TypeWordPanel.untypedFormat,
				TypeText.defaultFormat,
				TypeKey.format
			];
			for each( f in formats ) {
				f.color = color1;
			}
			
			//color3 
			formats = [
				TypePanel.nextFormat,
				TypeWordPanel.nextFormat
			];
			for each( f in formats ) {
				f.color = color3;
			}
			//color4 
			formats = [
				TypePanel.typedFormat,
				TypeWordPanel.typedFormat
			];
			for each( f in formats ) {
				f.color = color4;
			}
			
			//color2 
			formats = [
				TypePanel.messageFormat,
				TypeWordPanel.messageFormat,
				TypeMessage.format
			];
			for each( f in formats ) {
				f.color = color2;
			}
		}
		
		static public function setFont( font:FontDescription ):void {
			var formats:Array = [
				TypePanel.wordFormat,
				TypePanel.kanaFormat,
				TypePanel.typedFormat,
				TypePanel.untypedFormat,
				TypePanel.nextFormat,
				TypeWordPanel.wordFormat,
				TypeWordPanel.kanaFormat,
				TypeWordPanel.typedFormat,
				TypeWordPanel.untypedFormat,
				TypeWordPanel.nextFormat,
				TypePanel.messageFormat,
				TypeWordPanel.messageFormat,
				TypeMessage.format,
				TypeText.defaultFormat,
				TypeKey.format
			];
			
			_font = font;
			for each( var f:ElementFormat in formats ) {
				f.fontDescription = font.clone();
			}
		}
		
	}
}