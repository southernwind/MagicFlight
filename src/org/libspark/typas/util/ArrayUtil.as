package org.libspark.typas.util
{
	/**
	 * Arrayに適用できる静的な関数をおさめたクラスです
	 * @author shohei909
	 */
	public class ArrayUtil
	{
		/**
		 * 厳密な等価（===）を使用して配列内のアイテムを検索し、一致したアイテム一つを配列から取り除きます。
		 * @param	array 検索を行う配列です。
		 * @param	searchElement　配列内で検索するアイテムです。 
		 * @param	fromIndex アイテムの検索を開始する配列内の場所です。 
		 * @return 配列内のアイテムの 0 から始まるインデックス位置です。searchElement 引数が見つからなかった場合、戻り値は -1 です。 
		 * @example 次の例では、配列からアイテムを削除しています。
		 * <listing version="3.0">
		 * var arr:Array = [ "one", "two", "three", "four", "one", "two", "three", "four" ];
		 * Array2.remove( arr, "two" );
		 * trace( arr ); // one,three,four,one,two,three,four 
		 * </listing>
		 */
		static public function remove( array:Array, searchElement:*, fromIndex:int = 0 ):int
		{
			if ( (fromIndex = array.indexOf( searchElement, fromIndex )) > -1 ) { 
				array.splice( fromIndex, 1 );
			}
			return fromIndex;
		}
		
		
		
		/**
		 * パラメータ名を指定して、Objectの配列からそのパラメータの配列を作ります。
		 * @param	array 元となる配列です
		 * @param	paramName　配列を作成するパラメータの名前です
		 * @return パラメータの配列です。
		 * @example
		 * <listing version="3.0">
		 * var arr1:Array = [ new Point(0,10), new Point(10,10),  new Point(10,0), new Point(0,0) ];
		 * var arr2:Array = Array2.params( arr1, "x" );
		 * trace( arr2 ); // 0,10,10,0 
		 * </listing>
		 */
		static public function params( array:Array, paramName:String ):Array {
			var arr:Array = [];
			for each( var e:* in array ) {
				arr.push( e[paramName] );
			}
			return arr;
		}
		
		/**
		 * argsのうち、arrayにまだ含まれないもののみを配列の末尾に追加します。
		 * @param	array
		 * @param	...args
		 * @return
		 */
		static public function add( array:Array, ...args ):Array {
			var l:uint = args.length;
			for ( var i:uint = 0; i < l; i++ ) {
				var e:* = args[i];
				if ( array.indexOf( e ) > -1 ) { 
					array.push( e ) 
				}else {
					remove( args, e, i );
					i--; l--;
				}
			}
			return args;
		}
		
		/**
		 * arr2のうち、arr1にまだ含まれないもののみを配列の前方に追加します。
		 * @param	arr1
		 * @param	arr2
		 * @return
		 */
		static public function blend( arr1:Array, arr2:Array ):Array {
			if ( !arr2 ) { return arr1; }
			var l:uint = arr2.length;
			for ( var i:uint = 0; i < l; i++ ) {
				var e:* = arr2[i];
				if ( arr1.indexOf( e ) == -1 ) { arr1.push( e ); }
			}
			return arr1;
		}
		
		static public function string( obj:Object ):String {
			if (! obj ) { return null; }
			var str:String = "";
			for ( var p:String in obj ) { 
				str += p +":"+ obj[p] + ","
			}
			return "["+str+"]"
		}
	}
}