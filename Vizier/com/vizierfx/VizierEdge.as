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

package com.vizierfx
{
	import com.degrafa.core.IGraphicsStroke;
	import com.degrafa.geometry.CubicBezier;
	import com.degrafa.paint.SolidStroke;
	
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import mx.controls.Text;
	import mx.styles.StyleManager;
	
	public class VizierEdge
	{
		private var _start_id:String;
		private var _end_id:String;
		
		private var _start_point:Point;
		private var _end_point:Point;
		private var _points:Array;
		
		private var _color:String;
		private var _style:String;
		
		private var _arrowhead:String;
		private var _arrowtail:String;
		
		private var _label:String;
		private var _label_point:Point;
		
		private var _fontcolor:String;
		private var _fontsize:int;
		private var _fontname:String;
		
		private var _weight:Number;
		
		private static var _properties:Array = ['pos', 'color', 'style', 'arrowhead', 'arrowtail', 'label', 'lp', 'fontcolor', 'fontsize', 'fontname', 'weight'];
				
		// the allowed types of arrowheads
		private static var _arrowtypes:Array = ['normal', 'dot', 'odot', 'inv', 'invdot', 'invodot', 'none'];

		private const ARROWHEAD_WIDTH:int = 3;
		
		public function VizierEdge(start_id:String, end_id:String, properties:Object, default_props:Object)
		{
			this._start_id = start_id;
			this._end_id = end_id;
			
			for each (var value:String in VizierEdge._properties) {
				if (properties[value] != null)
					this[value] = properties[value];
				else
					this[value] = default_props[value];
			}
		}
		
		public function set pos(value:String):void {
			var split_result:Array = value.split(' ');
			
			this._points = new Array();
			for each (var split_string:String in split_result) {
				var coords:Array = split_string.split(',');
				
				if (coords[0] == 's') {
					this._start_point = new Point(coords[1], coords[2]);
				}
				else if (coords[0] == 'e') {
					this._end_point = new Point(coords[1], coords[2]);
				}
				else {
					this.addPoint(new Point(coords[0], coords[1]));
				}
			}
		}
		
		public function set lp(value:String):void {
			if (value == null) return;
			var label_pieces:Array = value.split(',');
			_label_point = new Point(label_pieces[0], label_pieces[1]);
		}

		public function get start_point():Point { return this._start_point; }
		public function get end_point():Point { return this._end_point; }
		public function get points():Array { return this._points; }
		public function get color():String { return this._color; }
		public function get style():String { return this._style; }
		public function get arrowhead():String { return this._arrowhead; }
		public function get arrowtail():String { return this._arrowtail; }
		public function get label():String { return this._label; }
		public function get label_point():Point { return this._label_point; }
		public function get fontsize():int { return this._fontsize; }
		public function get fontname():String { return this._fontname; }
		public function get fontcolor():String { return this._fontcolor; }
		public function get weight():Number { return this._weight; }
		
		public function set start_point(value:Point):void { this._start_point = value; }
		public function set end_point(value:Point):void { this._end_point = value; }
		public function set points(value:Array):void { this._points = value; }
		public function set color(value:String):void { this._color = VizierColorList.translateColorName(value); }
		public function set style(value:String):void { this._style = value; }
		public function set label(value:String):void { this._label = value; }
		public function set label_point(value:Point):void { this._label_point = value; }
		public function set fontsize(value:int):void { this._fontsize = value; }
		public function set fontname(value:String):void { this._fontname = value; }
		public function set fontcolor(value:String):void { this._fontcolor = VizierColorList.translateColorName(value); }
		public function set weight(value:Number):void { this._weight = value; }
		public function set arrowhead(value:String):void {
			for each (var style:String in VizierEdge._arrowtypes) {
				if (style == value)
					this._arrowhead = value;
			}
		}
		public function set arrowtail(value:String):void {
			for each (var style:String in VizierEdge._arrowtypes) {
				if (style == value)
					this._arrowtail = value;
			}
		}
		public function addPoint(value:Point): void { this._points.push(value); }
		
		public function draw(canvas:VizierCanvas):void {
			if (this.style == 'invis') return;
	    	
	    	var graphics:Graphics = canvas.graphics;
	    	var points:Array = this.points;
	    	
	    	var stroke:SolidStroke = new SolidStroke();
	    	stroke.color = this.color;
	    	stroke.weight = this.weight;
    		
    		if (this.start_point != null) {
    			_drawArrowhead(graphics, points[0], this.start_point, this.arrowtail, this.color);
    		}
    		
    		while (points.length > 1) {
    			_drawBezier(graphics, points[0], points[1], points[2], points[3], stroke);
    			for (var i:int = 0; i < 3; i++) { points.shift(); }
    		}
    		
    		if (this.end_point !== null) {
    			_drawArrowhead(graphics, points[0], this.end_point, this.arrowhead, this.color);
    		}
    		
    		if (this.label != null && this.label_point != null) {
    			var label:Text = new Text();
    			label.text = this.label;
    			label.setStyle('fontSize', this.fontsize);
    			label.setStyle('fontFamily', this.fontname);
    			label.setStyle('color', this.fontcolor);
    			
    			// account for the fact that the x and y coordinates correspond to the center of the label
    			label.x = this.label_point.x;
    			label.y = this.label_point.y;    			
    			canvas.addChildAt(label, 0);
    			
    			// must call validateNow after adding the label to the canvas, since that's when the text size is calculated
    			label.validateNow();			
    			label.x = this.label_point.x - (label.textWidth / 2);
    			label.y = this.label_point.y - (label.textHeight / 2);
    		}
		}
		
		/**
	    * Draws an arrowhead on the canvas, going from p0 to p1
	    */
	    private function _drawArrowhead(graphics:Graphics, p0:Point, p1:Point, style:String, color:String):void {
	    	var x0:Number = p0.x, y0:Number = p0.y, x1:Number = p1.x, y1:Number = p1.y;
	    	
	    	if (style == 'normal' || style == 'inv') {
		    	var flat_x:Number, flat_y:Number, point_x:Number, point_y:Number;
		    	if (style == 'normal') {
		    		flat_x = x0; flat_y = y0; point_x = x1; point_y = y1;
		    	}
		    	else {
		    		flat_x = x1; flat_y = y1; point_x = x0; point_y = y0;
		    	}
		    	
		    	this._drawArrowheadNormal(graphics, flat_x, flat_y, point_x, point_y, color);
	    	}
	    	else if (style == 'dot' || style == 'odot') {
	    		var isFilled:Boolean = (style == 'dot') ? true : false;
	    		this._drawArrowheadDot(graphics, x0, y0, x1, y1, color, isFilled);
	    	}
	    	else if (style == 'invdot' || style == 'invodot') {
	    		// start by breaking the "arrowhead" segment in half
	    		// the first half (x0 to x_split) is the dot, the second (x_split to x1) is the inverted arrow
	    		var x_split:Number = (x0 + x1) / 2, y_split:Number = (y0 + y1) / 2;
	    		
	    		this._drawArrowheadNormal(graphics, x1, y1, x_split, y_split, color);
				
				var dotIsFilled:Boolean = (style == 'invdot') ? true : false;
				this._drawArrowheadDot(graphics, x0, y0, x_split, y_split, color, dotIsFilled);
	    	}
	    } 
	    
	    private function _drawArrowheadNormal(graphics:Graphics, x0:Number, y0:Number, x1:Number, y1:Number, color:String):void {
	    	var x2:Number, y2:Number, x3:Number, y3:Number;
	    		    	
	    	var color_number:Number = StyleManager.getColorName(color);
		    	
	    	// calculate the positions of points 2 and 3 on the arrow
	    	// draw a line from point 0 perpendicular to the line between 0 and 1
	    	// start by reducing the line from 0 to 1 to a unit length
	    	var line_length:Number = Math.sqrt(Math.pow(x1 - x0, 2) + Math.pow(y1 - y0, 2));
	    	var x_delta:Number = (x1 - x0) / line_length;
	    	var y_delta:Number = (y1 - y0) / line_length;
	    	
	    	// now make a perpendicular line by swapping x_delta and y_delta
	    	x2 = x0 + (ARROWHEAD_WIDTH * y_delta);
	    	y2 = y0 - (ARROWHEAD_WIDTH * x_delta);
	    	x3 = x0 - (ARROWHEAD_WIDTH * y_delta);
	    	y3 = y0 + (ARROWHEAD_WIDTH * x_delta);
	    	
	    	graphics.lineStyle(.5, color_number);
	    	
	    	graphics.moveTo(x1,y1);
	    	graphics.beginFill(color_number);
	    	graphics.lineTo(x2,y2);
	    	graphics.lineTo(x3,y3);
	    	graphics.lineTo(x1,y1);
	    	graphics.endFill();
	    }
	    
	    private function _drawArrowheadDot(graphics:Graphics, x0:Number, y0:Number, x1:Number, y1:Number, color:String, filled:Boolean):void {
    		var r:Number, xc:Number, yc:Number;
    		xc = (x0 + x1) / 2;
    		yc = (y0 + y1) / 2;
    		r = Math.sqrt(Math.pow(x1 - xc, 2) + Math.pow(y1 - yc, 2));
    		  		
    		var color_number:Number = StyleManager.getColorName(color);
    		
    		graphics.moveTo(xc, yc); // this is needed to avoid fill errors
    		graphics.lineStyle(.5, color_number);
    		
    		if (filled)
    			graphics.beginFill(color_number);
    		
    		graphics.drawCircle(xc, yc, r);
    		
    		if (filled)
    			graphics.endFill();
	    }
		
		private function _drawBezier(graphics:Graphics, p0:Point, p1:Point, p2:Point, p3:Point, stroke:IGraphicsStroke):void {
			// jitter the control points slightly because perfect straight lines cause display errors
			p1.x += .0000001;
			p1.y += .0000001;
			p2.x -= .0000001;
			p2.y += .0000001;
			var curve:CubicBezier = new CubicBezier(p0.x, p0.y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
	    	curve.stroke = stroke;
	    	curve.draw(graphics, null);
	    	curve.endDraw(graphics);
	    }		
		
		public static function getDefaultProperties():Object {
			var props:Object = new Object();
			props.color = '#000000';
			props.style = 'solid';
			props.arrowhead = 'normal';
			props.arrowtail = 'normal';
			props.fontcolor = '#000000';
			props.fontname = 'Times New Roman';
			props.fontsize = 14;
			props.labelfontcolor = '#000000';
			props.labelfontname = 'Times New Roman';
			props.labelsize = 14;
			props.weight = 1;
			return props;
		}
	}
}