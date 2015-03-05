package datamodule
{
	public class ViewMapVo
	{
		public var name:String ;
		
		public var code:String ;
		
		public var className:String;
		
		public var picType:String ; 
		
		
		public function ViewMapVo()
		{
			
		}
		
		public static function createViewMapVo(_xml:XML):ViewMapVo{
			var obj:ViewMapVo = new ViewMapVo();
			obj.name = _xml.@name ;
			obj.code = _xml.@code ;  
			obj.className = _xml.@className;  
			obj.picType = _xml.@picType;  
			return obj;
		}
		
		
	}
}