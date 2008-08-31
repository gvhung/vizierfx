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

package vizier
{
	import flash.geom.Point;
	
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