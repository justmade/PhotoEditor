package managermodule
{
	import datamodule.ThumbVo;
	
	import flash.utils.Dictionary;

	public class ThumbManager
	{
		private static var _instance:ThumbManager;
		
		private var thumbDic:Dictionary ; 
		
		public var thumbNameArr:Array ; 
		
		public function ThumbManager(lock:Lock)
		{
			
		}
		
		public static function getInstance():ThumbManager
		{
			if(_instance == null){
				_instance = new ThumbManager(new Lock());
			}
			return _instance;
		}	
		public function init(xml:XML = null):void
		{
			thumbDic = new Dictionary();
			thumbNameArr = new Array();
			for(var i:int =0;i<xml.children().length();i++){
				var vo:ThumbVo = ThumbVo.createThumbVo(xml.children()[i]);
				thumbDic[vo.code] = vo;
				thumbNameArr[i] = vo.code ; 
			}
		}
		
		public function getViewMapByCode(_code:String):ThumbVo{
			if(thumbDic[_code]){
				return thumbDic[_code];
			}else{
				return null;
				trace("没有此code的小地图", _code);
			}
		}
		
		
	}
}class Lock{}