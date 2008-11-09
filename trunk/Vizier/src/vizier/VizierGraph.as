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

package src.vizier {
	
	import mx.utils.StringUtil;
	
	public class VizierGraph
	{
		private var _nodes:Array;
		private var _edges:Array;
		private var _height:int;
		private var _width:int;
		
		public function VizierGraph()
		{
			this._nodes = new Array();
			this._edges = new Array();
		}
		
		public function addNode(node:VizierNode):void {
			this._nodes.push(node);
		}
		
		public function addEdge(edge:VizierEdge):void {
			this._edges.push(edge);
		}
		
		public function get nodes():Array {
			return this._nodes;
		}
		
		public function get edges():Array {
			return this._edges;
		}
		
		public function get width():int {
			return this._width;
		}
		
		public function set width(value:int):void {
			this._width = value;
		}
		
		public function get height():int {
			return this._height;
		}
		
		public function set height(value:int):void {
			this._height = value;
		}

		public static function parseFromGraphviz(input:String, selected_node:String):VizierGraph {
			var graph:VizierGraph = new VizierGraph();
			
			// store global default properties for nodes and edges
			var default_node:Object = VizierNode.getDefaultProperties();
			var default_edge:Object = VizierEdge.getDefaultProperties();
			
			var lines:Array = input.split(";");	
	    	for each (var line:String in lines) {
	    		line = StringUtil.trim(line);
	    		
	    		var graph_regex:RegExp = /^graph \[(.+)\]$/;
	    		var allnode_regex:RegExp = /^node \[(.+)\]$/;
	    		var alledge_regex:RegExp = /^edge \[(.+)\]$/;
	    		var node_regex:RegExp = /^(\w+|\"\S+\") \[(.+)\]$/;
	    		var edge_regex:RegExp = /^(\w+|\"\S+\") -> (\w+|\"\S+\") \[(.+)\]$/;
	    		
	    		var result:Array = new Array();
	    		
	    		// canvas size
	    		if (result = line.match(graph_regex)) {
	    			var graph_props:Object = _parseProperties(result[1]);
	    			
	    			if (graph_props["bb"] != null) {
	    				var bounding_box_string:String = graph_props["bb"];
	    				var bb_coords:Array = bounding_box_string.split(',');
	    				graph.width = bb_coords[2];
	    				graph.height = bb_coords[3];
	    			}
					else if (graph_props["size"] != null) {
						var size_string:String = graph_props["size"];
						var size_coords:Array = size_string.split(',');
						graph.width = size_coords[0] * 72;
						graph.height = size_coords[1] * 72;
					}
	    		}
	    		
	    		else if (result = allnode_regex.exec(line)) {
	    			var new_node_props:Object = _parseProperties(result[1]);
	    			for (var node_key:String in new_node_props)
	    				default_node[node_key] = new_node_props[node_key];
	    		}
	    		else if (result = alledge_regex.exec(line)) {
	    			var new_edge_props:Object = _parseProperties(result[1]);
	    			for (var edge_key:String in new_edge_props)
	    				default_edge[edge_key] = new_edge_props[edge_key];
	    		}
	    		
	    		// node
	    		else if (result = node_regex.exec(line)) { 
	    			var id:String = result[1];
	    			id = id.replace(/^\"(.*)\"$/, '$1');
	    			
	    			// parse the property section
	    			var node_props:Object = _parseProperties(result[2]);		
	    			var node:VizierNode = new VizierNode(id, node_props, default_node);
	    			
	    			if (id == selected_node)
	    				node.selected = true;
    			
	    			graph.addNode(node);
	    		}
	    		
	    		// edge
	    		else if (result = edge_regex.exec(line)) {
	    			var out_id:String = result[1];
	    			var in_id:String = result[2];
	    			out_id.replace(/^\"(.*)\"$/, '$1');
	    			in_id.replace(/^\"(.*)\"$/, '$1');
	    			
	    			var edge_props:Object = _parseProperties(result[3]);
	    			var edge:VizierEdge = new VizierEdge(out_id, in_id, edge_props, default_edge);
	    			
	    			graph.addEdge(edge);
	    		}
	    	}
	    	return graph;
		}
		
		private static function _parseProperties(input:String):Object {
			var properties:Object = new Object();
			
			// remove commas from inside quotation marks so we can use split
			while (input.match(/="[^"]+?,[^"]+?"/)) {
				input = input.replace(/(="[^"]+?)(,)([^"]+?")/g, '$1|||$3');
			}
			
			var prop_array:Array = input.split(',');
			
			for each(var prop_string:String in prop_array) {
				prop_string = prop_string.replace(/\|\|\|/g, ',');
				var split_result:Array = prop_string.split('=', 2);
				
				// trim off whitespace and quotation marks
				var key:String = StringUtil.trim(split_result[0]);
				var value:String = StringUtil.trim(split_result[1]);
				value = value.replace(/^"(.*)"$/, '$1');
				
				properties[key] = value;
			}
			
			return properties;
		}
	}
}