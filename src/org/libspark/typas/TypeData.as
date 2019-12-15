package org.libspark.typas {
	import flash.ui.Keyboard;
	/**
	 * ローマ字リストやキー配列など、タイピングゲームに使われる基本的なデータをおさめた静的クラスです。
	 */
	public class TypeData {
		/** 半角文字のリスト */
		static public const HANKAKU:String = "1234567890-^\\qwertyuiop@[asdfghjkl;:]zxcvbnm,./!\"#$%&'()=~|QWERTYUIOP`{ASDFGHJKL+*}ZXCVBNM<>?_ ";
		
		/** HANKAKUに対応する全角文字のリスト */
		static public const ZENKAKU:String = "１２３４５６７８９０ー＾￥ｑｗｅｒｔｙｕｉｏｐ＠［ａｓｄｆｇｈｊｋｌ；：］ｚｘｃｖｂｎｍ，．／！”＃＄％＆’（）＝～｜ＱＷＥＲＴＹＵＩＯＰ‘｛ＡＳＤＦＧＨＪＫＬ＋＊｝ＺＸＣＶＢＮＭ＜＞？＿ ";
		
		/** かなからローマ字への変換表*/
		static public const ROMANS:Object = {
			"あ":["a"], "う":["u", "wu", "whu"], "い":["i", "yi"], "え":["e"], "お":["o"],
			"か":["ka", "ca"], "き":["ki"], "く":["ku", "cu"], "け":["ke"], "こ":["ko", "co"],
			"さ":["sa"], "し":["si", "shi", "ci"], "す":["su"], "せ":["se", "ce"], "そ":["so"],
			"た":["ta"], "ち":["ti", "chi"], "つ":["tu", "tsu"], "て":["te"], "と":["to"], 
			"な":["na"], "に":["ni"], "ぬ":["nu"], "ね":["ne"], "の":["no"],
			"は":["ha"], "ひ":["hi"], "ふ":["fu", "hu"], "へ":["he"], "ほ":["ho"],
			"ま":["ma"], "み":["mi"], "む":["mu"], "め":["me"],"も":["mo"],
			"や":["ya"], "ゆ":["yu"], "よ":["yo"],
			"ら":["ra"], "り":["ri"],  "る":["ru"], "れ":["re"],"ろ":["ro"],
			"わ":["wa"], "を":["wo"], "ん":["nn","xn"],
			"が":["ga"], "ぎ":["gi"], "ぐ":["gu"], "げ":["ge"],"ご":["go"],
			"ざ":["za"], "じ":["ji", "zi"], "ず":["zu"], "ぜ":["ze"], "ぞ":["zo"],
			"だ":["da"], "ぢ":["di"], "づ":["du"], "で":["de"], "ど":["do"],
			"ば":["ba"], "び":["bi"], "ぶ":["bu"], "べ":["be"], "ぼ":["bo"],
			"ぱ":["pa"], "ぴ":["pi"], "ぷ":["pu"], "ぺ":["pe"], "ぽ":["po"],
			"しゃ":["sya", "sha"], "しゅ":["syu", "shu"], "しょ":["syo", "sho"], "しぃ":["syi"], "しぇ":["sye", "she"],
			"みゃ":["mya"], "みゅ":["myu"], "みょ":["myo"], "みぃ":["myi"], "みぇ":["mye"],
			"きぃ":["kyi"], "きゃ":["kya"], "きゅ":["kyu"], "きぇ":["kye"], "きょ":["kyo"],
			"にゃ":["nya"], "にぃ":["nyi"],  "にゅ":["nyu"], "にぇ":["nye"], "にょ":["nyo"],
			"ちゃ":["tya", "cha", "cya"], "ちぃ":["tyi", "cyi"], "ちゅ":["tyu", "chu", "cyu"], "ちぇ":["tye", "che", "cye"], "ちょ":["tyo", "cho", "cyo"],
			"とぁ":["twa"], "とぃ":["twi"], "とぅ":["twu"], "とぇ":["twe"], "とぉ":["two"],
			"てゃ":["tha"], "てぃ":["thi"], "てゅ":["thu"], "てぇ":["the"], "てょ":["tho"],
			"ひゃ":["hya"], "ひぃ":["hyi"], "ひょ":["hyo"], "ひぇ":["hye"], "ひゅ":["hyu"],
			"りゃ":["rya"], "りぃ":["ryi"], "りゅ":["ryu"], "りぇ":["rye"], "りょ":["ryo"],
			"うぁ":["wa", "wha"], "うぃ":["wi", "whi"], "うぇ":["we", "whe"], "うぉ":["wo", "who"],
			"ヴぁ":["va"], "ヴぃ":["vi"], "ヴ":["vu"], "ヴぇ":["ve"], "ヴぉ":["vo"], "ヴゃ":["vya"], "ヴゅ":["vyu"], "ヴょ":["vyo"],
			"くぁ":["qa", "kwa", "qwa"],  "くぃ":["qi", "qwi", "qyi"],  "くぅ":["qwu", "qwu"], "くぇ":["qe", "qwe", "qye"], "くぉ":["qo", "qwo"], "くゃ":["qya"], "くゅ":["qyu"], "くょ":["qyo"],
			"すぁ":["swa"], "すぃ":["swi"], "すぅ":["swu"], "すぇ":["swe"], "すぉ":["swo"],
			"ふぁ":["fa", "fwa"], "ふぃ":["fi", "fwi", "fyi"], "ふぅ":["fwu"], "ふぇ":["fe", "fwe", "fye"], "ふぉ":["fo", "fwo", "fwo"], "ふゃ":["fya"], "ふゅ":["fyu"], "ふょ":["fyo"],
			"ぎゃ":["gya"], "ぎぃ":["gyi"], "ぎゅ":["gyu"], "ぎぇ":["gye"], "ぎょ":["gyo"],
			"じゃ":["ja", "zya", "jya"], "じぃ":["zyi", "jyi"], "じゅ":["ju", "zyu", "jyu"], "じぇ":["je", "zye", "jye"], "じょ":["jo", "zyo", "jyo"],
			"ぐぁ":["gwa"], "ぐぃ":["gwi"], "ぐぅ":["gwu"], "ぐぇ":["gwe"], "ぐぉ":["gwo"],
			"ぢゃ":["dya"], "ぢぃ":["dyi"], "ぢゅ":["dyu"], "ぢぇ":["dye"], "ぢょ":["dyo"],
			"どぁ":["dwa"], "どぃ":["dwi"], "どぅ":["dwu"], "どぇ":["dwe"], "どぉ":["dwo"],
			"でゃ":["dha"], "でぃ":["dhi"], "でゅ":["dhu"], "でぇ":["dhe"], "でょ":["dho"],
			"びゃ":["bya"], "びぃ":["byi"], "びゅ":["byu"], "びぇ":["bye"], "びょ":["byo"],
			"ぴゃ":["pya"], "ぴぃ":["pyi"], "ぴょ":["pyo"], "ぴぇ":["pye"], "ぴゅ":["pyu"],
			"つぁ":["tsa"], "つぃ":["tsi"], "つぇ":["tse"], "つぉ":["tso"],
			"いぇ":["ye"],
			"ぁ":["la", "xa"], "ぃ":["li", "xi", "lyi", "xyi"], "ぅ":["lu", "xu"], "ぇ":["le","xe","lye","xye"], "ぉ":["lo","xo"],
			"ゃ":["lya","xya"],"ゅ":["lyu","xyi"],"ょ":["lyo","xyu"],"ゎ":["lwa","xwa"],
			"っ":["ltu","ltsu"],"ヶ":["lke","xke"],"ヵ":["lka","xka"],
			"「":["["], "」":["]"], "。":["."], "、":[","]
		}
		
		/** ローマ字からかなへの変換表  */
		static public const KANA:Object = {
			qwa:"くぁ", qa:"くぁ", bye:"びぇ", kwa:"くぁ", sho:"しょ", syu:"しゅ", byo:"びょ", byu:"びゅ", syi:"しぃ", pya:"ぴゃ",
			sye:"しぇ", qi:"くぃ", shu:"しゅ", ti:"ち", qwi:"くぃ", qe:"くぇ", qyi:"くぃ", pyo:"ぴょ", cu:"く", tu:"つ", qwu:"くぅ",
			kya:"きゃ", pyi:"ぴぃ", qo:"くぉ", chi:"ち", pyu:"ぴゅ", kyi:"きぃ", she:"しぇ", qye:"くぇ", tsa:"つぁ", pye:"ぴぇ",
			qwe:"くぇ", qya:"くゃ", kyu:"きゅ", tsu:"つ", tsi:"つぃ", kye:"きぇ", te:"て", nu:"ぬ", qyu:"くゅ", to:"と", qwo:"くぉ",
			ne:"ね", tse:"つぇ", kyo:"きょ", "]":"」", no:"の", tso:"つぉ", "[":"「", qyo:"くょ", xa:"ぁ", na:"な", ha:"は", ye:"いぇ",
			swa:"すぁ", li:"ぃ", nya:"にゃ", swo:"すぉ", la:"ぁ", swi:"すぃ", lyi:"ぃ", nyi:"にぃ", xyi:"ゅ", swe:"すぇ", ku:"く", 
			swu:"すぅ", ke:"け", nyu:"にゅ", fa:"ふぁ", myi:"みぃ", nyo:"にょ", xu:"ぅ", nye:"にぇ", ni:"に", lu:"ぅ", mya:"みゃ",
			e:"え", hi:"ひ", fyi:"ふぃ", fwa:"ふぁ", i:"い", fwi:"ふぃ", myo:"みょ", fu:"ふ", le:"ぇ", fi:"ふぃ", xi:"ぃ", hu:"ふ",
			xe:"ぇ", mye:"みぇ", o:"お", lye:"ぇ", ho:"ほ", he:"へ", u:"う", myu:"みゅ", sa:"さ", cha:"ちゃ", fwu:"ふぅ", cya:"ちゃ",
			xye:"ぇ", co:"こ", fe:"ふぇ", ma:"ま", tyi:"ちぃ", fwe:"ふぇ", tya:"ちゃ", cyi:"ちぃ", fye:"ふぇ", mi:"み", xya:"ゃ",
			lo:"ぉ", tyu:"ちゅ", lya:"ゃ", xo:"ぉ", lyu:"ゅ", fwo:"ふぉ", cyu:"ちゅ", mo:"も", fo:"ふぉ", lyo:"ょ", chu:"ちゅ",
			mu:"む", xyu:"ょ", ya:"や", che:"ちぇ", fyu:"ふゅ", me:"め", fya:"ふゃ", cye:"ちぇ", tye:"ちぇ", shi:"し", a:"あ",
			xwa:"ゎ", fyo:"ふょ", ri:"り", lwa:"ゎ", yu:"ゆ", cho:"ちょ", gya:"ぎゃ", ru:"る", tyo:"ちょ", yo:"よ", ci:"し",
			ltu:"っ", twi:"とぃ", cyo:"ちょ", ra:"ら", lka:"ヵ", gyu:"ぎゅ", gyi:"ぎぃ", xka:"ヵ", lke:"ヶ", ltsu:"っ", ja:"じゃ",
			xke:"ヶ", ko:"こ", re:"れ", twa:"とぁ", zya:"じゃ", gyo:"ぎょ", gye:"ぎぇ", jya:"じゃ", twu:"とぅ", jyi:"じぃ", su:"す",
			zyi:"じぃ", twe:"とぇ", ro:"ろ", ju:"じゅ", si:"し", two:"とぉ", wa:"うぁ", jyu:"じゅ", zyu:"じゅ", tha:"てゃ", wo:"うぉ",
			je:"じぇ", thu:"てゅ", thi:"てぃ", nn:"ん", xn:"ん", jye:"じぇ", tho:"てょ", gi:"ぎ", ga:"が", jo:"じょ", zyo:"じょ", zye:"じぇ",
			jyo:"じょ", hyi:"ひぃ", ge:"げ", the:"てぇ", gwa:"ぐぁ", hyo:"ひょ", hya:"ひゃ", zi:"じ", gu:"ぐ", hye:"ひぇ", za:"ざ",
			go:"ご", gwu:"ぐぅ", hyu:"ひゅ", ji:"じ", gwe:"ぐぇ", ce:"せ", rya:"りゃ", gwo:"ぐぉ", zu:"ず", gwi:"ぐぃ", ryi:"りぃ",
			dya:"ぢゃ", ze:"ぜ", se:"せ", dyi:"ぢぃ", zo:"ぞ", ".":"。", so:"そ", dyu:"ぢゅ", da:"だ", rye:"りぇ", ",":"、", dye:"ぢぇ",
			di:"ぢ", ryo:"りょ", ryu:"りゅ", dyo:"ぢょ", du:"づ", wha:"うぁ", ta:"た", whi:"うぃ", de:"で", wi:"うぃ", dwa:"どぁ",
			"do":"ど", whe:"うぇ", dwi:"どぃ", ba:"ば", who:"うぉ", ki:"き", dwu:"どぅ", we:"うぇ", va:"ヴぁ", dwe:"どぇ", bu:"ぶ",
			bi:"び", vi:"ヴぃ", dwo:"どぉ", be:"べ", ka:"か", ca:"か", dha:"でゃ", bo:"ぼ", vu:"ヴ", dhi:"でぃ", pa:"ぱ", ve:"ヴぇ",
			dhu:"でゅ", pi:"ぴ", vo:"ヴぉ", dhe:"でぇ", pu:"ぷ", vya:"ヴゃ", dho:"でょ", pe:"ぺ", wu:"う", yi:"い", bya:"びゃ",
			po:"ぽ",vyo:"ヴょ",vyu:"ヴゅ",byi:"びぃ",sya:"しゃ",whu:"う",sha:"しゃ",syo:"しょ"
		}
		
		/** nのうしろに来てもnが「ん」にならない文字 */
		static public const NN:String = "euioany";
		
		/** 二つ続くと「っ」になる文字 */
		static public const LTU:String = "qwrtypsdfghjklzxcvbm";
		
		static public const CODE48:String = "0123456789"; 
		static public const CODE65:String = "abcdefghijklmnopqrstuvwxyz"; 
		static public const CODE186:String = ":;,-./@"; 
		static public const CODE219:String = "[￥]^"; 
		static public const CODE226:String = "\\"; 
		
		/** 使用する指を記録した配列 */
		static public const FINGER:Array = [0,1,2,3,3,6,6,7,8,9,9,9,9];
		/** qwerty配列 */
		static public const QWERTY_KEY:Array = [ "1234567890-^￥", "qwertyuiop@[", "asdfghjkl;:]", "zxcvbnm,./\\" ];
		/** シフト時のqwerty配列 */
		static public const QWERTY_SHIFT:Array = [ "!\"#$%&'()　=~|", "QWERTYUIOP`{", "ASDFGHJKL+*}", "ZXCVBNM<>?_" ];
		/** dvorak配列 */
		static public const DVORAK_KEY:Array = [ "1234567890[]￥", ":,.pyfgcrl/@", "aoeuidhtns-^", ";qjkxbmwvz\\" ];
		/** シフト時のdvorak配列 */
		static public const DVORAK_SHIFT:Array = [ "!\"#$%&'()　{}|", "*<>PYFGCRL?`", "AOEUIDHTNS=~", "+QJKXBMWVZ_" ]
		/** かな入力配列 */
		static public const KANA_KEY:Array = [ "ぬふあうえおやゆよわほへー", "たていすかんなにらせ゛゜", "ちとしはきくまのりれけむ", "つさそひこみもねるめろ" ];
		/** シフト時のかな入力配列 */
		static public const KANA_SHIFT:Array = [ "ぬふぁぅぇぉゃゅょをほへー", "たてぃすかんなにらぜ「", "ちとしはきくまのりれけ」", "っさそひこみも、。・ろ" ]
		/** キーボードの左側のスペースの大きさ　*/
		static public const BOARD_INDENT:Array = [ 1, 1.5, 1.8, 2.3, 5 ];
	}
}