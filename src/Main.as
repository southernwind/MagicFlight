package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;	
	import mx.core.BitmapAsset;
	import org.libspark.typas.*;
	import org.libspark.typas.acss.*;
	import flash.text.engine.ElementFormat;
	import Sounds.SoundUtils;
	import flash.media.SoundMixer;
	import flash.text.TextFieldAutoSize;

	/**
	 * ...
	 * @author admin
	 */
	public class Main extends Sprite {

		//待機時間
		public var wait:int = 100;
		
		//タイピング画面画像
		public var witchgif:Bitmap;
		public var play_typepng:Bitmap;
		public var witch_deadgif:Bitmap;
		
		//ステージ選択画面画像
		public var stage_selectpng:Bitmap;
		public var islandpng0:Bitmap;
		public var islandpng1:Bitmap;
		public var islandpng2:Bitmap;
		public var islandpng3:Bitmap;
		public var islandpng4:Bitmap;
		public var islandpng5:Bitmap;
		public var islandpng6:Bitmap;
		public var islandpng7:Bitmap;
		public var flaggif1:Bitmap;
		public var flaggif2:Bitmap;
		public var flaggif3:Bitmap;
		public var flaggif4:Bitmap;
		public var flaggif5:Bitmap;
		public var flaggif6:Bitmap;
		public var flaggif7:Bitmap;
		public var tfExposition:TextField = new TextField();
		public var spr_island0:Sprite = new Sprite();
		public var spr_island1:Sprite = new Sprite();
		public var spr_island2:Sprite = new Sprite();
		public var spr_island3:Sprite = new Sprite();
		public var spr_island4:Sprite = new Sprite();
		public var spr_island5:Sprite = new Sprite();
		public var spr_island6:Sprite = new Sprite();
		public var spr_island7:Sprite = new Sprite();
		public var tf_goal:TextField = new TextField();
		
		//難易度選択画面画像
		public var titlepng:Bitmap;
		public var veryhardgif:Bitmap;
		public var hardgif:Bitmap;
		public var normalgif:Bitmap;
		public var easygif:Bitmap;
		public var veryeasygif:Bitmap;
		public var spr_veryhard:Sprite = new Sprite();
		public var spr_hard:Sprite = new Sprite();
		public var spr_normal:Sprite = new Sprite();
		public var spr_easy:Sprite = new Sprite();
		public var spr_veryeasy:Sprite = new Sprite();
		
		//テキストフィールド
		private var tf:TextField = new TextField();
		private var escendtf:TextField = new TextField();
		private var tfSPACE:TextField = new TextField();
		private var tfNan:TextField = new TextField();
		
		//Loader
		public var loadobj:LoadObj = new LoadObj();
			
		//タイマー
		public var timer:Timer = new Timer(40);
		public var ticktack:int = 0;
		
		//キー状態
		public var keystate_space:Boolean = false;
		public var keystate_esc:Boolean = false;
		
		//選択された島番号
		public var select_island:int = 0;
		/*状況
		* 0 = タイトル画面
		* 1 = ステージ選択画面
		* 2 = ゲーム中
		*/
		public var situation:int = 0;
		
		/*ゲーム中
		 * 0 = タイピング開始前
		 * 1 = タイピング中
		 * 2 = ゲームオーバー
		 * 3 = ゲームクリア
		*/
		public var typing_now:int = 0;
		
		//魔女浮上
		public var tc:int = 0;
		
		//魔女下降
		public var tm:int = 0;
		
		//次の島に移動するかどうか(クリアフラグ)
		public var gameClear:Boolean = false;
		
		//難易度
		public var difficulty:int = 1;
		
		//ステージクリアフラグ
		public var clear_flag1:Boolean = false;
		public var clear_flag2:Boolean = false;
		public var clear_flag3:Boolean = false;
		public var clear_flag4:Boolean = false;
		public var clear_flag5:Boolean = false;
		public var clear_flag6:Boolean = false;
		public var clear_flag7:Boolean = false;
		
		//タイパス
		private var typing:Typing;
		private var typepanel:TypePanel;
		private var typekeyboard:TypeKeyboard;
		private var typehands:TypeHands;
		private var typestyle:TypeStyle;
		
		public function Main():void 
		{
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//音量変更
			var su:SoundUtils = new Sounds.SoundUtils(SoundMixer);
			su.volume = 0.1;
			
			//オブジェクトロード
			loadobj.addRequest("media/title.png");
			loadobj.addRequest("media/witch.gif");
			loadobj.addRequest("media/play_type.png");
			loadobj.addRequest("media/witch_dead.gif");
			loadobj.addRequest("media/veryhard.gif");
			loadobj.addRequest("media/hard.gif");
			loadobj.addRequest("media/normal.gif");
			loadobj.addRequest("media/easy.gif");
			loadobj.addRequest("media/veryeasy.gif");
			loadobj.addRequest("media/stage_select.png");
			loadobj.addRequest("media/island.png");
			loadobj.addRequest("media/island.png");
			loadobj.addRequest("media/island.png");
			loadobj.addRequest("media/island.png");
			loadobj.addRequest("media/island.png");
			loadobj.addRequest("media/island.png");
			loadobj.addRequest("media/island7.png");
			loadobj.addRequest("media/flag.gif");
			loadobj.addRequest("media/flag.gif");
			loadobj.addRequest("media/flag.gif");
			loadobj.addRequest("media/flag.gif");
			loadobj.addRequest("media/flag.gif");
			loadobj.addRequest("media/flag.gif");
			loadobj.addRequest("media/flag.gif");
			loadobj.addRequest("media/island0.png");
			loadobj.addEventListener(Event.COMPLETE, loadcompAll);
			loadobj.startLoad();
			
		}
		
		public function loadcompAll(event:Event):void {
			titlepng = loadobj.bitmaps[0];
			witchgif = loadobj.bitmaps[1];
			play_typepng = loadobj.bitmaps[2];
			witch_deadgif = loadobj.bitmaps[3];
			veryhardgif = loadobj.bitmaps[4];
			hardgif = loadobj.bitmaps[5];
			normalgif = loadobj.bitmaps[6];
			easygif = loadobj.bitmaps[7];
			veryeasygif = loadobj.bitmaps[8];
			stage_selectpng = loadobj.bitmaps[9];
			islandpng1 = loadobj.bitmaps[10];
			islandpng2 = loadobj.bitmaps[11];
			islandpng3 = loadobj.bitmaps[12];
			islandpng4 = loadobj.bitmaps[13];
			islandpng5 = loadobj.bitmaps[14];
			islandpng6 = loadobj.bitmaps[15];
			islandpng7 = loadobj.bitmaps[16];
			flaggif1 = loadobj.bitmaps[17];
			flaggif2 = loadobj.bitmaps[18];
			flaggif3 = loadobj.bitmaps[19];
			flaggif4 = loadobj.bitmaps[20];
			flaggif5 = loadobj.bitmaps[21];
			flaggif6 = loadobj.bitmaps[22];
			flaggif7 = loadobj.bitmaps[23];
			islandpng0 = loadobj.bitmaps[24];
			
			//ステージ選択島
			spr_island0.addChild(islandpng0);
			spr_island1.addChild(islandpng1);
			spr_island2.addChild(islandpng2);
			spr_island3.addChild(islandpng3);
			spr_island4.addChild(islandpng4);
			spr_island5.addChild(islandpng5);
			spr_island6.addChild(islandpng6);
			spr_island7.addChild(islandpng7);
			
			spr_island0.addEventListener(MouseEvent.CLICK, island0);
			spr_island1.addEventListener(MouseEvent.CLICK, island1);
			spr_island2.addEventListener(MouseEvent.CLICK, island2);
			spr_island3.addEventListener(MouseEvent.CLICK, island3);
			spr_island4.addEventListener(MouseEvent.CLICK, island4);
			spr_island5.addEventListener(MouseEvent.CLICK, island5);
			spr_island6.addEventListener(MouseEvent.CLICK, island6);
			spr_island7.addEventListener(MouseEvent.CLICK, island7);
			
			//難易度設定ボタン設置
			spr_veryhard.addChild(veryhardgif);
			spr_hard.addChild(hardgif);
			spr_normal.addChild(normalgif);
			spr_easy.addChild(easygif);
			spr_veryeasy.addChild(veryeasygif);
			
			add_title();
			
			spr_veryhard.addEventListener(MouseEvent.CLICK, btnClicked5);
			spr_hard.addEventListener(MouseEvent.CLICK, btnClicked4);
			spr_normal.addEventListener(MouseEvent.CLICK, btnClicked3);
			spr_easy.addEventListener(MouseEvent.CLICK, btnClicked2);
			spr_veryeasy.addEventListener(MouseEvent.CLICK, btnClicked1);
			
			
			//位置設定
			witchgif.x = 60;
			witchgif.y = 190;
			
			veryhardgif.x = 480;
			veryhardgif.y = 10;
			hardgif.x = 480;
			hardgif.y = 60;
			normalgif.x = 480;
			normalgif.y = 110;
			easygif.x = 480;
			easygif.y = 160;
			veryeasygif.x = 480;
			veryeasygif.y = 210;
			tfExposition.x = 300;
			tfExposition.y = 470;
			tfExposition.defaultTextFormat = new TextFormat(null, 15, 0xffffff, true);
			timer.addEventListener(TimerEvent.TIMER, tick);
			timer.start();
			stage.addEventListener( KeyboardEvent.KEY_DOWN, keyOperation );
			stage.addEventListener( KeyboardEvent.KEY_UP, keyOperation );
		}
		
		//難易度選択ボタン押下時の処理
		public function btnClicked1(event:MouseEvent):void {
			difficulty = 1;
			stage_select();
		}
		public function btnClicked2(event:MouseEvent):void {
			difficulty = 2;
			stage_select();
		}
		public function btnClicked3(event:MouseEvent):void {
			difficulty = 3;
			stage_select();
		}
		public function btnClicked4(event:MouseEvent):void {
			difficulty = 4;
			stage_select();
		}
		public function btnClicked5(event:MouseEvent):void {
			difficulty = 5;
			stage_select();
		}

		//ステージ選択時の島
		public function island0(event:MouseEvent):void {
			select_island = 0;
		}
		public function island1(event:MouseEvent):void {
			if(clear_flag1){
				select_island = 1;
			}
		}
		public function island2(event:MouseEvent):void {
			if(clear_flag2){
				select_island = 2;
			}
		}
		public function island3(event:MouseEvent):void {
			if(clear_flag3){
				select_island = 3;
			}
		}
		public function island4(event:MouseEvent):void {
			if(clear_flag4){
				select_island = 4;
			}
		}
		public function island5(event:MouseEvent):void {
			if(clear_flag5){
				select_island = 5;
			}
		}
		public function island6(event:MouseEvent):void {
			if(clear_flag6){
				select_island = 6;
			}
		}
		public function island7(event:MouseEvent):void {
			if(clear_flag7){
				select_island = 7;
			}
		}
		
		
		//***************************************************************************************************************************************************************************************************************************
		public function tick(event:TimerEvent):void {
			switch(situation) {
				case 0: //タイトル画面
					if (witchgif.x < 500) {
						witchgif.x += 3;
						witchgif.y += 1;
					}else {
						if (wait == 0) {
							witchgif.x += 3;
							witchgif.y += 1;
							if (witchgif.x > 650) {
								witchgif.x = -30;
								witchgif.y = 160;
								wait = 100;
							}
						}else {
							wait--;
						}
					}
					break;
				case 1: //ステージ選択画面
					var move_x:int = 0;
					var move_y:int = 0;
					var i_x:int; //選択した島のx座標
					var i_y:int; //選択した島のy座標
					var p:int;
					switch(select_island) {
						case 0:
							i_x = islandpng0.x+50;
							i_y = islandpng0.y+100;
							break;
						case 1:
							i_x = islandpng1.x;
							i_y = islandpng1.y;
							break;
						case 2:
							i_x = islandpng2.x;
							i_y = islandpng2.y;
							break;
						case 3:
							i_x = islandpng3.x;
							i_y = islandpng3.y;
							break;
						case 4:
							i_x = islandpng4.x;
							i_y = islandpng4.y;
							break;
						case 5:
							i_x = islandpng5.x;
							i_y = islandpng5.y;
							break;
						case 6:
							i_x = islandpng6.x;
							i_y = islandpng6.y;
							break;
						case 7:
							i_x = islandpng7.x;
							i_y = islandpng7.y;
							break;
							
						default:
							i_x = -999;
							i_y = -999;
							
					}
					
					i_x += 25;
					i_y += 10;
					p= Math.sqrt(Math.pow(i_x - witchgif.x, 2) + Math.pow(i_y - witchgif.y,2));
					move_x = Math.round((i_x - witchgif.x) / p * 5);
					move_y = Math.round((i_y - witchgif.y) / p * 5);
					
					if(i_x > 0){
						if (Math.abs(witchgif.x - i_x)　> move_x) {
							witchgif.x += move_x;
							witchgif.y += move_y;
						}else {
							if (select_island == 7) {
								tf_goal.defaultTextFormat = new TextFormat(null, 25, 0xEE9955, true);
								tf_goal.x = 260;
								tf_goal.y = 50;
								tf_goal.autoSize = TextFieldAutoSize.LEFT;
								tf_goal.visible = true;
								tf_goal.text = "ゴール!おめでとう!";
							}
						}
					}
					
					//スペースキーを押すとゲーム開始
					if (keystate_space) {
						keystate_space = false;
						if(select_island != 7){
							type_start();
						}
					}
					
					
					//escでタイトル画面に戻る
					if (keystate_esc) {
						keystate_esc = false;
						//ステージ削除
						remove_stage();
						//タイトル追加
						add_title();
					}

					break;
				case 2: //ゲーム中の処理
					witch_flight();
					break;
			}
		}
		
		//経過の表示
		private function _frame( e:Event ):void {
			tf.text = 
			"速度:" + int(typing.correct / typing.time * 10000) / 10 + "key/s" + 
			"\n打鍵数:" + typing.correct + "回" + 
			"\nミス回数:" + typing.miss + "回" + 
			"\n時間:" + int(typing.time / 1000) + "秒";
		}
		
		public function keyOperation(event:KeyboardEvent):void {
			var keydown:Boolean = false;
			if (event.type == KeyboardEvent.KEY_DOWN) {
				keydown = true;
			}
			switch(event.keyCode) {
				case 32: //スペースキー
					keystate_space = keydown;
					break;
				case 27:
					keystate_esc = keydown;
					break;
			}
		}
		//ステージ選択画面
		public function stage_select():void {			
			//タイトル画面削除
			remove_title();
			
			//ステージ選択画面追加
			add_stage();
			
			
		}
		
		//タイピング開始処理
		public function type_start():void {
			//ステージ画面削除
			remove_stage();
			
			//ゲーム画面追加
			add_game();
			
		}
		
		//タイピング終了処理
		public function type_stop():void {
			
			typing.stop();
			//ゲーム画面削除
			remove_game();
			
			//ステージ画面追加
			add_stage();
		}
		

		//ゲーム中の魔女の処理
		public function witch_flight():void {
			
			ticktack++;
			//難易度選択
			var fall:int = 20;
			switch(difficulty) {
				case 1: //very easy
					fall = 20;
					break;
				case 2: //easy
					fall = 13;
					break;
				case 3: //normal
					fall = 7;
					break;
				case 4: //hard
					fall = 4;
					break;
				case 5: //very hard
					fall = 2;
					break;
			}
			
			//スペースキーを押すとゲーム開始
			if (keystate_space && typing_now == 0) {
				typepanel._text.alpha = 1;
				tfSPACE.visible = false;
				keystate_space = false;
				typing_now = 1;
				typing.start();
			}
			//escでゲーム終了
			if (keystate_esc) {
				keystate_esc = false;
				typing_now = 0;
				type_stop();
			}
			
			//魔女を飛ばす処理
			if(typing_now == 1){　//タイピング中のみ実行
				if (witchgif.x > 40) { //島から出たら下降処理開始
					if (ticktack % fall == 0) {
						//魔女自然下降
						witchgif.y++;
					}
					if (select_island+1 == 1) {
						//ステージ1の時は少し簡単にする
						if (ticktack % (fall * 3) == 0) {
							witchgif.y--;
						}
						//ステージ1の時は進みやすくする
						witchgif.x += (typing.correct - tc);
					}
					
					//ミス数によって魔女下降
					witchgif.y += (typing.miss-tm)
					tm = typing.miss;
				}
				//タイプ文字数によって魔女上昇
				witchgif.y -= (typing.correct - tc);
				//タイプ文字数によって魔女進行
				witchgif.x += (typing.correct - tc)*2;
				
				
				tc = typing.correct;
				
				//上に行き過ぎるのを防止
				if (witchgif.y < 0) {
					witchgif.y = 0;
				}
				
				
				if (witchgif.x > 550) {
					//ゲームクリア
					witchgif.x = 600;
					witchgif.y = 136;
					typing.stop();
					typing_now = 3;
					switch(select_island + 1) {
						case 1:
							clear_flag1 = true;
							break;
						case 2:
							clear_flag2 = true;
							break;
						case 3:
							clear_flag3 = true;
							break;
						case 4:
							clear_flag4 = true;
							break;
						case 5:
							clear_flag5 = true;
							break;
						case 6:
							clear_flag6 = true;
							break;
						case 7:
							clear_flag7 = true;
							break;
					}
					tfSPACE.visible = true;
					typepanel._text.alpha = 0.23
					tfSPACE.x = 80;
					tfSPACE.y = 30;
					tfSPACE.text = "　　　　　　　　　　　CLEAR!　　　　　　　　　　　　\n" +
								   "ESCキーを押してステージ選択画面へもどります";
					gameClear = true;
				}
				
				
				if( witchgif.y >= 173){
					//ゲームオーバー
					try {
						witchgif.y++;
						typing_now = 2;
						witch_deadgif.x = witchgif.x;
						witch_deadgif.y = witchgif.y;
						addChildAt(witch_deadgif,1);
						removeChild(witchgif);
						typing.stop();
						wait = 30;
					}catch (e:Error) {
					}
						
				}
			}
			
			//ゲームオーバー・下に落下
			if (typing_now == 2) {
				if (wait == 0) {
					if(witch_deadgif.y < 390){
						witch_deadgif.y++;
					}
					tfSPACE.visible = true;
					typepanel._text.alpha = 0.23;
					tfSPACE.x = 80;
					tfSPACE.y = 30;
					tfSPACE.text = "　　　　　　　　　GAME OVER　　　　　　　　　　　\n" + 
								   "ESCキーを押してステージ選択画面に戻ります";
				}else {
					wait--;
				}
			}
		}
		
			

		
		
		
		//******************************************************************************************************
		//タイトル画面⇔ステージ選択画面⇔ゲーム画面
		//******************************************************************************************************
		
		//タイトル画面削除****
		public function remove_title():void {
			removeChild(titlepng);
			removeChild(spr_veryhard);
			removeChild(spr_hard);
			removeChild(spr_normal);
			removeChild(spr_easy);
			removeChild(spr_veryeasy);
			removeChild(witchgif);
			removeChild(tfNan);
		}
		//ステージ画面削除****
		public function remove_stage():void {
			removeChild(stage_selectpng);
			removeChild(spr_island0);
			removeChild(spr_island1);
			removeChild(spr_island2);
			removeChild(spr_island3);
			removeChild(spr_island4);
			removeChild(spr_island5);
			removeChild(spr_island6);
			removeChild(spr_island7);
			removeChild(tfExposition);
			removeChild(witchgif);
			removeChild(escendtf);
			removeChild(flaggif1);
			removeChild(flaggif2);
			removeChild(flaggif3);
			removeChild(flaggif4);
			removeChild(flaggif5);
			removeChild(flaggif6);
			removeChild(flaggif7);
			removeChild(tf_goal);
		}
		
		//ゲーム画面削除****
		public function remove_game():void {
			removeChild(typepanel);
			removeChild(typekeyboard);
			removeChild(typehands);
			removeChild(typing);
			removeChild(play_typepng);
			removeChild(tf);
			removeChild(escendtf);
			tfSPACE.visible = false;
			try{
				removeChild(witchgif);
			}catch (e:Error) {
			}
			try{
				removeChild(witch_deadgif);
			}catch (e:Error) {
			}
			tc = 0;
			tm = 0;
			removeChild(tfSPACE);
		}
		
		//タイトル画面追加****
		public function add_title():void {
			situation = 0; //場面をタイトルに変更
			addChildAt(titlepng, 0);
			addChild(spr_veryhard);
			addChild(spr_hard);
			addChild(spr_normal);
			addChild(spr_easy);
			addChild(spr_veryeasy);
			addChild(witchgif);
			addChild(tfNan);
			tfNan.x = 130;
			tfNan.y = 60;
			tfNan.autoSize = TextFieldAutoSize.LEFT;
			tfNan.defaultTextFormat = new TextFormat(null, 25, 0xEE9955, true);
			tfNan.text = "難易度を選択してください。";
			witchgif.x = 60;
			witchgif.y = 190;
		}
		
		//ステージ画面追加****
		public function add_stage():void {
			
			situation = 1; //場面をステージ選択画面に変更
			
			//島等を表示する
			addChildAt(stage_selectpng, 0);
			addChildAt(spr_island1,1);
			addChildAt(spr_island2,2);
			addChildAt(spr_island3,3);
			addChildAt(spr_island4,4);
			addChildAt(spr_island5,5);
			addChildAt(spr_island6,6);
			addChildAt(spr_island7, 7);
			addChild(tfExposition);
			addChild(escendtf);
			addChildAt(flaggif1, 8);
			addChildAt(flaggif2, 9);
			addChildAt(flaggif3, 10);
			addChildAt(flaggif4, 11);
			addChildAt(flaggif5, 12);
			addChildAt(flaggif6, 13);
			addChildAt(flaggif7, 14);
			addChildAt(spr_island0, 15);
			addChild(tf_goal);
			tf_goal.visible = false;
			
			//位置を決定
			islandpng0.x = 0;
			islandpng0.y = 0;
			islandpng1.x = 30;
			islandpng1.y = 240;
			islandpng2.x = 120;
			islandpng2.y = 380;
			islandpng3.x = 230;
			islandpng3.y = 320;
			islandpng4.x = 400;
			islandpng4.y = 320;
			islandpng5.x = 380;
			islandpng5.y = 200;
			islandpng6.x = 490;
			islandpng6.y = 100;
			islandpng7.x = 541;
			islandpng7.y = 0;
			flaggif1.x = islandpng1.x + 15;
			flaggif1.y = islandpng1.y + 10;
			flaggif2.x = islandpng2.x + 15;
			flaggif2.y = islandpng2.y + 10;
			flaggif3.x = islandpng3.x + 15;
			flaggif3.y = islandpng3.y + 10;
			flaggif4.x = islandpng4.x + 15;
			flaggif4.y = islandpng4.y + 10;
			flaggif5.x = islandpng5.x + 15;
			flaggif5.y = islandpng5.y + 10;
			flaggif6.x = islandpng6.x + 15;
			flaggif6.y = islandpng6.y + 10;
			flaggif7.x = islandpng7.x + 15;
			flaggif7.y = islandpng7.y + 10;
			
			//クリア旗を表示するかどうか
			flaggif1.visible = clear_flag1;
			flaggif2.visible = clear_flag2;
			flaggif3.visible = clear_flag3;
			flaggif4.visible = clear_flag4;
			flaggif5.visible = clear_flag5;
			flaggif6.visible = clear_flag6;
			flaggif7.visible = clear_flag7;
			
			//魔女表示
			addChild(witchgif);
			//魔女の位置
			switch(select_island) {
				//前回選択していた島に魔女を表示する
				case 0:
					witchgif.x = 75;
					witchgif.y = 110;
					break;
				case 1:
					witchgif.x = islandpng1.x + 25;
					witchgif.y = islandpng1.y + 10;
					break;
				case 2:
					witchgif.x = islandpng2.x + 25;
					witchgif.y = islandpng2.y + 10;
					break;
				case 3:
					witchgif.x = islandpng3.x + 25;
					witchgif.y = islandpng3.y + 10;
					break;
				case 4:
					witchgif.x = islandpng4.x + 25;
					witchgif.y = islandpng4.y + 10;
					break;
				case 5:
					witchgif.x = islandpng5.x + 25;
					witchgif.y = islandpng5.y + 10;
					break;
				case 6:
					witchgif.x = islandpng6.x + 25;
					witchgif.y = islandpng6.y + 10;
					break;
				case 7:
					witchgif.x = islandpng7.x + 25;
					witchgif.y = islandpng7.y + 10;
					break;
				default:		
					//どれでもなかった場合はstartの島に
					witchgif.x = 75;
					witchgif.y = 110;
					break;
			}			
			//説明テキスト
			tfExposition.autoSize = TextFieldAutoSize.LEFT;
			tfExposition.text = "スペースキーを押すとタイピングゲームが始まります。";
			escendtf.defaultTextFormat = new TextFormat(null, 13, 0xcc0000, true);
			escendtf.x = 10;
			escendtf.y = 470;
			escendtf.autoSize = TextFieldAutoSize.LEFT;
			escendtf.text = "[ESC]　でタイトル画面に戻る";
			
			//ゲーム→ステージの時、クリアして戻ってきていれば次の島へ移動させる。
			if (gameClear) {
				if(select_island != 7){
					select_island++;
				}
				gameClear = false;
			}
			
		}
		
		//ゲーム画面を追加****
		public function add_game():void {
			situation = 2; //状況をゲーム中に変更
			wait = 30;
			typing = new Typing();
			typepanel = new TypePanel( typing, 0, 0, 650, 100 ) ;
			typekeyboard = new TypeKeyboard( typing, 29, 215 );
			typehands = new TypeHands( typing, 45, 465 ) ;
			typestyle = new TypeStyle();
			
			//タイピングゲームを設定する。
			addChild(typing);
		
			
			
			//キーボードを表示する。
			addChild( typekeyboard);
			
			//手を表示する。
			addChild(typehands);
			
			//背景表示
			addChildAt(play_typepng,0);
			
			//魔女表示
			addChild(witchgif);
			
			//文字パネルを表示する。
			addChild(typepanel);
			
			addChild(tfSPACE);
			var manager:TypeManager;
			
			
			//ステージによって単語を変更
			switch(select_island+1) {
				case 1:
					manager = new TypeManager( typing, words1 );
					manager.random = false;
					break;
				case 2:
					manager = new TypeManager( typing, words2 );
					manager.random = true;
					break;
				case 3:
					manager = new TypeManager( typing, words3 );
					manager.random = true;
					break;
				case 4:
					manager = new TypeManager( typing, words4 );
					manager.random = true;
					break;
				case 5:
					manager = new TypeManager( typing, words5 );
					manager.random = true;
					break;
				case 6:
					manager = new TypeManager( typing, words6 );
					manager.random = true;
					break;
				case 7:
					manager = new TypeManager( typing, words7 );
					manager.random = true;
					break;
				default:
					manager = new TypeManager(typing, words1);
					manager.random = true;
					break;
			}
			
			tf.autoSize = "left"
			tf.y = 430;
			tf.x = 560;
			addChild( tf );
			
			escendtf.x = 10;
			escendtf.y = 420;
			escendtf.textColor = 0xFF0000;
			escendtf.text = "[ESC]　で中止";
			addChild(escendtf);
			
			witchgif.x = 15;
			witchgif.y = 136;
			addEventListener( "enterFrame", _frame );
			typepanel._text.alpha = 0.23;
			addChild(tfSPACE);
			tfSPACE.defaultTextFormat = new TextFormat(null, 25, 0xEE9955, true);
			tfSPACE.x = 180;
			tfSPACE.y = 50;
			tfSPACE.text = "SPACEキーを押してください";
			tfSPACE.visible = true;
			tfSPACE.autoSize = TextFieldAutoSize.LEFT;
		}
		

		//******************************************************************************************************
		//* ここまで
		//******************************************************************************************************
		
	}
	
}


