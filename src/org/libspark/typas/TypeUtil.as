package org.libspark.typas
{
	import org.libspark.typas.util.ArrayUtil;
	/**
	 * タイピングゲームに用いられる静的な関数をおさめたクラスです。
	 */
	public class TypeUtil
	{
		/**
		 * ローマ字のかなに変換可能な部分をかなに変換して返します。
		 * @param	roman　変換されるローマ字です。
		 * @param	option オプションです。
		 * @see TypeOption
		 * @return かなです。
		 */ 
		static public function kana( roman:String, option:TypeOption = null ):String {
			if( roman == "" ){ return "" }
			var kana:String;
			for( var i:uint = 3; i > 0; i-- ){
				var subroman:String = roman.substr( 0, i );
				if( option ){ kana = option.kana( subroman ); }
				if( !kana ){ kana = TypeData.KANA[subroman]; }
				if( !kana && i == 1 ){ 
					var next:String = roman.substr( i, 1 );
					var hankaku:int = TypeData.HANKAKU.indexOf( subroman );
					if( subroman == next && TypeData.LTU.indexOf(subroman) != -1 ){ kana = "っ" }
					else if( subroman == "n" && TypeData.NN.indexOf(next) == -1 ){ kana = "ん" }
					else if( hankaku != -1 ){ kana = TypeData.ZENKAKU.substr( hankaku,1 ) }
				}
				if( kana ){ return kana + TypeUtil.kana( roman.substr(i), option ) }
			}
			return "";
		}
		
		/**
		 * 次にタイプできるキーの候補を返します。
		 * @param	kana　入力を行うかなです。
		 * @param	roman　すでに入力されているローマ字です。
		 * @param	option　おぷしょんです。
		 * @see TypeOption
		 * @return	次に入力できるキーを表すStringの配列です。最も単純なキーから順に並んでいます。
		 */
		static public function next( kana:String, roman:String = "", option:TypeOption = null ):Array{
			var next:Array = [];
			if( kana == "" ){ return [] }
			for( var i:uint = 2; i > 0; i-- ){
				var roman2:String = roman;
				var subkana:String = kana.substr( 0, i );
				var nextKana:String = kana.substr( i );
				var subromans:Array = [];
				if ( option ) { ArrayUtil.blend( subromans, option.romans( subkana ) ); }
				
				if ( i == 1 ) {
					var zenkaku:int = TypeData.ZENKAKU.indexOf( subkana );
					var hankaku:int = TypeData.HANKAKU.indexOf( subkana );
					if( subkana == "っ" ){ ArrayUtil.blend( subromans, _preLtu( nextKana, option ) ) }
					else if ( subkana == "ん" ) { ArrayUtil.blend( subromans, _preN( nextKana, option )) }
					else if ( zenkaku != -1 ) { subromans.push( TypeData.HANKAKU.substr( zenkaku,1 ) ); }
					else if ( hankaku != -1 ) { subromans.push( TypeData.HANKAKU.substr( hankaku,1 ) ); }
				}
				ArrayUtil.blend( subromans, TypeData.ROMANS[subkana] );
				var l:uint = subromans.length;
				var flag:Boolean = false;
				while( l > 0 ){
					if( roman2.length == 0 ){ ArrayUtil.blend( next, _firsts(subromans) ); break; }
					var first:String = roman2.substr(0, 1);
					for( var j:uint = 0; j < l; j++ ){
						if( subromans[j].substr( 0, 1 ) == first ){ 
							subromans[j] = subromans[j].substr( 1 );
							if ( subromans[j] == "" ) {	
								ArrayUtil.blend( next, TypeUtil.next( nextKana, roman2.substr(1), option ) );
								subromans.splice(j,1); l--; j--;
							}
						}else{
							subromans.splice(j,1); l--; j--;
						}
					}
					roman2 = roman2.substr(1);
				}
			}
			return next;
		}


		//かなを渡すとそのかなの手前に来ることで「っ」になりうるローマ字を返します。
		static private function _preLtu( kana:String, option:TypeOption ):Array{
			var next:Array = next( kana, "", option );
			var pre:Array = [];
			var l:uint = next.length;
			const LTU:String = TypeData.LTU;

			for( var i:uint = 0; i<l; i++ ){
				var n:String = next[i];
				if( LTU.indexOf(n) != -1 ){ pre.push(n); }
			}
			return pre;
		}

		//かなを渡すとそのかなの手前にn来ることで「ん」になる場合[n]を返します。
		static private function _preN( kana:String, option:TypeOption ):Array{
			var next:Array = next( kana, "", option );
			var l:uint = next.length;
			const NN:String = TypeData.NN;

			for( var i:uint = 0; i<l; i++ ){
				var n:String = next[i];
				if( NN.indexOf(n) == -1 ){ return ["n"]; }
			}
			return [];
		}

		//arrの一文字目の配列を作ります。
		static private function _firsts( arr:Array ):Array {
			var l:uint = arr.length;
			var firsts:Array = [];
			for( var i:uint; i<l; i++ ){
				firsts.push( arr[i].substr(0,1) );
			}
			return firsts;
		}

		/**
		 * かなに対するもっとも簡単なローマ字のふりかたを返します。
		 * @param	kana	入力するかなです。
		 * @param	roman	すでに入力されているローマ字です。
		 * @param	option	オプションです。
		 * @return	もっとも単純なローマ字入力です。
		 */
		static public function simplestRoman( kana:String, roman:String = "", option:TypeOption = null ):String {
			if ( roman == "" ) { return _simplestRoman( kana, option); }
			for ( var i:uint = 2; i > 0; i-- ) {
				var roman2:String = roman;
				var subkana:String = kana.substr( 0, i );
				var nextKana:String = kana.substr( i );
				var subromans:Array = [];
				
				if ( option ) { ArrayUtil.blend( subromans, option.romans( subkana ) ); }
				
				if ( i == 1 ) {
					var zenkaku:int = TypeData.ZENKAKU.indexOf( subkana );
					var hankaku:int = TypeData.HANKAKU.indexOf( subkana );
					if( subkana == "っ" ){ ArrayUtil.blend( subromans, _preLtu( nextKana, option ) ) }
					else if ( subkana == "ん" ) { ArrayUtil.blend( subromans, _preN( nextKana, option )) }
					else if ( zenkaku != -1 ) { subromans.push( TypeData.HANKAKU.substr( zenkaku,1 ) ); }
					else if ( hankaku != -1 ) { subromans.push( TypeData.HANKAKU.substr( hankaku,1 ) ); }
				}
				ArrayUtil.blend( subromans, TypeData.ROMANS[subkana] );

				var l:uint = subromans.length;
				for( var j:uint = 0; j < l; j++ ){
					var subroman:String = subromans[j];
					var rl:uint = subroman.length;
					var c:uint = 0;
					while ( true ) {
						var one:String = roman2.substr( c, 1 );
						if( subroman.indexOf( one, c ) == c ){
							if ( rl == c + 1 ) {
								var next:String = simplestRoman( nextKana, roman2.substr(rl), option );
								if ( next != null ) { return subroman + next }
								break
							}
						}else { break; }
						c++;
					}
				}
			}
			return null;
		}
		
		//かなに対するもっとも簡単なローマ字のふりかたを返します。
		static private function _simplestRoman( kana:String, option:TypeOption = null ):String {
			if ( kana == "" ) { return "" }
			var roman:String; 
			for ( var i:uint = 2; i > 0; i-- ) {
				var subkana:String = kana.substr( 0, i );
				var nextKana:String = kana.substr( i );
				
				if ( option ) { roman = option.romans( subkana )[0]; }				
				if ( !roman && i == 1 ) {
					var zenkaku:int = TypeData.ZENKAKU.indexOf( subkana );
					var hankaku:int = TypeData.HANKAKU.indexOf( subkana );
					if( subkana == "っ" ){ roman = _preLtu( nextKana, option )[0]  }
					else if ( subkana == "ん" ) { roman = _preN( nextKana, option )[0] }
					else if ( zenkaku != -1 ) { roman = TypeData.HANKAKU.substr( zenkaku,1 ); }
					else if ( hankaku != -1 ) { roman = TypeData.HANKAKU.substr( hankaku,1 ); }
				}
				
				if ( !roman ) { 
					var romans:Array = TypeData.ROMANS[subkana];
					if( romans ){ roman = romans[0] }
				}
				if ( roman ) { 
					var next:String = _simplestRoman( nextKana, option );
					if ( next != null ) { return roman + next } 
				}
			}
			return null;
		}

	}
}