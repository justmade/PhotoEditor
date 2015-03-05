package core.mainmap
{
	import datamodule.ViewMapVo;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	public class ViewMapBox extends Sprite
	{
		public var mapBitmapData:BitmapData;
		
		public var mapCode:String;
		
		public var mapBitmap:Bitmap;
		
		public var picType:String;
		
		public var mapName:String ; 
		
		public function ViewMapBox()
		{
			
		}
		
		public  function getMapBitmap(_resClass:Class,vo:*):ViewMapBox
		{
			mapBitmapData = new _resClass();
			mapBitmap = new Bitmap(mapBitmapData);
			mapCode = vo.code;
			picType = vo.picType ; 
			mapName = vo.name
			this.addChild(mapBitmap);
			return this;
		}
		
		public function creatViewMapBox(bitmap:Bitmap):ViewMapBox{
			this.addChild(mapBitmap);
			return this;
		}
	}
}