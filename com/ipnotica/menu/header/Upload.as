﻿// The button is based on this class// http://www.myflashlab.com/2010/04/28/dropdownmenu-class/package com.ipnotica.menu.header {		import ascb.util.Tween;		import com.greensock.TweenLite;	import com.ipnotica.utils.Config;	import com.ipnotica.utils.Utils;		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.IOErrorEvent;	import flash.events.MouseEvent;	import flash.net.URLLoader;	import flash.net.URLRequest;
	public class Upload extends MovieClip {				public var numberOfCategories:Number = -1;				public function Upload() {			super();			init();		}				private function init():void {			this.buttonMode = true;			TweenLite.delayedCall(0.1, initCategoriesXML);			initEvents();		}				private function initEvents():void {			addEventListener(MouseEvent.CLICK, onClickUpload);		}				/** Load list of possible categories. This is needed to have the number of categories */		public function initCategoriesXML():void {			var path:String = Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + Config.flashvars.categories;			var url:URLRequest = new URLRequest(path); 			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, onCategoriesLoaded);			loader.addEventListener(IOErrorEvent.IO_ERROR, Utils.onIOError);		}				/** If any, load the existing product we want to show */		private function onCategoriesLoaded(e:Event):void {			numberOfCategories = new XML(e.target.data).children().length() - 1;		}				private function onClickUpload(e:MouseEvent):void {			Config.body.menu.header.combo.pick(numberOfCategories)			// at this point the system raise the event and start to load		}			}}