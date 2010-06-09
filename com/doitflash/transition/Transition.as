package com.doitflash.transition
{
	import com.doitflash.events.TransitionEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 4/20/2010 9:29 PM
	 */
	public class Transition extends EventDispatcher 
	{
		private var _target1:DisplayObject;
		private var _target2:DisplayObject;
		private var _duration:Number = 1;
		private var _effect:Object;
		private var _onCompleteFunc:Function;
		
		private var _parent:*;
		private var _index:int;
		
		private var _holder:Sprite;
		
		/**
		 * Constructor function....
		 */
		public function Transition($target1:DisplayObject, $target2:DisplayObject, $duration:Number, $effect:Object, $onCompleteFunc:Function=null):void
		{
			// save the parameters
			_target1 = $target1;
			_target2 = $target2;
			_duration = $duration;
			_onCompleteFunc = $onCompleteFunc;
			if (!$effect)
			{
				_effect = new Object();
				_effect.type = Effects;
			}
			else
			{
				_effect = $effect;
			}
			
			// save the parent and its index
			_parent = $target1.parent;
			_index = _parent.getChildIndex($target1);
			
			// start the transition
			doTrans();
		}
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// getter - setter

		

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Methods

		

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Protected Functions

		

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Private Functions

		private function doTrans():void
		{
			_holder = new Sprite();
			_holder.x = _target1.x;
			_holder.y = _target1.y;
			_parent.addChildAt(_holder, _index);
			
			// initialize the effect
			var fx:* = new _effect.type();
			
			// listen to the effect to see when it's completed
			fx.addEventListener(TransitionEvent.COMPLETE, onTransDone);
			
			// apply the effect properties
			applyProperties(fx, _effect);
			fx.duration = _duration;
			
			// create a bitmapData out of the first target
			var bmd1:BitmapData = new BitmapData(_target1.width, _target1.height, true, 0x00000000);
			bmd1.draw(_target1);
			var btm1:Bitmap = new Bitmap(bmd1, "auto", true);
			_holder.addChild(btm1);
			
			// create a bitmapData out of the second target
			var bmd2:BitmapData = new BitmapData(_target2.width, _target2.height, true, 0x00000000);
			bmd2.draw(_target2);
			var btm2:Bitmap = new Bitmap(bmd2, "auto", true);
			btm2.alpha = 0; // make sure the second target is always invisible
			_holder.addChildAt(btm2, 0);
			
			// send both bitmaps to the effect class
			fx.bitmaps(btm1, btm2);
			
			// run the effect
			fx.run();
			
			// remove _target1
			_parent.removeChild(_target1);
		}
		
		private function onTransDone(e:TransitionEvent):void
		{
			// remove the _holder sprite
			_parent.removeChild(_holder);
				
			// add the second target to the same index to complete the transition
			_parent.addChildAt(_target2, _index);
			_target2.x = _holder.x;
			_target2.y = _holder.y;
			
			// dispatch and let the document class know that the trans is done fully
			this.dispatchEvent(new TransitionEvent(TransitionEvent.COMPLETE));
			if (_onCompleteFunc != null) _onCompleteFunc();
		}
		
		private function applyProperties($effect:Object, $properties:Object):void
		{
			for (var param:* in $properties)
			{
				if (param != "type")
				{
					try
					{
						$effect[param] = $properties[param];
					}
					catch (err:Error)
					{
						trace("There is no property named >>", param, "in: " + $properties.type)
					}
				}
			}
		}
	}
	
}