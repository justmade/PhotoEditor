package loadmodule
{
	import core.mainmap.ViewMapBox;
	
	import datamodule.MainData;
	import datamodule.ViewMapVo;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;

	public class UpLoadPicture extends EventDispatcher
	{
		private var imageFile:FileReference ;
		private var bmpLoader:Loader ;
		private var picBitmap:Bitmap;
		private var picBitmapData:BitmapData ;
		private var pic:ViewMapBox ;
		public function UpLoadPicture()
		{
			init();
		}
		
		private function init():void{
			onImageFile();
			imageFile.addEventListener(Event.SELECT,onLoadopen);
			imageFile.addEventListener(Event.COMPLETE,onLoadFin);
		}
		
		private function onImageFile():void
		{
			var textTypeFilter:FileFilter = new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)","*.jpg;*.jpeg;*.gif;*.png");
			imageFile = new FileReference  ;
			imageFile.browse([textTypeFilter]);
		}
		
		private function onLoadopen(e:Event):void
		{
			e.currentTarget.load();
		}
		
		private function onLoadFin(e:Event):void
		{
			bmpLoader = new Loader  ;
			bmpLoader.loadBytes(imageFile.data);
			bmpLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadComplete);
		}
		
		private function onLoadComplete(e:Event):void{
			picBitmap = Bitmap(bmpLoader.content);
			picBitmapData = picBitmap.bitmapData ; 
			var viewMapBox:ViewMapBox = new ViewMapBox();
			viewMapBox.mapBitmap = picBitmap ;
			viewMapBox.mapBitmapData = picBitmapData ;
			viewMapBox.mapCode = String(MainData.getInstance().userName + MainData.getInstance().userUpLoadNum) ; 
			viewMapBox.mapName =  String(MainData.getInstance().userName + MainData.getInstance().userUpLoadNum) ;
			viewMapBox.picType = "bg" ;
			
			pic = viewMapBox.creatViewMapBox(picBitmap);
			
			var viewMapVo:ViewMapVo = new ViewMapVo();
			viewMapVo.code = String(MainData.getInstance().userName + MainData.getInstance().userUpLoadNum);
			viewMapVo.name =viewMapVo.code ; 
			viewMapVo.picType = "bg" ; 
			MainData.getInstance().userUpLoadNum++ ; 
			
			this.dispatchEvent(new Event("UpLoadPicComplete"))
		}
		
		public function getPic():ViewMapBox{
			return pic ;
		}
		
	}
}