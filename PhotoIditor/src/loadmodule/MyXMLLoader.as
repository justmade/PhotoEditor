package loadmodule
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.XMLLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class MyXMLLoader extends EventDispatcher
	{
		
		private var loader:LoaderMax ;
		private var xmlNames:Array = ["viewmap","thumb","borderres","LOMOeffect"];
		private var myXmlDic:Dictionary = new Dictionary();
		
		public function MyXMLLoader()
		{
			
		}
		public function init():void{
			loader = new LoaderMax();
			var baseUrl:String = "../Res/XML/";
			var versionStr:String = "?ver="+String(Math.random());
			loader.append(new XMLLoader(baseUrl + "viewmap.xml"+versionStr, {name:"viewmap"}));
			loader.append(new XMLLoader(baseUrl + "thumb.xml"+versionStr , {name:"thumb"}));
			loader.append(new XMLLoader(baseUrl + "borderres.xml"+versionStr , {name:"borderres"}));
			loader.append(new XMLLoader(baseUrl + "LOMOeffect.xml"+versionStr , {name:"LOMOeffect"}));
			loader.addEventListener(LoaderEvent.COMPLETE , onLoaderComplete);
			loader.load();
		}
		
		private function onLoaderComplete(e:LoaderEvent):void
		{
			for(var i:int = 0 ; i<xmlNames.length ; i++){
				var name:String = String(xmlNames[i]) ;
				var xmlStr:String = String(loader.getContent(name));
				myXmlDic[name] = xmlStr ;
			}
			this.dispatchEvent(new Event("myXMLLoaderComplete"));
		}
		
		public function getXmlByName(_name:String):String
		{
			return myXmlDic[_name] as String;
		}
	}
}