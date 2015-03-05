package core.savexmlmodule
{
	import datamodule.ChooseMapVo;
	
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;

	public class LoadSavedXml
	{
		private var file:FileReference ; 
		
		private var loadXml:XML

		public function LoadSavedXml()
		{
			initFile();
		}
		
		private function initFile():void{
			var fileF:FileFilter  = new FileFilter("xml","*.xml");
			file = new FileReference();
			file.browse([fileF]);
			file.addEventListener(Event.SELECT,onFileSelect);
		}
		private function onFileSelect(e:Event):void{
			file.removeEventListener(Event.SELECT,onFileSelect);
			file.addEventListener(Event.COMPLETE, onFileOpen);
			if(file.data == null){
				file.load();
			}
		}
		private function onFileOpen(e:Event):void
		{
			file.removeEventListener(Event.COMPLETE, onFileOpen);
			loadXml = XML(file.data);
			getThumb();
		}
		
		private function getThumb():void{
			for(var i:int =0;i<loadXml.buildingPosition.point.length();i++){
//				trace(loadXml.buildingPosition.children()[0].toXMLString() , "xml")
				var vo:ChooseMapVo = new ChooseMapVo();
				vo.initXML(loadXml.buildingPosition.children()[i]);
			}
		}
	}
}