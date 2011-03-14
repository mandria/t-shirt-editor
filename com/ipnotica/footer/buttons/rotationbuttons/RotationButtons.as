﻿package com.ipnotica.footer.buttons.rotationbuttons {		import com.ipnotica.utils.Config;	import com.ipnotica.utils.Utils;		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;	public class RotationButtons extends MovieClip {				public var left:MovieClip;		public var right:MovieClip;				private var rotateRight:Boolean = false;		private var rotateLeft:Boolean = false;				public function RotationButtons() {			super();			buttonMode = true;			init();		}				private function init():void {			initEvents();		}				private function initEvents():void {			left.addEventListener(MouseEvent.MOUSE_DOWN,  function():void  { rotateLeft  = true;  });			left.addEventListener(MouseEvent.MOUSE_UP,    function():void  { rotateLeft  = false; });			right.addEventListener(MouseEvent.MOUSE_DOWN, function():void  { rotateRight = true;  });			right.addEventListener(MouseEvent.MOUSE_UP,   function():void  { rotateRight = false; });			addEventListener(Event.ENTER_FRAME, rotateItem);			left.addEventListener(MouseEvent.MOUSE_OVER, onMouseRleft);			right.addEventListener(MouseEvent.MOUSE_OVER, onMouseRright);		}				private function onMouseRleft(e:Event):void {				Utils.setTT(this, "Ruota", "clicca questo pulsante per ruotare l'immagine verso sinistra");		}				private function onMouseRright(e:Event):void {				Utils.setTT(this, "Ruota", "clicca questo pulsante per ruotare l'immagine verso destra");		}						// TODO: Here the rotation can not be on the item, otherwise it has some strange effects. 		// For this reason we act directly on the content, also if this create some problems.		private function rotateItem(e:Event):void {			if (Config.currentItem.myResizableMovieClip) {				if (rotateRight) { Config.currentItem.myResizableMovieClip.RotateDX(); Utils.initXMLClips(); }				if (rotateLeft)  { Config.currentItem.myResizableMovieClip.RotateSX(); Utils.initXMLClips(); }			}		}			}}