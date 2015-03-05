package myui.event
{
	import flash.events.Event;
	
	public class MySlideEvent extends Event
	{
		public static const CHOOSE_BT:String = "CHOOSE_BT";
		public static const CHANGE_OPTION_POS:String = "CHANGE_OPTION_POS";
		public static const FINISH_SCALE:String = "FINISH_SCALE";
		public function MySlideEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		public var changeX:int ;
		public var changeY:int ;
	}
}