package loadmodule
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import managermodule.BorderManager;
	import managermodule.LomoEffectManager;
	import managermodule.MySwfManager;
	import managermodule.ThumbManager;
	import managermodule.ViewMapManager;

	public class MySwfLoad extends EventDispatcher
	{
		private var loadMax:LoaderMax; 
		private var context:LoaderContext = new LoaderContext(true, ApplicationDomain.currentDomain);
		private var myXml:MyXMLLoader ; 
		private var resNameArr:Array = ["viewmap" , "thumb","borderres","LOMOeffect"]
		public function MySwfLoad()
		{
			init();
		}
		
		private function init():void
		{
			loadMax = new LoaderMax({name:"queue", onComplete:completeHandler});
			var baseUrl:String = "../Res/LoadSwf/";
//			loadMax.append(new SWFLoader("../Res/LoadSwf/viewmap.swf"),{context: context, noCache:false})
			for(var i:int  = 0; i<resNameArr.length ; i++){
				var swfLoad:SWFLoader = new SWFLoader(baseUrl+resNameArr[i]+".swf?a="+String(Math.random()));
				MySwfManager.getInstance().addLoader(swfLoad ,resNameArr[i]);
				loadMax.append(swfLoad);
			}
			
			loadMax.load();
		}
		
		private function completeHandler(e:LoaderEvent):void
		{
			myXml = new MyXMLLoader();
			myXml.addEventListener("myXMLLoaderComplete" , onXmlComplete);
			myXml.init();
		}
		
		private function onXmlComplete(e:Event):void
		{
			ViewMapManager.getInstance().init(XML(myXml.getXmlByName("viewmap")));
			ThumbManager.getInstance().init(XML(myXml.getXmlByName("thumb")));
			BorderManager.getInstance().init(XML(myXml.getXmlByName("borderres")));
			LomoEffectManager.getInstance().init(XML(myXml.getXmlByName("LOMOeffect")));
			var evt:LoadModuleEvent = new LoadModuleEvent(LoadModuleEvent.LOADING_MODULE_COMPLETE);
			this.dispatchEvent(evt);
		}
		
	}
}