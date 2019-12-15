package  
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author admin
	 */
	public class LoadObj extends EventDispatcher {
		
		//URL配列
		public var requests:Array = new Array();
		
		//画像配列
		public var bitmaps:Array = new Array();
		
		//カウント変数
		public var count:int = 0;
		
		//loader
		public var loader:Loader = new Loader();
		
		
		
		public function addRequest(url:String):void {
			var urlreq:URLRequest = new URLRequest(url);
			requests.push(urlreq);
			
		}
		
		//ダウンロード開始
		public function startLoad():void {
			//最初のダウンロードが確認出来たらcompメソッドへ
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, comp);
			
			if (requests.length > 0) {
				loader.load(requests[0]);
			}
		}
		
		//イベントハンドラ
		public function comp(event:Event):void {
			//画像データを配列に追加
			bitmaps.push(loader.content);
			count++;
			
			//他にデータがあるか確認する
			if (requests.length > count) {
				loader.load(requests[count]);
			}else {
				var event:Event = new Event(Event.COMPLETE);
				dispatchEvent(event);
			}
		}
	}

}