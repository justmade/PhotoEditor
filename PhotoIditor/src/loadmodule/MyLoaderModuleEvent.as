package loadmodule
{
	import flash.events.Event;
	
	public class MyLoaderModuleEvent extends Event
	{
		public static const XMLLOADCOMPELTE:String = "XMLLOADCOMPELTE";
		public function MyLoaderModuleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}