package com.ipnotica.utils {
	import com.ipnotica.Body;
	
	import flash.display.MovieClip;
	
	
	public class Utils {
		
		public function Utils() { }
		
		
		/**
		 * Makes Config.body available to all instances.
		 *  
		 * @description This is necessary because flash access to 
		 * some MovieClips (like menu) before the Main can have been 
		 * initialized. So in the menu we need to call this function
		 * to be able to navigate everywhere.
		 * 
		 * @implementation The object passed as Param is iterated
		 * on its parent until the Body object is found out.
		 **/ 
		 
		public static function setConfig(obj:MovieClip):void {
			while (!(obj is Body)) { obj = MovieClip(obj.parent); }
			Config.body = Body(obj);
		}

	}
}