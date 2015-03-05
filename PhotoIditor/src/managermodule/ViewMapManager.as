package managermodule
{
	import datamodule.ViewMapVo;
	
	import flash.utils.Dictionary;

	public class ViewMapManager
	{
		private static var _instance:ViewMapManager;
		
		private var viewMapDic:Dictionary ; 
		
		public var viewMapNameArr:Array ; 
		
		public function ViewMapManager(lock:Lock)
		{
			
		}
		
		public static function getInstance():ViewMapManager
		{
			if(_instance == null){
				_instance = new ViewMapManager(new Lock());
			}
			return _instance;
		}
		
		public function init(xml:XML = null):void
		{
			viewMapDic = new Dictionary();
			viewMapNameArr = new Array();
			for(var i:int =0;i<xml.children().length();i++){
				var vo:ViewMapVo = ViewMapVo.createViewMapVo(xml.children()[i]);
				viewMapDic[vo.code] = vo;
				viewMapNameArr[i] = vo.className ; 
			}
		}
		
		public function getViewMapByCode(_code:String):ViewMapVo{
			if(viewMapDic[_code]){
				return viewMapDic[_code];
			}else{
				return null;
				trace("没有此code的小地图", _code);
			}
		}
			
	}
}class Lock{}