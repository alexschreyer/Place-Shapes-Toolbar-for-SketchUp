=begin

Copyright 2015, Alexander C. Schreyer
All rights reserved

THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE.

License:        GPL (http://www.gnu.org/licenses/gpl.html)

Author :        Alexander Schreyer, www.alexschreyer.net, mail@alexschreyer.net

Website:        http://www.alexschreyer.net/projects/place-shapes-toolbar-extension-for-sketchup/

Name :          Place Shapes Toolbar

Version:        1.0

Date :          2/2/2015

Description :   A toolbar (and menu item) that lets you place several
                primitives.
                All are based on 1 ft in the US and 1 m everywhere else.
                
Usage :         The easiest way is to show the "Place Shapes" toolbar and click
                on the shape you want to place (or use the Draw menu's items.
                Most shapes will attach themselves to the underlying geometry.
                Use the move and stretch tool in combination with the solid
                tools to work with them.
                You can also always explode them to work with the underlying faces.

History:        1.0 (2/2/2015):
                - Initial release
                - Added wedge, roof, vault
                - Added cpoints to all spheres, etc.
                - Rotated and scaled pyramid
                - Sorted shapes better
                
Issues:         N/A              
                
TODO List:      N/A

=end


require 'sketchup'

module AS_Extensions

  module AS_Shapestoolbar
  
    # General variables
    @name = "Place Shapes"
  
    # Localise: Use 1 ft shapes for US and 1 m shapes for everyone else
    Sketchup.get_locale == "en-US" ? @loc = "ip" : @loc = "m"
    @sfolder = File.join(File.dirname(__FILE__), "shapes_"+@loc)
    @ifolder = File.join(File.dirname(__FILE__), "icons")

    # @skps = Dir.entries(@sfolder)
    # UI.messagebox @skps
    
    def self.place_me(name)
      
      mod = Sketchup.active_model
      skp = File.join(@sfolder, name+".skp")
      
      mod.import skp, false if !mod.definitions[name]
      c = mod.definitions[name]
      mod.place_component c, true
    
    end
    
    # Load extension at startup and add menu items
    if !file_loaded?(__FILE__)
    
      # Add to the Draw menu and create a toolbar    
      menu = UI.menu("Draw").add_submenu(@name)
      toolbar = UI::Toolbar.new @name    
      
      # All shapes to load in this order
      shapes = ["box", "roof", "wedge", "pyramid", "hexagon",
                "sphere", "cylinder", "cone", "dome", "vault", "torus",
                "icosahedron", "geodesic sphere", "geodesic dome"]
      
      # Add them all to menu and toolbar
      shapes.each { |s|
      
        cmd = UI::Command.new(s.capitalize) { self.place_me(s) }
        cmd.small_icon = File.join(@ifolder, s + "_sm.png")
        cmd.large_icon = File.join(@ifolder, s + "_l.png")
        cmd.tooltip = s.capitalize
        cmd.status_bar_text = "Place " + s + " (multiple)"
        menu.add_item cmd
        toolbar = toolbar.add_item cmd    
      
      }
  
      # Don't forget to show the toolbar
      toolbar.show
      
      # Let Ruby know we have loaded this file
      file_loaded(__FILE__)
    
    end # if  
  
  end # AS_Shapestoolbar
  
end # AS_Extensions
