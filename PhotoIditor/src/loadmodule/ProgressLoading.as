package loadmodule
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class ProgressLoading
	{
		private static var _instance:ProgressLoading;
		
		public function ProgressLoading(lock:Lock)
		{
			
		}
		
		public static function getInstance():ProgressLoading
		{
			if(_instance == null){
				_instance = new ProgressLoading(new Lock());
			}
			return _instance;
		}
		
		private var baseUrl:String = "../Res/BorderSwf/" ; 
		
		public function getMc(_swfUrl:String,_resClass:String):Sprite{
			var m:MyItemLoader =  new MyItemLoader(_swfUrl,_resClass);
			return m;
		}
		
	}
}class Lock{}