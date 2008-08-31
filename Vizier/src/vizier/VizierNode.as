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
	public class VizierNode
	{
		private var _id:String;
		private var _width:Number;
		private var _height:Number;
		private var _x:int;
		private var _y:int;
		private var _label:String;
		private var _color:String;
		private var _fillcolor:String;
		private var _shape:String;
		private var _selected:Boolean;
		private var _peripheries:int;
		private var _fontname:String;
		private var _fontsize:int;
		private var _fontcolor:String;
		
		private static var _properties:Array = [
			'pos',
			'width',
			'height',
			'label',
			'color',
			'fillcolor',
			'fontcolor',
			'shape',
			'peripheries',
			'fontsize',
			'fontname'
		];
		
		private static var _shapes:Array = ['box', 'polygon', 'ellipse', 'point', 'egg', 'triangle', 'diamond', 'trapezium', 'parallelogram', 'hexagon', 'octagon', 'doublecircle', 'tripleoctagon', 'invtriangle', 'invtrapezium'];
		
		public function VizierNode(id:String, properties:Object, default_props:Object)
		{
			this._id = this._label = id; // default label to ID
			
			for each (var value:String in VizierNode._properties) {
				if (properties[value] != null)
					this[value] = properties[value];
				else
					this[value] = default_props[value];
			}
			
			this._convertUnits();
		}

		[Bindable]
		public function set width(value:Number):void { this._width = value; }
		public function get width():Number { return this._width; }
		
		[Bindable]
		public function set height(value:Number):void { this._height = value; }
		public function get height():Number { return this._height; }
		
		public function set pos(value:String):void {
			var coords:Array = value.split(',');
			this._x = coords[0];
			this._y = coords[1];
		}
		
		[Bindable]
		public function set x(value:int):void { this._x = value; }
		public function get x():int { return this._x; }
		
		[Bindable]
		public function set y(value:int):void { this._y = value; }
		public function get y():int { return this._y; }
		
		public function set id(value:String):void { this._id = value; }
		public function get id():String { return this._id; }
		
		[Bindable]
		public function set label(value:String):void { if (value != null) this._label = value.replace(/\\n/g, ' '); }
		public function get label():String { return this._label; }
		
		public function set color(value:String):void { this._color = VizierColorList.translateColorName(value); }
		public function get color():String { return this._color; }
		
		public function set fillcolor(value:String):void { this._fillcolor = VizierColorList.translateColorName(value); }
		public function get fillcolor():String { return this._fillcolor; }		

		public function set shape(value:String):void {
			this._shape = value;
			if (this._shape == 'doublecircle' || this._shape == 'doubleoctagon')
				this._peripheries = 2;
			else if (this._shape == 'tripleoctagon')
				this._peripheries = 3;
		}
		public function get shape():String { return this._shape; }	
		
		public function set selected(value:Boolean):void { this._selected = value; }
		public function get selected():Boolean { return this._selected; }
		
		public function set peripheries(value:int):void { this._peripheries = value; }
		public function get peripheries():int { return this._peripheries; }
		
		[Bindable]
		public function set fontname(value:String):void { this._fontname = value; }
		public function get fontname():String { return this._fontname; }
		
		[Bindable]
		public function set fontcolor(value:String):void { this._fontcolor = VizierColorList.translateColorName(value); }
		public function get fontcolor():String { return this._fontcolor; }
		
		[Bindable]
		public function set fontsize(value:int):void { this._fontsize = value; }
		public function get fontsize():int { return this._fontsize; }
		
		private function _convertUnits():void {
			this._width *= 72; // convert from inches to points
	    	this._height *= 72;
	    	
	    	// translate the ellipse over correctly, graphviz's coordinates mark the center of the ellipse
	    	this._x -= (this._width / 2);
	    	this._y -= (this._height / 2);
		}
		
		public static function getDefaultProperties():Object {
			var properties:Object = new Object();
			properties["fillcolor"] = '#d3d3d3';
			properties["color"] = '#000000';
			properties["shape"] = 'ellipse';
			properties["peripheries"] = 1;
			properties["fontname"] = 'Times New Roman';
			properties["fontsize"] = '14';
			properties["fontcolor"] = '#000000';
			return properties;
		}
	}
}