//タイプワード
//あいうえお
var words1:Array = [
		{ word : "あいうえお",				kana : "あいうえお" },
		{ word : "かきくけこ",				kana : "かきくけこ" },
		{ word : "さしすせそ",				kana : "さしすせそ" },
		{ word : "たちつてと",				kana : "たちつてと" },
		{ word : "なにぬねの",				kana : "なにぬねの" },
		{ word : "はひふへほ",				kana : "はひふへほ" },
		{ word : "まみむめも",				kana : "まみむめも" },
		{ word : "やゆよ",				kana : "やゆよ" },
		{ word : "らりるれろ",				kana : "らりるれろ" },
		{ word : "わをん",				kana : "わをん" },
		{ word : "がぎぐげご",				kana : "がぎぐげご" },
		{ word : "ざじずぜぞ",				kana : "ざじずぜぞ" },
		{ word : "だぢづでど",				kana : "だぢづでど" },
		{ word : "ばびぶべぼ",				kana : "ばびぶべぼ" },
		{ word : "きゃきゅきょ",				kana : "きゃきゅきょ" },
		{ word : "しゃしゅしょ",				kana : "しゃしゅしょ" },	
		{ word : "ちゃちゅちょ",				kana : "ちゃちゅちょ" },
		{ word : "にゃにゅにょ",				kana : "にゃにゅにょ" },
		{ word : "ひゃひゅひょ",				kana : "ひゃひゅひょ" },
		{ word : "みゃみゅみょ",			kana : "みゃみゅみょ" },
		{ word : "りゃりゅりょ",				kana : "りゃりゅりょ" },
		{ word : "ぎゃぎゅぎょ",				kana : "ぎゃぎゅぎょ" },
		{ word : "じゃじゅじょ",				kana : "じゃじゅじょ" },
		{ word : "ぢゃぢゅぢょ",				kana : "ぢゃぢゅぢょ" },
		{ word : "びゃびゅびょ",				kana : "びゃびゅびょ" },
		{ word : "ぴゃぴゅぴょ",				kana : "ぴゃぴゅぴょ" },
];

