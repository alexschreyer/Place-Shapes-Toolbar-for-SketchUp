# =====================
# Main file for Place Shapes Toolbar
# =====================


require 'sketchup'


# =====================


module AS_Extensions

  module AS_Shapestoolbar


    # =====================

  
    # General variables
    @name = "Place Shapes"
  
    # Localise: Use 1 ft shapes for US and 1 m shapes for everyone else
    Sketchup.get_locale == "en-US" ? @loc = "ip" : @loc = "m"
    @sfolder = File.join(File.dirname(__FILE__), "shapes_"+@loc)
    @ifolder = File.join(File.dirname(__FILE__), "icons")

    # @skps = Dir.entries(@sfolder)
    # UI.messagebox @skps


    # =====================

    
    def self.place_me(name)
      
      mod = Sketchup.active_model
      skp = File.join(@sfolder, name+".skp")
      
      mod.import skp, false if !mod.definitions[name]
      c = mod.definitions[name]
      mod.place_component c, true
    
    end


    # =====================

    
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


    # =====================

  
  end # AS_Shapestoolbar
  
end # AS_Extensions


# =====================