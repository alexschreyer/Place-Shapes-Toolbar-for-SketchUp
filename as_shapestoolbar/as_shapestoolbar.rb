# =====================
# Main file for Place Shapes Toolbar
#
# by Alexander Schreyer, www.alexschreyer.net, mail@alexschreyer.net
#
# =====================


require 'sketchup.rb'


# =====================


module AS_Extensions

  module AS_Shapestoolbar


    # =====================

  
    # General variables
    @name = "Place Shapes"
    @extname = "as_shapestoolbar"
    
    @extdir = File.dirname(__FILE__)   
    @sfolder = File.join(@extdir, "shapes_ip")
    @ifolder = File.join(@extdir, "icons")    
  
    # Set base unit for shapes from stored value
    @unit = Sketchup.read_default @extname, "unit", "foot"

    # Could simply load all SKP files in folder
    # @skps = Dir.entries(@sfolder)
    # UI.messagebox @skps


    # =====================

    
    def self.place_me(name)
      
      # Definition file to load
      mod = Sketchup.active_model
      skp = File.join(@sfolder, name+".skp")
      
      # Load defnition and scale it
      dname = name+"-"+@unit
      
      if !mod.definitions[dname]
      
          # Scaling factor based on unit
          case @unit
            when "inch"
              scale = 1.0 / 12
            when "mm"
              scale = 1.0 / 12 / 2.54 / 10
            when "cm"
              scale = 1.0 / 12 / 2.54
            when "m"
              scale = 1.0 / 12 / 2.54 * 100
            else
              scale = 1.0
          end
          t = Geom::Transformation.new scale          
          
          # Load definition and give it unit-based name
          defs = mod.definitions
          d = defs.load skp
          d.name = dname
          
          # Scale definition entities accordingly
          ents = []
          d.entities.each { |e|
            ents.push e
          }
          d.entities.transform_entities(t,ents)
          
      end
      
      c = mod.definitions[dname]
      i = mod.place_component c, true
    
    end


    # =====================


    def self.select_unit
    
      prompts = ["Base unit"]
      defaults = [@unit]
      lists = ["inch|foot|mm|cm|m"]
      res = UI.inputbox(prompts, defaults, lists, "Set shape base unit")
      @unit = res[0]
      Sketchup.write_default @extname, "unit", @unit

    end
    

    # ============================
  
  
    def self.show_help
    # Show the website as an About dialog
    
      title = @name + ' - Help'
      url = 'http://alexschreyer.net/projects/place-shapes-toolbar-extension-for-sketchup/'
    
      if Sketchup.version.to_f < 17 then  # Use old method
        d = UI::WebDialog.new( title , true ,
          title.gsub(/\s+/, "_") , 1000 , 600 , 100 , 100 , true);
        d.navigation_buttons_enabled = false
        d.set_url( url )
        d.show      
      else
        d = UI::HtmlDialog.new( { :dialog_title => title, :width => 1000, :height => 600,
          :style => UI::HtmlDialog::STYLE_DIALOG, :preferences_key => title.gsub(/\s+/, "_") } )
        d.set_url( url )
        d.show
        d.center
      end      
      
    end # show_help


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

      # Get icon file extension
      sm = lg = ""    
      RUBY_PLATFORM =~ /darwin/ ? ext = "pdf" : ext = "svg"
      if Sketchup.version.to_i < 16  
        ext = "png"
        sm = "_sm"
        lg = "_lg"
      end
      
      # Add them all to menu and toolbar
      shapes.each { |s|
      
        cmd = UI::Command.new(s.capitalize) { self.place_me(s) }
        cmd.small_icon = File.join(@ifolder, s + "#{sm}.#{ext}")
        cmd.large_icon = File.join(@ifolder, s + "#{lg}.#{ext}")
        cmd.tooltip = s.capitalize
        cmd.status_bar_text = "Place " + s + " (multiple)"
        menu.add_item cmd
        toolbar.add_item cmd    
      
      }
      
      menu.add_separator
      toolbar.add_separator
      
      # Add the unit selector
      s = "Set shape base unit"
      cmd = UI::Command.new(s.capitalize) { self.select_unit }
      cmd.small_icon = File.join(@ifolder, "unit#{sm}.#{ext}")
      cmd.large_icon = File.join(@ifolder, "unit#{lg}.#{ext}")
      cmd.tooltip = s.capitalize
      cmd.status_bar_text = "Set the base unit for all shapes placed next"
      menu.add_item cmd
      toolbar.add_item cmd      
      
      # And a link to get help
      menu.add_item ("Help") { self.show_help }
  
      # Don't forget to show the toolbar
      toolbar.show
      
      # Let Ruby know we have loaded this file
      file_loaded(__FILE__)
    
    end # if  


    # =====================

  
  end # AS_Shapestoolbar
  
end # AS_Extensions


# =====================