//1990
var words2:Array = [
		{ word : "やまとなでしこ",				kana : "やまとなでしこ" },
		{ word : "となりのトトロ",				kana : "となりのととろ" },
		{ word : "当たり前だのクラッカー",			kana : "あたりまえだのくらっかー" },
		{ word : "よっこいしょういち",				kana : "よっこいしょういち" },
		{ word : "恥ずかしながら帰って参りました",	kana : "はずかしながらかえってまいりました" },
		{ word : "目の付け所がシャープでしょ",		kana : "めのつけどころがしゃーぷでしょ" },
		{ word : "銀座に山買うだ",				kana : "ぎんざにやまかうだ" },
		{ word : "私はコレで会社を辞めました",		kana : "わたしはこれでかいしゃをやめました" },
		{ word : "亭主元気で留守がいい",		kana : "ていしゅげんきでるすがいい" },
		{ word : "今宵はここまでに致しとうござりまする",kana : "こよいはここまでにいたしとうござりまする" },
		{ word : "同情するなら金をくれ",			kana : "どうじょうするならかねをくれ" },
		{ word : "リビングウィル",				kana : "りびんぐうぃる" },
		{ word : "アッシー君",					kana : "あっしーくん" },
		{ word : "メッシー君",					kana : "めっしーくん" },
		{ word : "ミツグ君",					kana : "みつぐくん" },
		{ word : "ふつうは汚職と申します",			kana : "ふつうはおしょくともうします" },
		{ word : "チョベリバ",					kana : "ちょべりば" },
		{ word : "何時何分何秒地球が何回回った日",	kana : "なんじなんぷんなんびょうちきゅうがなんかいまわったひ" },
		{ word : "ノストラダムスの大予言",			kana : "のすとらだむすのだいよげん" },
		{ word : "トレンディドラマ",				kana : "とれんでぃどらま" },
		{ word : "ユニバーサルインシュアランス",		kana : "ゆにばーさるいんしゅあらんす" },
		{ word : "僕は死にましぇーん",			kana : "ぼくはしにましぇーん" },
		{ word : "蟻が鯛なら芋虫ゃクジラ",		kana : "ありがたいならいもむしゃくじら" },
		{ word : "コーラばっかり飲んでると骨が溶けるよ",	kana : "こーらばっかりのんでるとほねがとけるよ" },
		{ word : "日本航空労働組合",			kana : "にほんこうくうろうどうくみあい" },
		{ word : "アウトオブ眼中",				kana : "あうとおぶがんちゅう" },
		{ word : "新人類",					kana : "しんじんるい" },
		{ word : "三分間待つのだぞ",			kana : "さんぷんかんまつのだぞ" },
		{ word : "24時間戦えますか",			kana : "24じかんたたかえますか" },
		{ word : "タイムマシンはドラム式",			kana : "たいむましんはどらむしき" },		
];

