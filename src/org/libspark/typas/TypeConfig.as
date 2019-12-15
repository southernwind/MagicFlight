package org.libspark.typas 
{
	/**
	 * タイピングゲームの設定を行うクラスです。
	 * @author shohei909
	 */
	public class TypeConfig {
		/** タイピングゲームで使用する。「ゐ」、「ゑ」を使いたい場合や、ローマ字の優先順位を変更したい時に変更します。 　*/
		static public var option:TypeOption = new TypeOption;
		static public const QWERTY:String = "qwerty";
		static public const DVORAK:String = "dvorak";
		static public const CR_LF:String = "\r\n";
		static public const CR:String = "\r";
		static public const LF:String = "\n";
		/** 改行コードです。デフォルトではCR_LFです。 */
		static public var enter:String = CR_LF;
		/** キーボード配列です。"qwerty"か"dvorak"を指定してください。 */
		static public var board:String = QWERTY;
		/** 単語の末尾にスペースを追加するかどうかのBooleanです。 */
		static public var space:Boolean = false;
	}
}