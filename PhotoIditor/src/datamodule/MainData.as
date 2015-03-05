package datamodule
{
	public class MainData
	{
		private static var _instance:MainData;
		public var menuXML:XML;
		public var userUpLoadNum:int ;
		public var userName:String = "userName"
		
		public function MainData(lock:Lock)
		{
			
		}
		
		public static function getInstance():MainData
		{
			if(_instance == null){
				_instance = new MainData(new Lock());
			}
			return _instance;
		}	
	
	}
}class Lock{}