//セリフ
var words3:Array = [
		{ word : "振り返れば奴がいる",				kana : "ふりかえればやつがいる" },
		{ word : "ハレルヤチャンス",					kana : "はれるやちゃんす" },
		{ word : "モルヒネ打っとけ",					kana : "もるひねうっとけ" },
		{ word : "彼は最高の技術を持ってる",			kana : "かれはさいこうのぎじゅつをもってる" },
		{ word : "俺の意見とピッタリだ",				kana : "おれのいけんとぴったりだ" },
		{ word : "ただ、技術は最高でした",			kana : "ただ、ぎじゅつはさいこうでした" },
		{ word : "わざとなんだよそれがさ",				kana : "わざとなんだよそれがさ" },
		{ word : "あなた次第でしょ",					kana : "あなたしだいでしょ" },
		{ word : "事実無根だ",					kana : "じじつむこんだ" },
		{ word : "僕に指図をするのはもう止めて頂けませんか",	kana : "ぼくにさしずをするのはもうやめていただけませんか" },
		{ word : "ものもらいが通用するのも今回だけですよ",	kana : "ものもらいがつうようするのもこんかいだけですよ" },
		{ word : "マニュアル通りにしか動けませんか",		kana : "まにゅあるどおりにしかうごけませんか" },
		{ word : "死なせない方法ならいくらでもある",		kana : "しなせないほうほうならいくらでもある" },
		{ word : "休養が必要なんだよ",				kana : "きゅうようがひつようなんだよ" },
		{ word : "話面白くしてどうすんだよ",			kana : "はなしおもしろくしてどうすんだよ" },
		{ word : "安っぽいヒューマニズム",				kana : "やすっぽいひゅーまにずむ" },
		{ word : "僕がここを去るときはあなたも当然一緒だ",	kana : "ぼくがここをさるときはあなたもとうぜんいっしょだ" },
		{ word : "認めちゃっていいんですか",			kana : "みとめちゃっていいんですか" },
		{ word : "本人とみんなのためだったんです",		kana : "ほんにんとみんなのためだったんです" },
		{ word : "君はドクターを辞めるべきだ",			kana : "きみはどくたーをやめるべきだ" },
		{ word : "今の地位を離れたくなければじっとしていることです", kana : "いまのちいをはなれたくなければじっとしていることです" },
		{ word : "財前教授の総回診です",			kana : "ざいぜんきょうじゅのそうかいしんです" },
		{ word : "壱岐君、退陣や",					kana : "いきくん、たいじんや" },
		{ word : "ドラスチックなトップ人事",				kana : "どらすちっくなとっぷじんじ" },
		{ word : "石油の一滴は血の一滴",			kana : "せきゆのいってきはちのいってき" },
];
		

