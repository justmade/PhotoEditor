package core.operations
{
	import datamodule.ChooseMapVo;
	
	import flash.events.EventDispatcher;
	
	import myui.event.ChoosePictureEvent;

	public class OperationsManager extends EventDispatcher
	{
		private static var _instance:OperationsManager;
		
		public var operationArray:Array ; 
		
		private var currentIndex:int = -1;
		
		private var isRevoke:Boolean = false ; 
		public function OperationsManager(lock:Lock)
		{
			operationArray = new Array();
		}
		
		public static function getInstance():OperationsManager
		{
			if(_instance == null){
				_instance = new OperationsManager(new Lock());
			}
			return _instance;
		}
		
		public function addOperation(_vo:ChooseMapVo):void{
			if(_vo!=null){
				var vo:ChooseMapVo = new ChooseMapVo;
				vo.getVo(_vo) ;
			}else{
				vo = null;
			}
			if(!isRevoke){
				currentIndex ++ ;
			}else{
				isRevoke =false;
			}
			operationArray[currentIndex] = vo ;
			trace("add",currentIndex);
//			trace("_vo",_vo._isDelete)
			for(var i:int =operationArray.length - 1; i>currentIndex ; i-- ){
				operationArray.splice(i,1);
			}
		}
		
		public function revokeOperation():ChooseMapVo{
			if(currentIndex>0){
				isRevoke = true ;
				currentIndex = currentIndex - 1;
				trace("currentIndex",currentIndex);
				if(operationArray[currentIndex]==null){
					currentIndex -- ;
				}
				var vo:ChooseMapVo = new ChooseMapVo;
				vo.getVo(operationArray[currentIndex]) ;
				if(vo._isFirst){
					var evt:ChoosePictureEvent = new ChoosePictureEvent(ChoosePictureEvent.DELETE_PICTURE);
					evt.chooseVo = vo ;
					this.dispatchEvent(evt);
					trace("删除图片")
					return null;
				}
				if(vo._isDelete){
					 evt = new ChoosePictureEvent(ChoosePictureEvent.GET_DELETE_PICTURE);
					 evt.chooseVo = vo ;
					this.dispatchEvent(evt);
				}
				trace("vocode",vo._code)
				return vo;
			}else{
				trace("不能撤销")
				return null ;
			}
		}
		
		public function redoOperation():ChooseMapVo{
			if(currentIndex<operationArray.length - 1){
				currentIndex ++ ;
				trace("currentIndex",currentIndex)
				if(operationArray[currentIndex]==null){
					trace("删除的图片")
					var dvo:ChooseMapVo = new ChooseMapVo ;
					dvo.getVo(operationArray[currentIndex -1]) ;
					var ev:ChoosePictureEvent = new ChoosePictureEvent(ChoosePictureEvent.DELETE_PICTURE);
					ev.chooseVo = dvo ;
					this.dispatchEvent(ev);
					return null;
				}
				var vo:ChooseMapVo = new ChooseMapVo;
				vo.getVo(operationArray[currentIndex]) ;
				trace("redo",vo._code,currentIndex);
				if(operationArray[currentIndex-1]!= null&&operationArray[currentIndex-1]._isFirst){
					var evt:ChoosePictureEvent = new ChoosePictureEvent(ChoosePictureEvent.GET_DELETE_PICTURE);
					evt.chooseVo = vo ;
					this.dispatchEvent(evt);
					trace("还原图片");
				}
				return vo;
			}else{
				trace("不能前进")
				return null ;
			}
		}
	}
}class Lock{}