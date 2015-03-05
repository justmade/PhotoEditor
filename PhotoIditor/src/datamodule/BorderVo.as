package datamodule
{
	public class BorderVo
	{
		public var name:String ; 
		
		public var swfUrl:String ; 
		
		public var spacingW:int ;
		
		public var spacingH:int ;
		
		public var picType:String ; 
		
		public var type:String ; 
		
		public var code:String ; 
		
		public var className:String;
		
		public var resClass:String ; 
		
		public function BorderVo()
		{
			
		}
		
		public static function createBorderVo(_xml:XML):BorderVo{
			var obj:BorderVo = new BorderVo();
			obj.name = _xml.@name ; 
			obj.swfUrl = _xml.@swf ; 
			obj.spacingW = _xml.@spacingW ; 
			obj.spacingH = _xml.@spacingH ; 
			obj.type = _xml.@type ; 
			obj.picType = _xml.@picType ; 
			obj.code = _xml.@code ; 
			obj.className = _xml.@className ; 
			obj.resClass =  _xml.@resClass ; 
			return  obj ; 
		}
	}
}