# Loader for as_shapestoolbar/as_shapestoolbar.rb

require 'sketchup'
require 'extensions'

as_shapestoolbar = SketchupExtension.new "Place Shapes Toolbar", "as_shapestoolbar/as_shapestoolbar.rb"
as_shapestoolbar.copyright= 'Copyright 2015 Alexander C. Schreyer'
as_shapestoolbar.creator= 'Alexander C. Schreyer, www.alexschreyer.net'
as_shapestoolbar.version = '1.0'
as_shapestoolbar.description = "A toolbar (and menu item) that lets you place several primitives. All are based on 1 ft in the US and 1 m everywhere else."
Sketchup.register_extension as_shapestoolbar, true