//ことわざ
var words4:Array = [
		{ word : "犬も歩けば棒に当たる",				kana : "いぬもあるけばぼうにあたる" },
		{ word : "井の中の蛙大海を知らず",			kana : "いのなかのかわずたいかいをしらず" },
		{ word : "山椒は小粒でもぴりりと辛い",			kana : "さんしょうはこつぶでもぴりりとからい" },
		{ word : "石の上にも三年",					kana : "いしのうえにもさんねん" },
		{ word : "石橋を叩いて渡る",				kana : "いしばしをたたいてわたる" },
		{ word : "鬼が出るか蛇が出るか",				kana : "おにがでるかじゃがでるか" },
		{ word : "飼い犬に手を噛まれる",				kana : "かいいぬにてをかまれる" },
		{ word : "君子危うきに近寄らず",				kana : "くんしあやうきにちかよらず" },
		{ word : "渡る世間に鬼はない",				kana : "わたるせけんにおにはない" },
		{ word : "笑う門には福来たる",				kana : "わらうかどにはふくきたる" },
		{ word : "桃栗三年柿八年",				kana : "ももくりさんねんかきはちねん" },
		{ word : "元の鞘に納まる",					kana : "もとのさやにおさまる" },
		{ word : "目は口ほどにものを言う",				kana : "めはくちほどにものをいう" },
		{ word : "焼け石に水",					kana : "やけいしにみず" },
		{ word : "豚に真珠",						kana : "ぶたにしんじゅ" },
		{ word : "坊主憎けりゃ袈裟まで憎い",			kana : "ぼうずにくけりゃけさまでにくい" },
		{ word : "二度あることは三度ある",			kana : "にどあることはさんどある" },
		{ word : "情けは人の為ならず",				kana : "なさけはひとのためならず" },
		{ word : "毒をもって毒を制す",				kana : "どくをもってどくをせいす" },
		{ word : "人の振り見て我が振り直せ",			kana : "ひとのふりみてわがふりなおせ" },
		{ word : "雨降って地固まる",				kana : "あめふってじかたまる" },
		{ word : "とかげの尻尾切り",				kana : "とかげのしっぽきり" },
		{ word : "河童の川流れ",	　				kana : "かっぱのかわながれ" },
		{ word : "九死に一生を得る",				kana : "きゅうしにいっしょうをえる" },
		{ word : "出る杭は打たれる",				kana : "でるくいはうたれる" },
];

