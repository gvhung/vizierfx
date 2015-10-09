# Introduction #

This page lists all the things I am planning to do with VizierFX.

# Details #

  * Add support for XDot format.
  * Add support for drawing:
    * Subgraphs / clusters
    * All arrow / node shapes
    * Dotted / dashed edges
  * Decouple VizierCanvas class a bit.  In particular, move the drawing stuff to VizierEdge and VizierNode.
  * Split GraphViz parser out from VizierGraph class.
  * Make VizierEdge and VizierNode classes dynamic.
  * Allow edges to be clicked.
  * Animate edges during transitions.
  * Add more interactivity.
  * Add parameter support for expanding individual nodes.
  * Fix line breaks in node labels.
  * (Eventually) Perform graph layout on client side.