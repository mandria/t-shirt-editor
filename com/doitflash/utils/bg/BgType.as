package com.doitflash.utils.bg
{
	
	/**
	 * BgType class contains different types of backgrounds
	 * @author Hadi Tavakoli
	 */
	public class BgType 
	{
		/**
		 * simple one color background.
		 */
		public static const SIMPLE_COLOR:String = "simpleColorBg";
		
		/**
		 * Image background. supports file types PNG, JPG and GIF (static or animated). 
		 */
		public static const IMAGE:String = "imageBg";
		
		/**
		 * Vista like Aero glassy effect background. This background cannot be applied to the main stage of your project.
		 * The main reason of using this bg effect is when you have something on the stage so if this is placed on the stage itself, won't work of course.
		 */
		public static const GLASSY:String = "glassyBg";
	}
	
}