//
var words5:Array = [
		{ word : "雨の日に傘を取り上げ、晴れの日に傘を貸す。",		kana : "あめのひにかさをとりあげ、はれのひにかさをかす。" },
		{ word : "IPアドレスが分かれば捜査は半分終わったようなもの",	kana : "ipあどれすがわかればそうさははんぶんおわったようなもの" },
		{ word : "健康のためなら死んでもいい",					kana : "けんこうのためならしんでもいい" },
		{ word : "ファティマ第三の予言",						kana : "ふぁてぃまだいさんのよげん" },
		{ word : "忘れるまでは覚えておくよ",					kana : "わすれるまではおぼえておくよ" },
		{ word : "俺は差別と韓国人が死ぬほど嫌いだ",			kana : "おれはさべつとかんこくじんがしぬほどきらいだ" },
		{ word : "そこの十字路を右に左折してください",			kana : "そこのじゅうじろをみぎにさせつしてください" },
		{ word : "バカめ、それは残像だ",						kana : "ばかめ、それはざんぞうだ" },
		{ word : "こちら側のどこからでも切れます",				kana : "こちらがわのどこからでもきれます" },
		{ word : "夢だけど夢じゃなかった",						kana : "ゆめだけどゆめじゃなかった" },
		{ word : "テレビを見る時は、部屋を明るくしてはなれて見てください",	kana : "てれびをみるときは、へやをあかるくしてはなれてみてください" },
		{ word : "東京ディズニーリゾート",						kana : "とうきょうでぃずにーりぞーと" },
		{ word : "訴状を見ていないのでコメント出来ません",			kana : "そじょうをみていないのでこめんとできません" },
		{ word : "などと供述しており動機は未だ不明",			kana : "などときょうじゅつしておりどうきはいまだふめい" },
		{ word : "関係者は困惑を隠しきれません",				kana : "かんけいしゃはこんわくをかくしきれません" },
		{ word : "CMの途中ですがここで臨時ニュースです",			kana : "cmのとちゅうですがここでりんじにゅーすです" },
		{ word : "好きなタイプはお金持ちの人",					kana : "すきなたいぷはおかねもちのひと" },
		{ word : "俺、未来から来たって言ったら笑う？",			kana : "おれ、みらいからきたっていったらわらう？" },
		{ word : "お前んち、おっばっけやーしきー",				kana : "おまえんち、おっばっけやーしきー" },
		{ word : "ブクロにキングはいらねーんだよ",				kana : "ぶくろにきんぐはいらねーんだよ" },
		{ word : "明日やろうは馬鹿野郎だ",					kana : "あしたやろうはばかやろうだ" },
		{ word : "法の前には何人も平等ではないのか",			kana : "ほうのまえにはなんぴともびょうどうではないのか" },
];
var words6:Array = [
		{ word : "日本の未来はWOWWOWWOWWOW",				kana : "にっぽんのみらいはwowwowwowwow" },
		{ word : "恋の呪文はスキトキメキトキス",				kana : "こいのじゅもんはすきときめきときす" },
		{ word : "自宅警備は遊びじゃないんだよ",				kana : "じたくけいびはあそびじゃないんだよ" },
		{ word : "アウシュビッツ強制収容所",					kana : "あうしゅびっつきょうせいしゅうようじょ" },
		{ word : "ありがとう、食物連鎖の下の人",				kana : "ありがとう、しょくもつれんさのしたのひと" },
		{ word : "貰えるもんはもろといたらええんや",				kana : "もらえるもんはもろといたらええんや" },
		{ word : "ブルートゥース",							kana : "ぶるーとぅーす" },
		{ word : "ブルータス、お前もか",						kana : "ぶるーたす、おまえもか" },
		{ word : "厳正なる教授選遂行のためだ",				kana : "げんせいなるきょうじゅせんすいこうのためだ" },
		{ word : "お金を稼ぐことがいけない事でしょうか",			kana : "おかねをかせぐことがいけないことでしょうか" },
		{ word : "ああ言えば上祐",							kana : "ああいえばじょうゆう" },
		{ word : "乗るしかないこのビッグウェーブに",				kana : "のるしかないこのびっぐうぇーぶに" },
		{ word : "正しいことをしたければ偉くなれ",				kana : "ただしいことをしたければえらくなれ" },
		{ word : "事件は会議室で起きてるんじゃない現場で起きてるんだ",kana : "じけんはかいぎしつでおきてるんじゃないげんばでおきてるんだ" },
		{ word : "アンフェアなのは誰か",						kana : "あんふぇあなのはだれか" },
		{ word : "アテンションプリーズ",						kana : "あてんしょんぷりーず" },
		{ word : "国立大学の教授だから厳しく罪を問うとはどういうことだ",kana : "こくりつだいがくのきょうじゅだからきびしくつみをとうとはどういうことだ" },
		{ word : "あのー、犯人わかっちゃったんですけど",			kana : "あのー、はんにんわかっちゃったんですけど" },
		{ word : "今夜は、たった一人の人に巡り会えたような気がする",	kana : "こんやは、たったひとりのひとにめぐりあえたようなきがする" },
		{ word : "誠意って何かね",							kana : "せいいってなにかね" },
		{ word : "そのミサイルとやらをお教え願えませんでしょうか",		kana : "そのみさいるとやらをおおしえねがえませんでしょうか" },
		{ word : "レジ打ちも営業する",						kana : "れじうちもえいぎょうする" },
		{ word : "まいっちんぐマチコ先生",						kana : "まいっちんぐまちこせんせい" },
		{ word : "金は命より重い",							kana : "かねはいのちよりおもい" },
];
var words7:Array = [
		{ word : "生麦生米生卵",						kana : "なまむぎなまごめなまたまご" },
		{ word : "青巻紙赤巻紙黄巻紙",					kana : "あおまきがみあかまきがみきまきがみ" },
		{ word : "隣の客はよく柿食う客だ",				kana : "となりのきゃくはよくかきくうきゃくだ" },
		{ word : "東京特許許可局",					kana : "とうきょうとっきょきょかきょく" },
		{ word : "すもももももももものうち",					kana : "すもももももももものうち" },
		{ word : "坊主が屏風に上手に坊主の絵を描いた",		kana : "ぼうずがびょうぶにじょうずにぼうずのえをかいた" },
		{ word : "蛙ぴょこぴょこ三ぴょこぴょこ",				kana : "かえるぴょこぴょこみぴょこぴょこ" },
		{ word : "お綾や、母親にお謝りなさい",				kana : "おあやや、ははおやにおあやまりなさい" },
		{ word : "犯人は20代から30代、もしくは40代から50代",	kana : "はんにんは20だいから30だい、もしくは40だいから50だい" },
		{ word : "ご指導ご鞭撻の程宜しくお願い致します",		kana : "ごしどうごべんたつのほどよろしくおねがいいたします" },
		{ word : "手術不能の癌で死すことを、心より恥じる",	kana : "しゅじゅつふのうのがんでしすことを、こころよりはじる" },
		{ word : "ご好意に甘えてばかりで恐縮でございます",		kana : "ごこういにあまえてきょうしゅくでございます" },
		{ word : "右耳の2ミリ右にミニ右耳",				kana : "みぎみみの2みりみぎにみにみぎみみ" },
		{ word : "こんな重要事項を勝手に決めてくるなど非常識極まる",	kana : "こんなじゅうようじこうをかってにきめてくるなどひじょうしききわまる" },
		{ word : "生意気な口を叩くな",					kana : "なまいきなくちをたたくな" },
		{ word : "感情的でご都合主義",					kana : "かんじょうてきでごつごうしゅぎ" },
		{ word : "生きて歴史の証人たれ",					kana : "いきてれきしのしょうにんたれ" },
		{ word : "私勝ち馬に乗り換えるの得意なんです",		kana : "わたしかちうまにのりかえるのとくいなんです" },
		{ word : "鶴は千年亀は万年",					kana : "つるはせんねんかめはまんねん" },
		{ word : "無い袖は振れない",					kana : "ないそではふれない" },
		{ word : "備えあれば憂いなし",					kana : "そなえあればうれいなし" },
		{ word : "器用貧乏",							kana : "きようびんぼう" },
		{ word : "百聞は一見に如かず",					kana : "ひゃくぶんはいっけんにしかず" },	
		{ word : "手錠忘れちゃったんで貸してもらっていいすか",	kana : "てじょうわすれちゃったんでかしてもらっていいすか"},
];
