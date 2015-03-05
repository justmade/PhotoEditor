package managermodule
{
	public class PhotoEffectManager
	{
		private static var _instance:PhotoEffectManager;
		
		public function PhotoEffectManager(lock:Lock)
		{
			
		}
		
		public static function getInstance():PhotoEffectManager
		{
			if(_instance == null){
				_instance = new PhotoEffectManager(new Lock());
			}
			return _instance;
		}
	}
}class Lock{}