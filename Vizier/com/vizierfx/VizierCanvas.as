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
	import com.degrafa.core.IGraphicsFill;
	import com.degrafa.core.IGraphicsStroke;
	import com.degrafa.paint.SolidFill;
	import com.degrafa.paint.SolidStroke;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import mx.containers.Canvas;
	import mx.controls.Button;
	import mx.controls.Text;
	import mx.effects.Fade;
	import mx.effects.Move;
	import mx.effects.easing.Quadratic;
	import mx.events.TweenEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.styles.StyleManager;
	
	[Event(name="nodeSelected", type="vizier.VizierEvent")]
	[Event(name="serviceSent", type="vizier.VizierEvent")]
	[Event(name="serviceReceived", type="vizier.VizierEvent")]
	[Event(name="redrawn", type="vizier.VizierEvent")]
	[Event(name="serviceFail", type="vizier.VizierEvent")]
	public class VizierCanvas extends Canvas
	{
		private var _service:HTTPService;
		private var _selected_id:String;
		private var _mouseover_id:String;
		
		private var _id_field:String;
		private var _default_params:Object;
		private var _graph:VizierGraph;
		private var _expand_button:Button;
		
		private var _expand_visible_flag:Boolean;
		
		private var _force_redraw:Boolean;
		
		private const ANIMATION_LENGTH:Number = 1500;
		
		private var _selectstroke:IGraphicsStroke;
		private var _highlightstroke:IGraphicsStroke;
		private var _selectfill:IGraphicsFill;
		private var _highlightfill:IGraphicsFill;
		
		private var _invert:Boolean;
		
		function VizierCanvas() {
			super();
			this.clipContent = false;
			this._expand_visible_flag = true;
		}
		
		public function get service():HTTPService {
			return this._service;
		}
		public function set service(value:HTTPService):void {
			this._service = value;
		}
		public function set idField(value:String):void {
			this._id_field = value;
		}
		public function get idField():String {
			return this._id_field;
		}
		public function set defaultParams(value:Object):void {
			this._default_params = value;
		}
		public function get defaultParams():Object {
			return this._default_params;
		}
		public function get expandButton():Button {
			return this._expand_button;
		}
		
		public function set invert(value:Boolean):void {
			this._invert = value;
		}
		
		[Inspectable]
		[Bindable]
		public function set expandButton(value:Button):void {
			if (this._expand_button != null)
				this.removeChild(_expand_button);
			
			value.visible = false;
			this._expand_button = value;		
			_expand_button.addEventListener(MouseEvent.MOUSE_OVER, _keepVisible);	
			_expand_button.addEventListener(MouseEvent.CLICK, _clickExpandButton);
			_expand_button.addEventListener(MouseEvent.MOUSE_OUT, _hideExpandButton);
			this.addChild(value);
		}
		
		public function set highlightstrokecolor(value:String):void {
			var stroke:SolidStroke = new SolidStroke();
			stroke.color = StyleManager.getColorName(value);
			stroke.weight = 1;
			_highlightstroke = stroke;
		}
		public function set selectstrokecolor(value:String):void {
			var stroke:SolidStroke = new SolidStroke();
			stroke.color = StyleManager.getColorName(value);
			stroke.weight = 1;
			_selectstroke = stroke;
		}
		public function set highlightstroke(value:IGraphicsStroke):void { this._highlightstroke = value; }
		public function set selectstroke(value:IGraphicsStroke):void { this._selectstroke = value; }
		
		public function set highlightfillcolor(value:String):void {
			var fill:SolidFill = new SolidFill();
			fill.color = StyleManager.getColorName(value);
			_highlightfill = fill;
		}
		public function set selectfillcolor(value:String):void {
			var fill:SolidFill = new SolidFill();
			fill.color = StyleManager.getColorName(value);
			_selectfill = fill;
		}
		public function set highlightfill(value:IGraphicsFill):void { this._highlightfill = value; }
		public function set selectfill(value:IGraphicsFill):void { this._selectfill = value; }		
		
		private function _keepVisible(event:MouseEvent):void {
			event.target.visible = true;
		}
	    
	    // creates an interactive node on the canvas
	    public function drawNode(node:VizierNode):void {
	    	var existing_child:DisplayObject = this.getChildByName(node.id);
	    	if (existing_child != null) {
	    		this.removeChild(existing_child);
	    	}
	    	
	    	var graphnode:VizierNodeComponent = new VizierNodeComponent();
	    	graphnode.data = node;
	    	graphnode.id = node.id;
	    	graphnode.name = node.id;
	    	graphnode.selected = node.selected;
	    	graphnode.selectfill = this._selectfill;
	    	graphnode.selectstroke = this._selectstroke;
	    	graphnode.highlightfill = this._highlightfill;
	    	graphnode.highlightstroke = this._highlightstroke;
	    	
	    	if (this._service != null)
	    		graphnode.addEventListener(MouseEvent.DOUBLE_CLICK, _doubleClickHandler);
	    		
	    	graphnode.addEventListener(MouseEvent.CLICK, _clickHandler);
	    		    	
	    	if (this._expand_button != null) {
	    		graphnode.addEventListener(MouseEvent.MOUSE_OVER, _moveExpandButton);
	    		graphnode.addEventListener(MouseEvent.MOUSE_OUT, _hideExpandButton);
	    	}
	    		
	        this.addChildAt(graphnode, 0);
	    }
	    
	   	private function _clickHandler(event:MouseEvent):void {
	    	var viz_event:VizierEvent = new VizierEvent(VizierEvent.NODE_SELECTED);
	    	viz_event.node = event.target as VizierNodeComponent;
	    	this.dispatchEvent(viz_event);
	    }		
	    
	    public function drawEdge(edge:VizierEdge):void {
	    	edge.draw(this);	
	    }
	        
	    public function redrawGraph(input:String):void {
	  		this._expand_visible_flag = false;
	  		
	  		if (this._expand_button != null) {
	  			this._expand_button.visible = false;
  	    		// set the position to (0,0) to set the size of the scrollbars appropriately
	    		this._expand_button.x = 0;
	    		this._expand_button.y = 0;
	    	}
	  		
	    	var graph:VizierGraph = VizierParser.parseFromGraphviz(input, _selected_id);
	    	
	    	this.width = graph.width;
	    	this.height = graph.height;
	    	
	    	var nodes:Array = graph.nodes;
	    	
			// Animate the transition between graphs
			// first, note all the nodes in the old graph so we know which ones to fade out
			var nodes_to_remove:Object = new Object;
			for each (var child:Object in this.getChildren()) {
				if (!(child is VizierNodeComponent))
					continue;
				nodes_to_remove[child.id] = child;
			}
			
			// check to see if the two graphs are the same
			// if they are, leave the animation alone
			var different_flag:Boolean = false;
			var node_differences:Object = new Object;
			for each (var node1:VizierNode in nodes) {
				if (node_differences[node1.id] == null)
					node_differences[node1.id] = 0;
				
				node_differences[node1.id]++;
			}
			
			for each (var node2:VizierNodeComponent in nodes_to_remove) {
				if (node_differences[node2.id] == null)
					node_differences[node2.id] = 0;				
				
				node_differences[node2.data.id]++;
			}
			
			for each (var diffcount:int in node_differences) {
				if (diffcount != 2 && diffcount != 0) {
					different_flag = true;
					break;
				}
			}
			if (!different_flag && !this._force_redraw) {
				this._expand_visible_flag = true;
				return;
			}
			
			for each (var child2:Object in this.getChildren()) {
				if (child2 is Text) {
					var edge_label:Text = child2 as Text;
					removeChild(edge_label);
				}
			}
			
			// redraw the edges after the animation is completed		
	    	this.graphics.clear();
	    	flash.utils.setTimeout(_finishGraph, ANIMATION_LENGTH, graph.edges);
	    	
	    	// iterate through the nodes in the new graph
	    	// if they're already in the graph, move them to the new location
	    	// if not, fade them in
	    	for each (var node:VizierNode in nodes) {	    		
	    		var old_node:VizierNodeComponent = this.getChildByName(node.id.toString()) as VizierNodeComponent;
	    		if (old_node != null) {
	    			// node was found in the current graph - move it and take it out of the list of nodes to fade out
	    			var move_effect:Move = new Move(old_node);
	    			move_effect.xTo = node.x;
	    			move_effect.yTo = node.y;
	    			move_effect.easingFunction = Quadratic.easeInOut;
	    			move_effect.duration = ANIMATION_LENGTH;
	    			move_effect.play();
	    			nodes_to_remove[node.id] = null;
	    		}
	    		else {
	    			// node was not found in the current graph - create it and fade it in	
	    			drawNode(node);
	    			var new_node:VizierNodeComponent = this.getChildByName(node.id.toString()) as VizierNodeComponent;
	    			var fadein_effect:Fade = new Fade(new_node);
	    			fadein_effect.alphaFrom = 0;
	    			fadein_effect.alphaTo = 1;
	    			fadein_effect.duration = ANIMATION_LENGTH;
	    			fadein_effect.play();
	    		}
	    	}
	    	
	    	for each (var removed_node:VizierNodeComponent in nodes_to_remove) {
	    		// fade out nodes to be removed, then delete them once the animation is over
	    		if (removed_node == null) continue;
	    		var fadeout_effect:Fade = new Fade(removed_node);
	    		fadeout_effect.alphaFrom = 1;
	    		fadeout_effect.alphaTo = 0;
	    		fadeout_effect.duration = ANIMATION_LENGTH;
	    		fadeout_effect.addEventListener(TweenEvent.TWEEN_END, _deleteNode);
	    		fadeout_effect.play();
	    	}
	    	
	    	this._graph = graph; 	
	    }
	    
	    private function _finishGraph(edges:Array):void {	    	
	    	for each (var edge:VizierEdge in edges) {
	    		drawEdge(edge);
	    	}
	    	
	    	this._expand_visible_flag = true;
	    }
	    
	    private function _doubleClickHandler(event:MouseEvent):void {
	    	var node:VizierNodeComponent = event.target as VizierNodeComponent;
	    	this.sendService(node.id);
	    }
	    
	    public function sendService(node_id:String, force_redraw:Boolean = false):void {
	    	var sent_event:VizierEvent = new VizierEvent(VizierEvent.GRAPH_SERVICE_SENT);
	    	sent_event.id = node_id;
	    	
	    	this._force_redraw = force_redraw;
	    	
	    	this.dispatchEvent(sent_event);
	    	
	    	var params:Object;
	    	
	    	if (_default_params)
	    		params = _default_params;

			if (this._id_field != null)
				params[this._id_field] = node_id;
	    	
	    	this._service.addEventListener(FaultEvent.FAULT, _failService);
	    	this._service.addEventListener(ResultEvent.RESULT, _receiveService);
	    	this._service.send(params);
	    	
	    	this._selected_id = node_id;
	    }
	    
	    private function _receiveService(event:ResultEvent):void {
	    	this.dispatchEvent(new VizierEvent(VizierEvent.GRAPH_SERVICE_RECEIVED)); 
	    	this.redrawGraph(event.result.toString());
	    }
	    
	    private function _failService(event:FaultEvent):void {
			this.dispatchEvent(new VizierEvent(VizierEvent.GRAPH_SERVICE_FAIL));
	    }
	    
	    private function _deleteNode(event:TweenEvent):void {
	    	var fadeout_effect:Fade = event.target as Fade;
	    	var node:VizierNodeComponent = fadeout_effect.target as VizierNodeComponent;
	    	node.parent.removeChild(node);
	    }
	    
	    public function getNode(id:String):VizierNode {
	    	for each (var node:VizierNode in _graph.nodes) {
	    		if (node.id == id) {
	    			return node;
	    		}
	    	}
	    	
	    	return null;
	    }
	    
	    private function _moveExpandButton(event:MouseEvent):void {
	    	if (this._expand_visible_flag == false) return; // ignore mouseovers if we're redrawing the graph
	    	
	    	var component:VizierNodeComponent = event.target as VizierNodeComponent;
	    	this._expand_button.x = component.x + component.width - _expand_button.width + this.x;
	    	this._expand_button.y = component.y + this.y;
	    	_mouseover_id = component.data.id;
	    	
	    	this._expand_button.visible = true;
	    }
	    
	    private function _hideExpandButton(event:MouseEvent = null):void {
	    	this._expand_button.visible = false;
	    }
	    
	    private function _clickExpandButton(event:MouseEvent):void {
	    	this.sendService(_mouseover_id);
	    	this._hideExpandButton();
	    }
	}
}