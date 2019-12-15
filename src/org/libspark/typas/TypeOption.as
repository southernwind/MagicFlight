package org.libspark.typas 
{
	/**
	 * ローマ字入力のオプション設定です。
	 * 「ゑ」,「ゐ」など普通は使われない文字にローマ字を割り当てたり、「ちゃ」,「しゅ」などのデフォルトのローマ字を変更するのに使います。
	 * @see TypeConfig#option
	 * @author shohei909
	 */
	public class TypeOption	{
		/** [[かな,roman],...] */
		public var options:Array = [];
		
		/** ゑをwe,ゐをwiで入力できるようにする。 */
		static public const IROHA:Array = [["ゑ","we"],["ゐ","wi"]];
		/** ちゃ,ちゅ,ちぇ,ちょのデフォルトの入力がcha,chu,che,choになります。 */
		static public const CHA:Array = [["ちゃ", "cha"], ["ちゅ", "chu"], ["ちぇ", "che"], ["ちょ", "cho"]];
		/** しゃ、しゅ、しぇ、しょのデフォルトの入力がsha,shu,she,shoになります。 */
		static public const SHA:Array = [["しゃ", "sha"], ["しゅ", "shu"], ["しぇ", "she"], ["ちょ", "sho"]];
		/** じゃ、じゅ、じぇ、じょのデフォルトの入力がzya,zyu,zye,zyoになります。 */
		static public const ZYA:Array = [["じゃ", "zya"], ["じゅ", "zyu"], ["じぇ", "zye"], ["じょ", "zyo"]];
		
		/** コンストラクタです。 */
		function TypeOption( ...arrays ) {
			options = options.concat.apply( null, arrays );
		}
		
		/**
		 * 新たなオプションを追加します。
		 * @param	array
		 */
		public function addOption( array:Array ):void {
			options.push( array )
		}
		
		/** かなに対応する。ローマ字を返します。 */
		public function romans( kana:String ):Array {
			var l:uint = options.length; 
			var romans:Array = [];
			for ( var i:uint = 0; i < l; i++ ) {
				var option:Array = options[i]
				if ( option[0] == kana ) { romans.push( option[1] ); }
			}
			return romans;
		}
		/** ローマ字に対応するかなを返します。 */
		public function kana( roman:String ):String {
			var l:uint = options.length; 
			for ( var i:uint = 0; i < l; i++ ) {
				var option:Array = options[i]
				if ( option[1] == kana ) { return option[0]; }
			}
			return null;
		}	
	}
}