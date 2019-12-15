package org.libspark.typas.acss 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.SharedObject;
	/**
	 * 音量調節用のボタンです。Flash全体の音量を調節します。
	 * @author shohei909
	 */
	public class TypeAudioButton extends Sprite{
		[Embed(source = '/assets/audio-volume-muted.png')]
		static private var Muted:Class;
		[Embed(source = '/assets/audio-volume-low.png')]
		static private var Low:Class;
		[Embed(source = '/assets/audio-volume-medium.png')]
		static private var Midium:Class;
		[Embed(source = '/assets/audio-volume-high.png')]
		static private var High:Class;
		[Embed(source = '/assets/thumb.png')]
		static private var Thumb:Class;
		[Embed(source = '/assets/bar.png')]
		static private var Bar:Class;
		
		/* 大音量のアイコン */
		public var high:Bitmap = new High();
		/* 中音量のアイコン */
		public var midium:Bitmap = new Midium();
		/* 小音量のアイコン */
		public var low:Bitmap = new Low();
		/* 無音量のアイコン */
		public var mute:Bitmap = new Muted();
		
		private var icon:Sprite = new Sprite;
		private var thumb:Bitmap = new Thumb;
		private var bar:Bitmap = new Bar;
		private var slider:Sprite = new Sprite;
		
		/**　音量です */
		public function get value():Number { return _value; }
		public function set value( v:Number ):void {_value = v; update(); }
		private var _value:Number;
		private static var save:SharedObject;
		
		/**
		 * コンストラクタです。
		 * @param	x x座標
		 * @param	y y座標
		 */
		function TypeAudioButton( x:Number = 0, y:Number = 0 ) {
			this.x = x; this.y = y;
			
			if (! save ) {
				save = SharedObject.getLocal( "typas/volume", "/" );
				if ( save.data.volume === null || isNaN( save.data.volume ) ) { save.data.volume = 1; }
			}
			
			buttonMode = true;
			addChild( slider ).x = 16;
			addChild( icon );
			slider.addChild( bar );
			slider.addChild( thumb );
			bar.y = 4;
			_value = SoundMixer.soundTransform.volume = save.data.volume;
			update();
			
			addEventListener( Event.ADDED_TO_STAGE, added, false, 0, true );
		}
		private function added( e:Event ):void{
			removeEventListener( Event.ADDED_TO_STAGE, added );
			slider.addEventListener( MouseEvent.MOUSE_DOWN, down, false, 0, true );
			icon.addEventListener( MouseEvent.MOUSE_DOWN, click, false, 0, true );
			addEventListener( Event.REMOVED_FROM_STAGE, removed, false, 0, true );
		}
		private function removed( e:Event ):void{
			removeEventListener( Event.REMOVED_FROM_STAGE, removed );
			slider.removeEventListener( MouseEvent.MOUSE_DOWN, down );
			icon.removeEventListener( MouseEvent.MOUSE_DOWN, click );
			addEventListener( Event.ADDED_TO_STAGE, added, false, 0, true );
		}
		
		public function update():void {
			if( _value < 0 ){ _value = 0 }
			if( _value > 1 ){ _value = 1 }
			SoundMixer.soundTransform = new SoundTransform( save.data.volume = _value );
			
			thumb.x = _value * 24;
			var child:Bitmap = [ mute, low, midium, high ][ Math.ceil( _value * 3 ) ]
			if (! icon.contains( child ) ) {
				if ( icon.numChildren > 0 ) { icon.removeChildAt( 0 ) }
				icon.addChild( child );
			}
		}
		private function down( e:Event ):void {
			_value = (slider.mouseX - 4) / 24;
			stage.addEventListener( MouseEvent.MOUSE_UP, up, false, 0, true );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, move, false, 0, true );
			update();
		}
		private function up( e:Event ):void {
			stage.removeEventListener( MouseEvent.MOUSE_UP, up );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, move );
		}
		private function move( e:Event ):void {
			_value = (slider.mouseX - 4) / 24;
			update();
		}
		private function click( e:Event ):void {
			if ( _value == 0 ) { _value = 0.5; }
			else { _value = 0 }
			update();
		}
	}

}