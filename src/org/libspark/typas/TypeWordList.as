package org.libspark.typas 
{
	/**
	 * 単語リストのクラスです。単語をグループ化して、使用可、不可の管理を行います。
	 * @author shohei909
	 */
	public class TypeWordList {
		private var _words:Vector.<TypeWord> = new Vector.<TypeWord>;
		/** この単語表に含まれる単語のVectorです。 */
		public function get words():Vector.<TypeWord> { return _words; }
		
		private var _unused:Vector.<TypeWord> = new Vector.<TypeWord>;
		/** 未使用の単語のリストです。一度使用された単語はrelease()まで呼び出されることはありません。 */
		public function get unused():Vector.<TypeWord> { return _unused; }
		
		/**
		 * コンストラクタです。
		 * @param	list　単語表となる配列です。listには変数kanaとwordをもつObjectの配列を指定してください。
		 * 例:[{word:"人",kana:"ひと"},{word:"世界",kana:"せかい"}]
		 */
		function TypeWordList(　list:Array　) {
			for each (var o:Object in list) {
				var word:TypeWord = new TypeWord( o );
				_words.push( word );
				_unused.push( word );
			}
		}
		
		/**
		 * すべての単語を未使用の単語として解放します。
		 * @param	tags タグを指定するとそのタグのAND検索を行って、一致したもののみ解放されます。
		 */
		public function release( tags:Array = null ):void {
			if(!tags || tags.length == 0 ){
				_unused.splice( 0, uint.MAX_VALUE );
				for each( var word:TypeWord in _words ) { _unused.push( word ); }
			}else {
				for each( word in _words ) { 
					if ( word.match.apply( null, tags ) && _unused.indexOf( word ) == -1 ) {
						_unused.push( word );
					}
				}
			}
		}
		
		/** 
		 * 未使用の単語リストから指定した位置の単語を取り出して、使用済みに設定します。
		 * @param	index 単語の位置
		 * @param	tags タグを指定するとタグのAND検索を行ってから前からindex番目の単語が指定されます。
		 * @return 選択された単語です。
		 */
		public function select( index:int, tags:Array = null ):TypeWord {
			if(!tags || tags.length == 0 ){
				return unused.splice( index, 1 )[0];
			}else {
				var c:int = 0;
				for ( var i:int = 0, l:int = _unused.length; i < l; i++ ) {
					var w:TypeWord = _unused[i];
					if ( w.match.apply( null, tags ) ) { 
						if( index == c++ ){ return unused.splice( i, 1 )[0]; }
					}
				}
			}
			return null;
		}
	
		/**
		 * 未使用の単語リストからタグのAND検索を行って、タグに一致する単語の数を返します。
		 * @param	tags 検索を行うタグです。
		 * @return
		 */
		public function count( tags:Array ):uint {
			if(!tags || tags.length == 0 ){
				return unused.length;
			}else {
				var c:int = 0;
				for each (var w:TypeWord in _unused ) {
					if ( w.match.apply( null, tags ) ) { c++; }
				}
				return c;
			}
		}
		
	}

}