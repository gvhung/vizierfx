/**
 * Copyright 2008, President and Fellows of Harvard College
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *  o Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *  o Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *  o Neither the name of the <ORGANIZATION> nor the names of its contributors may
 *    be used to endorse or promote products derived from this software without specific prior written permission.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

package com.vizierfx.nodeshapes
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import com.vizierfx.VizierNode;

	public class Parallelogram extends AbstractNodeShape
	{
		public function Parallelogram(node:VizierNode)
		{
			super(node);
		}
		
		protected override function _drawGeometry(graphics:Graphics, rc:Rectangle):void {
			var max_x:Number = rc.x + rc.width;
		 	var max_y:Number = rc.y + rc.height;
		 	
		 	var x_1:Number = rc.x + (.5 * rc.height);
		 	var x_2:Number = max_x - (.5 * rc.height);
		 	
			graphics.moveTo(x_1, max_y);
			graphics.lineTo(max_x, max_y);
			graphics.lineTo(x_2, rc.y);
			graphics.lineTo(rc.x, rc.y);
			graphics.lineTo(x_1, max_y);
		}
		
		protected override function _getNextRectangle(rc:Rectangle, periphery_gap:int):Rectangle {
			rc.x += periphery_gap * 1.7;
			rc.y += periphery_gap;
			rc.width -= (periphery_gap * 3.4);
			rc.height -= (periphery_gap * 2);
			
			return rc;
		}			
	}
}