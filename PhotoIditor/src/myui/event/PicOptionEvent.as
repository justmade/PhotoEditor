package myui.event
{
	import flash.events.Event;
	
	public class PicOptionEvent extends Event
	{
		public static const PICTURE_CHANGE:String = "PICTURE_CHANGE";
		public function PicOptionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		public var state:String ;
	}
}