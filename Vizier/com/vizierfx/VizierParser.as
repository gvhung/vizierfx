package com.vizierfx
{
	public class VizierParser
	{
		import mx.utils.StringUtil;
		import mx.controls.Alert;
		public static function parseFromGraphviz(input:String, selected_node:String):VizierGraph {
			var graph:VizierGraph = new VizierGraph();
			
			// store global default properties for nodes and edges
			var default_node:Object = VizierNode.getDefaultProperties();
			var default_edge:Object = VizierEdge.getDefaultProperties();
			
			var graph_regex:RegExp = /^graph \[(.+)\]$/;
    		var allnode_regex:RegExp = /^node \[(.+)\]$/;
    		var alledge_regex:RegExp = /^edge \[(.+)\]$/;	  
    		
    		// build up the legal components for node IDs
    		// alphanumeric strings, numbers, and quoted strings
    		var alpha_id:String = '[a-zA-Z0-9_\\x80-\\xFF]+';
    		var number_id:String = '-?(?:.[0-9]+|[0-9]+(?:.[0-9]*)?)'
    		var quoted_id:String = '\\"(?:(?:\\\\")*[^"](?:\\\\")*)+\\"';
    		var id_string:String = alpha_id + '|' + number_id + '|' + quoted_id;  		
    		
    		var node_regex:RegExp = new RegExp('^(' + id_string + ') \\[(.+)\\]$');
    		var edge_regex:RegExp = new RegExp('^(' + id_string + ') -[->] (' + id_string + ') \\[(.+)\\]$');
			
			var lines:Array = input.split(";");	
	    	for each (var line:String in lines) {
	    		line = StringUtil.trim(line);
	    		
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
	    			var id:String = _dequote(result[1]);
	    			
	    			// parse the property section
	    			var node_props:Object = _parseProperties(result[2]);		
	    			var node:VizierNode = new VizierNode(id, node_props, default_node);
	    			
	    			if (id == selected_node)
	    				node.selected = true;
    			
	    			graph.addNode(node);
	    		}
	    		
	    		// edge
	    		else if (result = edge_regex.exec(line)) {
	    			var out_id:String = _dequote(result[1]);
	    			var in_id:String = _dequote(result[2]);
	    			
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
		
		// converts a quoted string into an unquoted one
		// It removes beginning and ending quotes, if present,
		// and converts \" to ".
		private static function _dequote(input:String):String {
		    if (input.match(/^\".*\"$/)) {
				input = input.replace(/^\"(.*)\"$/, '$1');
				input = input.replace(/\\"/g, '"');
			}
			return input;
		}
	}
}