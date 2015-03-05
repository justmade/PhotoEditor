package myui.myslidelist
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import myui.event.PicOptionEvent;
	
	import ui.PicOptions;
	
	public class PictureOptions extends Sprite
	{
		private var skin:PicOptions ; 
		public function PictureOptions()
		{
			super();
			init();
		}
		
		private function init():void{
			skin = new PicOptions();
			this.addChild(skin);
			skin.pictureDelete.addEventListener(MouseEvent.CLICK , onPicDelete);
			skin.pictureDown.addEventListener(MouseEvent.CLICK , onPicDown);
			skin.pictureUp.addEventListener(MouseEvent.CLICK , onPicUp);
		}
		
		private function onPicDelete(e:MouseEvent):void{
			dispatchFun("DELETE");
		}
		
		private function onPicDown(e:MouseEvent):void{
			dispatchFun("DOWN");
		}
		
		private function onPicUp(e:MouseEvent):void{
			dispatchFun("UP");
		}
		
		private function dispatchFun(_str:String):void{
			var e:PicOptionEvent = new PicOptionEvent(PicOptionEvent.PICTURE_CHANGE);
			e.state = _str ; 
			this.dispatchEvent(e);
		}
		
	}
}