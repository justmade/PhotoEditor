package loadmodule
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.SWFLoader;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class MyItemLoader extends Sprite
	{
		private var baseUrl:String = "../Res/BorderSwf/" ; 
		
		private var loadingSp:Sprite = new Sprite();
		
		private var swfLoad:SWFLoader
		
		private var resClass:String ; 
		
		public function MyItemLoader(_swfUrl:String,_resClass:String)
		{
			init(_swfUrl,_resClass);
		}
		
		internal function init(_swfUrl:String,_resClass:String):void{
			resClass = _resClass ; 
			swfLoad = new SWFLoader(baseUrl + _swfUrl+".swf") ;
			swfLoad.addEventListener(LoaderEvent.COMPLETE , onLoadComplete);
			swfLoad.addEventListener(LoaderEvent.ERROR , onError);
			swfLoad.load();
			var tf:TextField = new TextField();
			tf.text = "Loading...";
			loadingSp.addChild(tf);
			this.addChild(loadingSp);
		}
		
		protected function onError(event:LoaderEvent):void
		{
			trace("读取失败")			
		}
		
		protected function onLoadComplete(event:LoaderEvent):void
		{
			if(this.contains(loadingSp)){
				this.removeChild(loadingSp);
			}
			var C:Class = swfLoad.getClass(resClass)  as Class ; 
			var mc:DisplayObject = new C();
			mc.width = mc.height = 500 ;
			this.addChild(mc);
		}
	}
}