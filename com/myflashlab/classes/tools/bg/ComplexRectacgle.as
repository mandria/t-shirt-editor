/*
import com.myflashlab.classes.tools.bg.ComplexRectacgle;
import flash.display.Sprite;
var menuBg:Sprite = new ComplexRectacgle(myMenu.width, myMenu.height, 15, 15, 15, 15, 0x888888, 0xCCCCCC, 5, 0x999999);
*/

package com.myflashlab.classes.tools.bg
{
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	
	public class ComplexRectacgle extends Sprite
	{
		protected var _theBgMask:Sprite = new Sprite();
		protected var gMatrix:Matrix = new Matrix();
		
		public function ComplexRectacgle(w:Number, h:Number, tl:Number, tr:Number, bl:Number, br:Number, colorA:uint, colorB:uint, sT:Number, sC:uint, $alphaA:Number=1, $alphaB:Number=1)
		{
			gMatrix.createGradientBox(w, h, 55, 0, 0);
			
			_theBgMask.graphics.beginGradientFill(GradientType.LINEAR, [colorA, colorB], [$alphaA, $alphaB], [0,255], gMatrix, SpreadMethod.PAD);
			if(sT != 0){
				_theBgMask.graphics.lineStyle(sT, sC, 1, true, "normal", CapsStyle.ROUND, JointStyle.ROUND, 3);
			}
			_theBgMask.graphics.drawRoundRectComplex(0, 0, w, h, tl, tr, bl, br);
			_theBgMask.graphics.endFill();
			
			addChild(_theBgMask);
		}
	}
}