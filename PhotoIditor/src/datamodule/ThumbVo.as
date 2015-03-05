package datamodule
{
	public class ThumbVo
	{
		
		public var name:String ;
		
		public var code:String ;
		
		public var className:String;
		
		public var picType:String ; 
		
		public function ThumbVo()
		{
		}
		
		public static function createThumbVo(_xml:XML):ThumbVo{
			var obj:ThumbVo = new ThumbVo();
			obj.name = _xml.@name ;
			obj.code = _xml.@code ;  
			obj.className = _xml.@className;  
			obj.picType = _xml.@picType;  
			return obj;
		}
	}
}