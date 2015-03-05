package datamodule
{
	public class ChooseMapVo
	{
		
		public var pic:*;
		
		public var isReg:Boolean;
		
		public var _rotation:Number ; 
		
		public var _height:int ;
		
		public var _width:int ;
		
		public var _scale:Number ;
		//数组里的下标
		public var _id:int ;
		//操作点的弧度
		public var _frameRadian:Number =1;
		//缩放的直径
		public var _rectRadius:int ;
		//选装球的弧度
		public var _controlBallRadian:Number = 1; 
		//初始的右上角与中心点的夹角
		public var _initialRadian:Number = 1;
		//内部图片的改变X
		public var posX:int ;
		//内部图片的改变Y
		public var posY:int ;
		
		public var _childIndex:int ;
		//总容器的X
		public var _x:int ;
		//总容器的Y
		public var  _y:int ;
		//图片类型（bg）
		public var _picType:String ;
		
		public var _code:String ;
		
		public var _name:String; 
		
		public var _miniScale:int;

		//第一次被放上舞台
		public var _isFirst:Boolean = false ;
		//
		public var _isDelete:Boolean = false ;
		
		public function ChooseMapVo()
		{
			
		}
		
		public function initXML(xml:XML):void{
			this.isReg = xml.@isReg ;
			this._rotation = xml.@rotation ;
			this._height = xml.@height ;
			this._width = xml.@width ; 
			this._scale = xml.@scale ;
			this._id = xml.@id ; 
			this._frameRadian = xml.@frameRadian ;
			this._rectRadius = xml.@rectRadius ; 
			this._controlBallRadian = xml.@controlBallRadian ;
			this._initialRadian = xml.@initialRadian ;
			this.posX = xml.@posX ;
			this.posY = xml.@posY ;
			this._childIndex = xml.@childIndex ;
			this._x = xml.@x ;
			this._y = xml.@y ;
			this._picType = xml.@picType ;
			this._code = xml.@code ;
			this._name = xml.@name ;
			this._miniScale = xml.@miniScale
		}
		
		public function getVo(_vo:ChooseMapVo):void{
			this.pic = _vo.pic;
			this.isReg = _vo.isReg ;
			this._rotation =_vo._rotation ;
			this._height = _vo._height ;
			this._width = _vo._width ; 
			this._scale = _vo._scale ;
			this._id = _vo._id ; 
			this._frameRadian = _vo._frameRadian ;
			this._rectRadius = _vo._rectRadius ; 
			this._controlBallRadian = _vo._controlBallRadian ;
			this._initialRadian = _vo._initialRadian ;
			this.posX = _vo.posX ;
			this.posY = _vo.posY ;
			this._childIndex = _vo._childIndex ;
			this._x = _vo._x ;
			this._y = _vo._y ;
			this._picType = _vo._picType ;
			this._code = _vo._code ;
			this._name = _vo._name ;
			this._miniScale = _vo._miniScale;
			this._isFirst = _vo._isFirst;
			this._isDelete = _vo._isDelete ;
		}
		
		
		
		
	}
}