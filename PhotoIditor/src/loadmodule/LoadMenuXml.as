package loadmodule
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.XMLLoader;
	
	import datamodule.MainData;
	
	import flash.events.EventDispatcher;

	public class LoadMenuXml extends EventDispatcher
	{
		private var menuXml:XMLLoader;
		public function LoadMenuXml()
		{
			
		}
		
		public function loadFun():void{
			var url:String = "../Res/XML/MenuXml.xml?a="+String(Math.random())
			menuXml = new XMLLoader(url);
			menuXml.addEventListener(LoaderEvent.COMPLETE , onXmlLoaderComplete);
			menuXml.load(true);
			trace("init")
		}
		
		private function onXmlLoaderComplete(e:LoaderEvent):void{
			MainData.getInstance().menuXML = XML(menuXml.content);
			this.dispatchEvent(new MyLoaderModuleEvent(MyLoaderModuleEvent.XMLLOADCOMPELTE));;
		}
	}
}