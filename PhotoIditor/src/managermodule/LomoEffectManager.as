package managermodule
{
	import datamodule.LomoEffectVo;
	
	import flash.utils.Dictionary;
	
	public class LomoEffectManager
	{
		private static var _instance:LomoEffectManager;
		
		private var effectDic:Dictionary ; 
		
		public var effectNameArr:Array ; 
		
		public function LomoEffectManager(lock:Lock)
		{
			
		}
		
		public static function getInstance():LomoEffectManager
		{
			if(_instance == null){
				_instance = new LomoEffectManager(new Lock());
			}
			return _instance;
		}	
		public function init(xml:XML = null):void
		{
			effectDic = new Dictionary();
			effectNameArr = new Array();
			for(var i:int =0;i<xml.children().length();i++){
				var vo:LomoEffectVo = LomoEffectVo.createLomoEffectVo(xml.children()[i]);
				effectDic[vo.code] = vo;
				effectNameArr[i] = vo.code ; 
			}
		}
		
		public function getLomoEffectByCode(_code:String):LomoEffectVo{
			if(effectDic[_code]){
				return effectDic[_code];
			}else{
				return null;
				trace("没有此code的小地图", _code);
			}
		}
		
		
	}
}class Lock{}