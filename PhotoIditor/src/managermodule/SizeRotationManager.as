package managermodule
{
	import com.greensock.TweenMax;
	
	import core.operations.OperationsManager;
	
	import datamodule.ChooseMapVo;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.utils.setTimeout;
	
	import myui.event.ChoosePictureEvent;
	import myui.event.MySlideEvent;
	import myui.myslidelist.PictureOptions;
	
	import ui.ImageFrame;
	import ui.ImageModify;
	import ui.PicOptions;
	
	public class SizeRotationManager extends Sprite
	{
		private static var _instance:SizeRotationManager;
		
		private var skin:ui.ImageModify;
		//图片初始点
		private var imgOriginalPoint:Point;
		//修改框初始点
		private var originalPoint:Point ; 
		//图片宽
		private var picWith:Number = 83;
		//图片高
		private var picHeight:Number = 83;
		//总容器
		public var modifySp:Sprite = new Sprite ;
		
		private var imageFrame:ImageFrame;
		
		private var _stage:Stage ;
		
		public var selectedPic:*;
		
		private var tempWidth:int ; 
		
		private var tempHeight:int;
		//注册点
		private var regPoint:Point;
		//旋转球到中心点半径
		private var rotationRadius:int ;
		//右上角点到中心距离
		private var rectRadius:int;
		//右上角点到中心弧度'
		private var rectRadian:Number
		
		private var tempRadian:Number ;
		
		private var imageFrameRotation:Number = -Math.PI/ 2
		//选择时的半径
		private var chooseDistance:Number = 0;
		//前一次的缩放值
		private var preScale:Number =1; 
		//当前的缩放值
		private var nowScale:Number = 1;
		//用于缩放的小球
		private var dragBall:Sprite ;
		//编辑框
		private var editorFrame:Sprite ;
		
		private var rotationBall:Sprite ; 
		
		private var scaleLock:Boolean = true ; 
		
		private var selecetMapVo:ChooseMapVo;
		
		private var changeX:int ;
		
		private var changeY:int;
		
		public var bgCanMove:Boolean = true ;
		
		private var pictureArea:Sprite;
		
		
		
		
		public function SizeRotationManager(lock:Lock)
		{
			init();
//			this.addEventListener(Event.ADDED_TO_STAGE , onAddStage);
		}
		
		public static function getInstance():SizeRotationManager
		{
			if(_instance == null){
				_instance = new SizeRotationManager(new Lock());
			}
			return _instance;
		}
		public function setStage(_stage:Stage):void{
			this._stage = _stage;
		}
		private function init():void
		{
			initDragBall();
			initEditorFrame();
			initRotationBall();
			skin = new ImageModify();
			dragBall.addEventListener(MouseEvent.MOUSE_DOWN , onChoosePos);
//			skin.BtnControl.addEventListener(MouseEvent.MOUSE_DOWN , onSelecetBall);
			rotationBall.addEventListener(MouseEvent.MOUSE_DOWN , onSelecetBall);
			skin.BtnRightUp.mouseChildren = false ;
			skin.BtnControl.mouseChildren = false ;
		}
		
		private function initDragBall():void{
			dragBall = new Sprite();
			dragBall.graphics.beginFill(0x00ff00,1);
			dragBall.graphics.drawCircle(0,0,20);
			dragBall.graphics.endFill();
		}
		
		private function initRotationBall():void{
			rotationBall = new Sprite();
			rotationBall.graphics.beginFill(0xffff00 , 0);
			rotationBall.graphics.drawCircle(0,0,20);
			rotationBall.graphics.endFill();
		}
		private function initEditorFrame():void{
			editorFrame = new Sprite();
			editorFrame.graphics.beginFill(0xffff00,0)
			editorFrame.graphics.lineStyle(12,0x0000ff , 1);
		}
		
		//选中旋转球
		private function onSelecetBall(e:MouseEvent):void
		{
			var num:int = (rotationBall.x - selectedPic.x) * (rotationBall.x - selectedPic.x) 
				+ (rotationBall.y - selectedPic.y) * (rotationBall.y - selectedPic.y)
			rotationRadius = Math.sqrt(num);
			rotationBall.startDrag();
			_stage.addEventListener(MouseEvent.MOUSE_MOVE , onChangeRotation);
			_stage.addEventListener(MouseEvent.MOUSE_UP , onFinshRotation);
		}
		//变化角度
		private function onChangeRotation(e:MouseEvent):void{
			var dx:Number=rotationBall.x-selectedPic.x;
			var dy:Number=rotationBall.y-selectedPic.y;
			var radians:Number=Math.atan2(dy,dx);
			selectedPic.rotation=radians*180/Math.PI + 90;
			dragBall.rotation = radians*180/Math.PI + 90;
			imageFrameRotation = radians;
//			skin.BtnRightUp.rotation =skin.BtnRightDown.rotation
//				=skin.BtnLeftDown.rotation =skin.BtnLeftUp.rotation= radians*180/Math.PI + 90;
			reFreshBtn(radians + Math.PI / 2 +rectRadian);
			selecetMapVo._rotation =  radians*180/Math.PI + 90 ;
			selecetMapVo._controlBallRadian = imageFrameRotation ; 
		}
		
		private function reFreshBtn(_angle:Number):void
		{
			dragBall.x = rectRadius * Math.cos(_angle) + selectedPic.x ;
			dragBall.y = rectRadius * Math.sin(_angle) + selectedPic.y ;
			selecetMapVo._frameRadian = tempRadian = _angle;
			initControlPoint()
		}
		
		private function onFinshRotation(e:MouseEvent):void{
			rotationBall.stopDrag();
			rotationBall.x = skin.BtnControl.x;
			rotationBall.y = skin.BtnControl.y;
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE , onChangeRotation);
			_stage.removeEventListener(MouseEvent.MOUSE_UP , onFinshRotation);
			trace("	selecetMapVo._frameRadian ",selecetMapVo._frameRadian )
			saveOperation();
			var evt:MySlideEvent = new MySlideEvent(MySlideEvent.FINISH_SCALE);
			this.dispatchEvent(evt);
		}
		
		

		private function onChoosePos(e:MouseEvent):void{
			if(scaleLock==false){
				return ;
			}
			dragBall.startDrag();
			originalPoint = new Point(skin.BtnRightUp.x- selectedPic.x, skin.BtnRightUp.y- selectedPic.y);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE , onChangeSize);
			_stage.addEventListener(MouseEvent.MOUSE_UP , onFinshChange);
			chooseDistance = Math.sqrt(originalPoint.x * originalPoint.x + originalPoint.y * originalPoint.y);
			tempRadian = Math.atan2(originalPoint.y , originalPoint.x);
		}
		
		//开始修改
		private function onChangeSize(e:MouseEvent):void{
//			dragBall.x = _stage.mouseX ;
//			dragBall.y = _stage.mouseY ;
			refreshSize();
		}
		
		public var miniScaleNum:int = 100;
		
		//更改选择框的大小
		private function refreshSize():void{
			var ix:Number = dragBall.x - selectedPic.x;
			var iy:Number = dragBall.y - selectedPic.y;
			var dis:Number= Math.sqrt(ix*ix + iy*iy);
			if(dis<miniScaleNum){
				dis = miniScaleNum ;
//				return ; 
			}
			rectRadius = dis ; 
			var sX:Number  = preScale *dis / 	chooseDistance ;
			nowScale = sX
			refreshImg(sX,sX);
		}
		//更新传入的图片
		private function refreshImg(_scalex:Number ,_scaley:Number ):void{
			tempWidth = picWith * _scalex ;
			tempHeight= picHeight * _scaley ;
			(selectedPic as DisplayObject).scaleX = _scalex;
			(selectedPic as DisplayObject).scaleY = _scaley;
			initControlPoint();
		}
		
		
		//缩放完成
		private function onFinshChange(e:MouseEvent = null):void{
			scaleLock = false ; 
//			selecetMapVo._height = tempheight ;
//			selecetMapVo._width = tempWidth ;
			selecetMapVo._scale = nowScale ; 
			selecetMapVo._rectRadius = rectRadius ;
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE , onChangeSize);
			_stage.removeEventListener(MouseEvent.MOUSE_UP , onFinshChange);
			dragBall.stopDrag();
			setTimeout(scaleFinsh , 200)
		}
		
		private function scaleFinsh():void
		{
			scaleLock = true;
			preScale = nowScale;
			imgOriginalPoint.x = 100;
			imgOriginalPoint.y = selectedPic.y ;//- selectedPic.height;
			dragBall.x = skin.BtnRightUp.x ;
			dragBall.y = skin.BtnRightUp.y ;
//			rectRadius = Math.sqrt((dragBall.x - selectedPic.x) * (dragBall.x - selectedPic.x) 
//				+ (dragBall.y - selectedPic.y) * (dragBall.y - selectedPic.y));
			rotationBall.x = skin.BtnControl.x;
			rotationBall.y = skin.BtnControl.y;
			saveOperation();
			var evt:MySlideEvent = new MySlideEvent(MySlideEvent.FINISH_SCALE);
			this.dispatchEvent(evt);
		}
		
		/**
		 *复位图片 
		 * 
		 */
		public function setToInit():void{
			TweenMax.to(modifySp,.5,{x:0,y:0,onComplete:onCompleteReset});
				
		}
		
		/**
		 *图片复位完成 
		 * 
		 */
		private function onCompleteReset():void{
			selecetMapVo.posX = 0;
			selecetMapVo.posY = 0;
			saveOperation();
		}
		
		//传入要修改的图片
		public function setPicture(vo:ChooseMapVo , pictureArea:Sprite):void{
			selecetMapVo = vo;
			var _pic:* = vo.pic;
			selectedPic = _pic;
			trace(vo.isReg , "isReg")
//			trace(_pic.parent.getChildIndex(_pic.parent.numChildren - 1));
			if(vo.isReg == false){
				trace("vo1",vo._frameRadian)
				modifySp = new Sprite();
				modifySp.addChild(selectedPic);
				imgOriginalPoint = new Point(selectedPic.x , selectedPic.y);
				modifySp.addChild(editorFrame);
				modifySp.addChild(skin);
				modifySp.addChild(dragBall)
				modifySp.addChild(rotationBall);
				pictureArea.addChildAt(modifySp , vo._childIndex);
				this.pictureArea = pictureArea;
				picWith = _pic.width/vo._scale;
				tempWidth = _pic.width;
				picHeight = _pic.height/vo._scale;
				tempHeight =_pic.height; 
				setRegPoint(selectedPic, new Point(_pic.width/2,_pic.height/2),vo._scale);
				skin.BtnRightUp.x =    selectedPic.x +selectedPic.width/2 ;
				skin.BtnRightUp.y =	 selectedPic.y- selectedPic.height /2; 
				rectRadius = Math.sqrt((skin.BtnRightUp.x - selectedPic.x) * (skin.BtnRightUp.x - selectedPic.x) 
					+ (skin.BtnRightUp.y - selectedPic.y) * (skin.BtnRightUp.y - selectedPic.y));
				vo.isReg = true;		
				
				tempRadian = rectRadian = Math.atan2(skin.BtnRightUp.y - selectedPic.y , skin.BtnRightUp.x - selectedPic.x);
				imageFrameRotation = -Math.PI/2;
				preScale = nowScale =vo._scale ; 
		
				vo._initialRadian = rectRadian ;
				vo._rectRadius = rectRadius ;
//				vo._scale = preScale ; 
				vo._frameRadian = vo._initialRadian = tempRadian;
				vo._width = picWith;
				vo._height = picHeight ;
				vo._controlBallRadian = imageFrameRotation ;
				miniScaleNum = vo._miniScale;
				saveOperation(true);
			}else{
				trace("vo2",vo._code)
				modifySp = selectedPic.parent ; 
				modifySp.addChild(selectedPic);
				imgOriginalPoint = new Point(selectedPic.x , selectedPic.y);
				modifySp.addChild(editorFrame);
				modifySp.addChild(skin);
				modifySp.addChild(dragBall)
				modifySp.addChild(rotationBall);
				pictureArea.addChildAt(selectedPic.parent , vo._childIndex);
				this.pictureArea = pictureArea;
				picWith = vo._width ;
				picHeight = vo._height;
				rectRadius = vo._rectRadius ; 
				miniScaleNum = vo._miniScale
				tempRadian = vo._frameRadian ;
				modifySp.x = changeX = vo.posX ;
				modifySp.y = changeY = vo.posY ;
				rectRadian = vo._initialRadian ; 
				skin.BtnRightUp.x = rectRadius * Math.cos(tempRadian) + selectedPic.x ;
				skin.BtnRightUp.y = rectRadius * Math.sin(tempRadian) + selectedPic.y ;
				
				 imageFrameRotation = vo._controlBallRadian ;
				preScale = vo._scale ; 
				tempWidth = picWith * preScale ;
				tempHeight = picHeight * preScale ;
			}
			adjustSelectedPic();
			initControlPoint();
			initBtnContro();
			dragBall.x = skin.BtnRightUp.x ;
			dragBall.y = skin.BtnRightUp.y ;
			editorFrame.addEventListener(MouseEvent.MOUSE_DOWN , onMoveSelectPic);
			_stage.addEventListener(MouseEvent.MOUSE_UP , onPutSelectPic_Up);
			modifySp.addEventListener(MouseEvent.MOUSE_DOWN , onClickPicture);
			getPictureType();
			saveOperation();
		}
		
		public function dragStart():void
		{
			modifySp.startDrag();
			
		}
		
		//点击图片识别类型
		private function onClickPicture(e:MouseEvent):void{
			getPictureType();
		}
		
		public function changeRectRadius(_selectedPic:* , picInitialScale:Number):void
		{
			selectedPic= selectedPic
			skin.BtnRightUp.x =    selectedPic.x +selectedPic.width * picInitialScale/2 ;
			skin.BtnRightUp.y =	 selectedPic.y- selectedPic.height * picInitialScale/2; 
			rectRadius = Math.sqrt((skin.BtnRightUp.x - selectedPic.x) * (skin.BtnRightUp.x - selectedPic.x) 
				+ (skin.BtnRightUp.y - selectedPic.y) * (skin.BtnRightUp.y - selectedPic.y));
			selecetMapVo._rectRadius = rectRadius ;
			initControlPoint()
			
		}
		
		private function getPictureType():void{
			var e:ChoosePictureEvent = new ChoosePictureEvent(ChoosePictureEvent.PICTURE_TYPE);
			if(selecetMapVo._picType == "bg"){
				e.picType = "bg";
				this.dispatchEvent(e);
			}else{
				e.picType = "thunb";
				this.dispatchEvent(e)
			}
		}
		
		
		private function adjustSelectedPic():void{
			var e:MySlideEvent = new MySlideEvent(MySlideEvent.CHANGE_OPTION_POS);
			selecetMapVo.posX = e.changeX = modifySp.x ;
			selecetMapVo.posY = e.changeY = modifySp.y ;
			this.dispatchEvent(e);
		}
		private var currentX:int ;
		private var currentY:int ; 
		
		private function onMoveSelectPic(e:MouseEvent):void{
			_stage.addEventListener(MouseEvent.MOUSE_MOVE , onMovePic);
			modifySp.startDrag();
			_stage.addEventListener(MouseEvent.MOUSE_UP , onPutSelectPic);
			initControlPoint();
		}
		
		private var tempMouseX:int = 0 ;
		private function onMovePic(e:MouseEvent):void{
			adjustSelectedPic();
			if(!bgCanMove && selecetMapVo._picType == "bg"){
				modifySp.x  = currentX ;
				modifySp.y = currentY ; 
			}else{
				currentX = modifySp.x ;
				currentY = modifySp.y ;
			}
		}
		
		private function onPutSelectPic_Up(e:MouseEvent):void{
			adjustSelectedPic();
			putSelectPic()
			_stage.removeEventListener(MouseEvent.MOUSE_UP , onPutSelectPic_Up);
		}
		
		private function putSelectPic():void{
			if(!bgCanMove && selecetMapVo._picType == "bg"){
				modifySp.x  = currentX ;
				modifySp.y = currentY ; 
			}
			modifySp.stopDrag();
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE , onMovePic);
		}
		
		private function onPutSelectPic(e:MouseEvent = null):void{
			adjustSelectedPic();
			putSelectPic()
			_stage.removeEventListener(MouseEvent.MOUSE_UP , onPutSelectPic);
			saveOperation();
		}
		
		private function initBtnContro():void{
			rotationBall.x = skin.BtnControl.x = tempHeight/2  * Math.cos(imageFrameRotation) + selectedPic.x ;
			rotationBall.y = skin.BtnControl.y = tempHeight/2  * Math.sin(imageFrameRotation) + selectedPic.y ;
		}
		
		public function initControlPoint():void{
			adjustSelectedPic();
			var radius:int = rectRadius  ;
			
			skin.BtnRightUp.x = radius * Math.cos(tempRadian) + selectedPic.x ;
			skin.BtnRightUp.y = radius * Math.sin(tempRadian) + selectedPic.y ;
			
			skin.BtnLeftUp.x = radius * Math.cos(tempRadian-2 * rectRadian+ Math.PI ) +  selectedPic.x 
			skin.BtnLeftUp.y =  radius * Math.sin(tempRadian-2 * rectRadian + Math.PI ) +  selectedPic.y
//			
			skin.BtnLeftDown.x =  radius * Math.cos(tempRadian -0 * rectRadian- Math.PI) +  selectedPic.x
			skin.BtnLeftDown.y =  radius * Math.sin(tempRadian - 0 * rectRadian- Math.PI)  + selectedPic.y 
			
			skin.BtnRightDown.x =    radius * Math.cos(tempRadian-2 * rectRadian) +  selectedPic.x 
			skin.BtnRightDown.y =   radius * Math.sin(tempRadian-2 * rectRadian) +  selectedPic.y;
			
			skin.BtnControl.x = (tempHeight)/2  * Math.cos(imageFrameRotation) + selectedPic.x ;
			skin.BtnControl.y = (tempHeight)/2  * Math.sin(imageFrameRotation) + selectedPic.y ;
			
			editorFrame.graphics.clear();
			editorFrame.graphics.beginFill(0xffff00,0)
			editorFrame.graphics.lineStyle(1,0x0000ff , 1);
			editorFrame.graphics.moveTo(skin.BtnRightUp.x , skin.BtnRightUp.y);
			editorFrame.graphics.lineTo(skin.BtnRightDown.x , skin.BtnRightDown.y);
			editorFrame.graphics.lineTo(skin.BtnLeftDown.x , skin.BtnLeftDown.y);
			editorFrame.graphics.lineTo(skin.BtnLeftUp.x , skin.BtnLeftUp.y);
			editorFrame.graphics.lineTo(skin.BtnRightUp.x , skin.BtnRightUp.y);
		}
		
		private var isFirstSet:Boolean = true;
		//设置中心点坐标
		private function setRegPoint(sprite:Sprite, point:Point,scale:Number = 1):Sprite
		{
			regPoint= point;
			var len:int = sprite.numChildren;
			while (len--) 
			{
				var tmpDisplay:DisplayObject = sprite.getChildAt(len);
				tmpDisplay.x = -point.x/scale;
				tmpDisplay.y = -point.y/scale;
			}
			sprite.x = imgOriginalPoint.x + regPoint.x;
		 	sprite.y = imgOriginalPoint.y + regPoint.y;
			return sprite ;
		}
		
		//删除图片
		public function destoryFun():void
		{
			if(modifySp && modifySp.parent){
				modifySp.removeChild(selectedPic);
				selectedPic = null
				modifySp.parent.removeChild(modifySp);
			}
		}
		
		public function getVo():ChooseMapVo{
			return selecetMapVo ;
		}
		
		private function saveOperation(isFirst:Boolean = false):void{
			selecetMapVo._isFirst = isFirst ; 
//			OperationsManager.getInstance().addOperation(selecetMapVo);
		}
		
		public function setOperationVo(vo:ChooseMapVo , pictureArea:Sprite):void{
			selecetMapVo = vo;
			var _pic:* = vo.pic;
			selectedPic = _pic;
			modifySp = new Sprite()
//			modifySp = selectedPic.parent ; 
			modifySp.addChild(selectedPic);
			imgOriginalPoint = new Point(selectedPic.x , selectedPic.y);
			modifySp.addChild(editorFrame);
			modifySp.addChild(skin);
			modifySp.addChild(dragBall)
			modifySp.addChild(rotationBall);
			pictureArea.addChildAt(selectedPic.parent , vo._childIndex);
			this.pictureArea = pictureArea;
			picWith = vo._width ;
			picHeight = vo._height;
			rectRadius = vo._rectRadius ; 
			miniScaleNum = vo._miniScale
			tempRadian = vo._frameRadian ;
			modifySp.x = changeX = vo.posX ;
			modifySp.y = changeY = vo.posY ;
			resumePicture();
			rectRadian = vo._initialRadian ; 
			skin.BtnRightUp.x = rectRadius * Math.cos(tempRadian) + selectedPic.x ;
			skin.BtnRightUp.y = rectRadius * Math.sin(tempRadian) + selectedPic.y ;
			
			imageFrameRotation = vo._controlBallRadian ;
			preScale = vo._scale ; 
			tempWidth = picWith * preScale ;
			tempHeight = picHeight * preScale ;
			
			adjustSelectedPic();
			initControlPoint();
			initBtnContro();
			dragBall.x = skin.BtnRightUp.x ;
			dragBall.y = skin.BtnRightUp.y ;
		}
		
		private function resumePicture():void{
			selectedPic.rotation=selecetMapVo._rotation ; 
			(selectedPic as DisplayObject).scaleX = selecetMapVo._scale;
			(selectedPic as DisplayObject).scaleY = selecetMapVo._scale;
		}
		
		public function hideEditorFrame():void{
			skin.visible = false ; 
			editorFrame.visible = false ; 
			dragBall.visible = false ; 
		}
		
		public function displayEditorFrame():void{
			skin.visible = true ; 
			editorFrame.visible = true ; 
			dragBall.visible = true
		}
		
		
	}
}class Lock{}