﻿/** * TShirt conatiner.  * Here are placed all shirts and all items used to personalize it  *  **/package com.ipnotica.content {			import com.ipnotica.content.blackboard.Blackboard;
	import com.ipnotica.utils.Utils;
	
	import flash.display.MovieClip;	public class Content extends MovieClip {				public var blackboard:Blackboard;				public function Content() {			super();			init();		}				private function init():void {			Utils.setConfig(this);		}			}}