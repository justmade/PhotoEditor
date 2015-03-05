package managermodule
{
	import com.greensock.easing.Strong;
	import com.greensock.loading.SWFLoader;
	
	import core.mainmap.ViewMapBox;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	public class MySwfManager
	{
		private static var _instance:MySwfManager;
		
		private var swfLoaderDic:Dictionary = new Dictionary();
		public function MySwfManager(lock:Lock)
		{
			
		}
		
		public static function getInstance():MySwfManager
		{
			if(_instance == null){
				_instance = new MySwfManager(new Lock());
			}
			return _instance;
		}
		
		public function addLoader(_swfLoader:SWFLoader , _name:String):void{
			swfLoaderDic[_name] = _swfLoader;
		}
		
		private function getLoader(_swfName:String):SWFLoader{
			return swfLoaderDic[_swfName] as SWFLoader  ;
		}
		
		public function getMcImg(_swfName:String , vo:*):ViewMapBox
		{
			var _resClass:String = vo.className
			var l:SWFLoader = getLoader(_swfName);
			var C:Class = l.getClass(_resClass) as Class;
			var viewMapBox:ViewMapBox = new ViewMapBox();
			var sp:ViewMapBox = viewMapBox.getMapBitmap(C,vo);
			return sp;
		}
	}
}class Lock{}