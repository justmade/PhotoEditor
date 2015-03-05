package loadmodule
{
	import flash.events.Event;
	
	public class LoadModuleEvent extends Event
	{
		public static const LOADING_MODULE_COMPLETE:String = "LOADING_MODULE_COMPLETE"; 
		public function LoadModuleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}