package managermodule
{
	import datamodule.BorderVo;
	
	import flash.utils.Dictionary;
	
	public class BorderManager
	{
		private static var _instance:BorderManager;
		
		private var borderDic:Dictionary ; 
		
		public var borderbNameArr:Array ; 
		
		public function BorderManager(lock:Lock)
		{
			
		}
		
		public static function getInstance():BorderManager
		{
			if(_instance == null){
				_instance = new BorderManager(new Lock());
			}
			return _instance;
		}	
		public function init(xml:XML = null):void
		{
			borderDic = new Dictionary();
			borderbNameArr = new Array();
			for(var i:int =0;i<xml.children().length();i++){
				var vo:BorderVo = BorderVo.createBorderVo(xml.children()[i]);
				borderDic[vo.code] = vo;
				borderbNameArr[i] = vo.code ; 
			}
		}
		
		public function getBorderByCode(_code:String):BorderVo{
			if(borderDic[_code]){
				return borderDic[_code];
			}else{
				return null;
				trace("没有此code的小地图", _code);
			}
		}
		
		
	}
}class Lock{}