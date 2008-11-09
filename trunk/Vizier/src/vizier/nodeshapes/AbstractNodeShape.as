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
	import com.degrafa.IGeometry;
	import com.degrafa.core.IGraphicsFill;
	import com.degrafa.geometry.Geometry;
	import com.degrafa.paint.SolidFill;
	
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import src.vizier.VizierNode;
	
	public class AbstractNodeShape extends Geometry implements IGeometry
	{
		private static const PERIPHERY_GAP:int = 3;
		
		private var _node:VizierNode;
		public function get node():VizierNode { return this._node; }

		public function AbstractNodeShape(node:VizierNode)
		{
			this._node = node;
		}
		
		public override function draw(graphics:Graphics, rc:Rectangle):void {
			var fill:IGraphicsFill = this.fill;
			var empty_fill:SolidFill = new SolidFill;
			empty_fill.alpha = 0;
			
			if (rc == null) {
				rc = new Rectangle(0, 0, _node.width, _node.height);
			}
			
			preDraw();
			
			for (var i:int = 0; i < this._node.peripheries; i++) {
				// only the innermost node gets filled in
				if (i == this._node.peripheries - 1)
					this.fill = fill;
				else {
					this.fill = empty_fill;
				}
				
				//apply the fill retangle for the draw
				super.draw(graphics,rc);
				
				this._drawGeometry(graphics, rc);
				
				// resize the rectangle for the next periphery
				rc = this._getNextRectangle(rc, PERIPHERY_GAP);

			}
			super.endDraw(graphics);
		}
		
		// This is an abstract method, only ActionScript is too stupid to support the "abstract" keyword.
		protected function _drawGeometry(graphics:Graphics, rc:Rectangle):void {
			throw new Error("This is an abstract method.  Please define it in your subclass.");
		}
		
		protected function _getNextRectangle(rc:Rectangle, periphery_gap:int):Rectangle {				
			var new_height:Number = rc.height - (PERIPHERY_GAP * 2);
			var ratio:Number = new_height / rc.height;
			var new_width:Number = rc.width * ratio;
			
			rc.x += (rc.width - new_width) / 2;
			rc.y += (rc.height - new_height) / 2;
			rc.width = new_width;
			rc.height = new_height;
			
			return rc;
		}
	}
}