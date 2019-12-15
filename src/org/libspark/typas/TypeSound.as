package org.libspark.typas 
{
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	/**
	 * 効果音を調整します。
	 * @author shohei909
	 */
	public class TypeSound {
		[Embed(source="/assets/type.mp3")]
		static private var Type:Class;
		[Embed(source="/assets/wordType.mp3")]
		static private var WordType:Class;
		[Embed(source="/assets/missType.mp3")]
		static private var MissType:Class;
		[Embed(source="/assets/start.mp3")]
		static private var Start:Class;
		[Embed(source="/assets/stop.mp3")]
		static private var Stop:Class;
		[Embed(source="/assets/count.mp3")]
		static private var Count:Class;
		[Embed(source="/assets/pause.mp3")]
		static private var Pause:Class;
		[Embed(source="/assets/resume.mp3")]
		static private var Resume:Class;
		/* タイプ時の効果音です。　*/
		public var type:Sound = new Type();
		/* ミスタイプ時の効果音です。　*/
		public var missType:Sound = new MissType();
		/* 単語入力時の効果音です。　*/
		public var wordType:Sound = new WordType();
		/* ゲーム開始時の効果音です。　*/
		public var start:Sound = new Start;
		/* ゲーム終了時の効果音です。　*/
		public var stop:Sound = new Stop;
		/* カウントダウン時の効果音です。　*/
		public var count:Sound = new Count;
		/* 一時停止時の効果音です。　*/
		public var pause:Sound = new Pause;
		/*　ゲーム再開時の効果音です。　*/
		public var resume:Sound = new Resume;
		/* 効果音に適応される。SoundTransformです。 */
		public var transform:SoundTransform = new SoundTransform( 1, 0 );
	}
}