package managermodule
{
	import fl.motion.ColorMatrix;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;

	public class AddLomoEffect
	{
		private static var _instance:AddLomoEffect;
		
		private var _Matrix:ColorMatrix=new ColorMatrix();
		
		private var _Filter:ColorMatrixFilter=new ColorMatrixFilter();
		
		public function AddLomoEffect(lock:Lock)
		{
			
		}
		
		public static function getInstance():AddLomoEffect
		{
			if(_instance == null){
				_instance = new AddLomoEffect(new Lock());
			}
			return _instance;
		}
		
		public function changeEffect(_bgBitmap:Bitmap ,_orBitmapData:BitmapData,
									bgSp:*,_effectBmp:Bitmap ,_effectStr:String,
									_value:int=250,_isBlack:Boolean=false):void{
			var bitmapD:BitmapData ; 
			bitmapD = _orBitmapData.clone()
			var sx:Number = (500) / (_effectBmp.width) ;
			var sy:Number =(500)/ (_effectBmp.height) ; 
			trace("sy",sx, sy)
			if(_isBlack){
				_Matrix.SetSaturationMatrix(0);
				_Filter.matrix = _Matrix.GetFlatArray();
				_bgBitmap.filters = [_Filter];
			}else{
				_bgBitmap.filters = []
			}
//			trace(bgSp.x,bgSp.y,"bgSp");
//			var tx:int = bgSp.width/2 -250 ; 
//			var ty:int = bgSp.height/2 - 250
			bitmapD.draw(_effectBmp,
				new Matrix(bitmapD.width / _effectBmp.width,0,0,bitmapD.height / _effectBmp.height),
				new ColorTransform(1,1,1,0,0,0,0,_value)
				,_effectStr );
			_bgBitmap.bitmapData = bitmapD ; 
		}
	}
}class Lock{}