package myui.event
{
	import datamodule.ChooseMapVo;
	
	import flash.events.Event;
	
	public class ChoosePictureEvent extends Event
	{
		public static const PICTURE_TYPE:String = "PICTURE_TYPE";
		//删除一次被加载的图片
		public static const DELETE_PICTURE:String = "DELETE_PICTURE";
		//添加被删除的图片
		public static const GET_DELETE_PICTURE:String = "GET_DELETE_PICTURE";
		
		
		public var picType:String ;
		public var chooseVo:ChooseMapVo ;
		public function ChoosePictureEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}