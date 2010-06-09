package org.gif.events
{

	import flash.events.ProgressEvent;

	public class GifProgressEvent extends ProgressEvent
	{

		public static const PROGRESS:String = "progress";

		public function GifProgressEvent(pType:String,bL:uint,bT:uint)
		{

			super(pType,false,false,bL,bT);

		}

	}

}