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

package src.vizier.nodeshapes
{
	import com.degrafa.geometry.Ellipse;
	
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import src.vizier.VizierNode;

	public class NodeEllipse extends AbstractNodeShape
	{
		public function NodeEllipse(node:VizierNode)
		{
			super(node);
		}
		
		override protected function _drawGeometry(graphics:Graphics, rc:Rectangle):void {
			graphics.moveTo(rc.x + rc.width / 2, rc.y + rc.height / 2);
			graphics.drawEllipse(rc.x, rc.y, rc.width, rc.height);
		}
		
		protected override function _getNextRectangle(rc:Rectangle, periphery_gap:int):Rectangle {
			rc.x += periphery_gap;
			rc.y += periphery_gap;
			rc.width -= (periphery_gap * 2);
			rc.height -= (periphery_gap * 2);
			
			return rc;
		}		
	}
}