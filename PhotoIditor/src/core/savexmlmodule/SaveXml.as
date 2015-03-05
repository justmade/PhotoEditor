package core.savexmlmodule
{
	import datamodule.ChooseMapVo;
	
	import flash.net.FileReference;

	public class SaveXml
	{
		
		private var mapInfoArr:Array ; 
		
		private var thumbArr:Array ; 
		public function SaveXml(_mapInfoArr:Array)
		{
			mapInfoArr = _mapInfoArr ; 
			thumbArr = new Array();
			creatXml();
		}
		private function creatXml():void{
			var xml:XML = <Data ></Data>; 
			for(var i:int = 0 ; i < mapInfoArr.length ; i++){
				var vo:ChooseMapVo = mapInfoArr[i] as ChooseMapVo; 
				if(vo._picType == "bg"){
					xml = <Data resName={vo._code} width={vo._width} height={vo._height} name={vo._name}></Data>;
					var  mapBackground:XML = <mapBackground className={vo._code} /> ;
					xml.appendChild(mapBackground)
				}
				else if(vo._picType == "thumb"){
					thumbArr.push(vo);
				}
			}
			var barrierInfo:XML = <buildingPosition></buildingPosition>;
			xml.appendChild(barrierInfo);
			for(i = thumbArr.length - 1;i>=0;i--){
				vo = thumbArr[i] as ChooseMapVo; 
				var childXML:XML = <point x ={vo._x} y ={vo._y} rotation={vo._rotation} className ={vo._code} 
				isReg={vo.isReg} id={vo._id} frameRadian={vo._frameRadian} rectRadius={vo._rectRadius} controlBallRadian={vo._controlBallRadian} 
				initialRadian={vo._initialRadian} posX={vo.posX} posY={vo.posY} childIndex={vo._childIndex} picType={vo._picType} code={vo._code} 
				name={vo._name}></point>;
				barrierInfo.appendChild(childXML);
			}
			var str:String = xml.toXMLString();
			str = '<?xml version="1.0" encoding="utf-8"?>' +"\n"+ str ;
			xml = XML(str);
			var fileR:FileReference = new FileReference();
			fileR.save(str,".xml");
		}
	}
}