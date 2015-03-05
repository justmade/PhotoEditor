package datamodule
{
	public class LomoEffectVo
	{
		public var name:String ;
		
		public var code:String ;
		
		public var className:String;
		
		public var picType:String ; 
		
		public var effectString:String ; 
		
		public var isBlack:Boolean ; 
		
		public function LomoEffectVo()
		{
		}
		public static function createLomoEffectVo(_xml:XML):LomoEffectVo{
			var obj:LomoEffectVo = new LomoEffectVo();
			obj.name = _xml.@name ;
			obj.code = _xml.@code ;  
			obj.className = _xml.@className;  
			obj.picType = _xml.@picType;  
			obj.effectString = _xml.@effectString;  
			if(_xml.@isBlack=="0"){
				obj.isBlack = false ;
			}else{
				obj.isBlack = true ;
			}
			return obj;
		}
	}
}