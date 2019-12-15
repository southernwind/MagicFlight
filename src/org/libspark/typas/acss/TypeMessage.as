package org.libspark.typas.acss 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.engine.ElementFormat;
	import flash.text.TextField;
	import org.libspark.typas.Typing;
	/**
	 * Typingに登録されているメッセージを受け取って表示します。
	 * @see org.libspark.typas.Typing#message
	 * @see org.libspark.typas.Typing#addMessage
	 * @see TypeStyle
	 * @author shohei909
	 */
	public class TypeMessage extends Sprite{
		static public var finish:String = "FINISH";
		static public var space:String = "SPACE";
		static public var pushSpaceKey:String = "PUSH SPACE KEY"
		static public var miss:String = "MISS";
		static public var pause:String = "PAUSE";
		static public var nihongo:String = "日本語入力を解除してください。";
		
		public var typing:Typing;
		public var background:Bitmap;
		public var text:TypeText;
		
		private var _oldList:Array = [];
		private var _newList:Array = [];
		private var _w:Number;
		private var _h:Number;
		static public var format:ElementFormat = new ElementFormat( TypeStyle.font.clone(), 60, TypeStyle.color2 );
		
		
		/**
		 * コンストラクタです。
		 * @param	typing 親となるTypingです。
		 * @param	width ウインドウの幅です。
		 * @param	height ウインドウの高さです。
		 */
		function TypeMessage( typing:Typing, x:Number = 0, y:Number = 0, width:Number = 600, height:Number = 120 ):void {
			this.typing = typing
			background = new Bitmap( new BitmapData(1, 1, false, TypeStyle.color5 ) );
			background.scaleX = _w = width;
			background.scaleY = _h =height;
			text = new TypeText( "", format.clone() )
			addChild( background );
			addChild( text );
			background.visible = false;
			background.alpha = 0.5;
			typing.addEventListener( Typing.MESSAGE, _update );
			_update();
		}
		
		/**
		 * メッセージの変換を設定します。
		 * @param	oldMessage
		 * @param	newMessage
		 */
		public function addReplace( oldMessage:String, newMessage:String ):void {
			var i:int = _oldList.indexOf( oldMessage );
			if( 0 <= i ){
				_newList[i] = newMessage;
			}else{
				_oldList.push( oldMessage );
				_newList.push( newMessage );
			}
		}
		
		/**
		 * メッセージの変換を解除します。
		 * @param	oldMessage
		 */
		public function removeReplace( oldMessage:String ):void {
			var i:int = _oldList.indexOf( oldMessage );
			if( 0 <= i ){
				_oldList.splice( i, 1 );
				_newList.splice( i, 1 );
			}
		}
		
		private function _update(e:Event = null ):void {
			if ( !typing.message || typing.message == "" ) {
				text.text = "";
				background.visible = false;
			}else {
				var i:int = _oldList.indexOf( typing.message );
				text.text = 0 > i ? typing.message : _newList[i];
				if ( text.width > _w ) {
					var r:Number = _w / text.width;
					text.scaleX = text.scaleY = r;
				}else {
					text.scaleX = text.scaleY = 1;
				}
				text.y = (_h - text.height) / 2;
				text.x = (_w - text.width ) / 2;
				background.visible = true;
			}
		}
	}
}