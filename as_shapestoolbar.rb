=begin

Copyright 2015-2020, Alexander C. Schreyer
All rights reserved

THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE.

License:        GPL (http://www.gnu.org/licenses/gpl.html)

Author :        Alexander Schreyer, www.alexschreyer.net, mail@alexschreyer.net

Website:        http://www.alexschreyer.net/projects/place-shapes-toolbar-extension-for-sketchup/

Name :          Place Shapes Toolbar

Version:        1.4

Date :          6/17/2020

Description :   A toolbar (and menu item) that lets you place several
                primitives. These can be scaled based on a picked unit size.

Usage :         The easiest way is to show the "Place Shapes" toolbar and click
                on the shape you want to place (or use the Draw menu's items.
                Most shapes will attach themselves to the underlying geometry.
                Use the move and stretch tool in combination with the solid
                tools to work with them. Right-click and "unglue" where needed.
                You can also always explode them to work with the underlying faces.

History:        1.0 (2/2/2015):
                - Initial release
                - Added wedge, roof, vault
                - Added cpoints to all spheres, etc.
                - Rotated and scaled pyramid
                - Sorted shapes better
                1.1 (2/16/2016):
                - Code cleanup
                - New icons
                - Added base unit picker, now items are scaled
                - Better component naming as a result
                - Removed metric base items
                - Added help menu item
                1.2 (7/21/2017):
                - Fixed loader code
                - Provided SVG/PDF icons for high res displays (SU > 2016)
                - Help window shows as HtmlDialog (SU > 2017)
                1.3 (5/6/2020)
                - Help dialog fix (2020 GC issue)
                1.4 (6/17/2020)
                - New functionality: Place selected component (multiple)

=end


# ========================


require 'sketchup.rb'
require 'extensions.rb'


# ========================


module AS_Extensions

  module AS_Shapestoolbar
  
    @extversion           = "1.4"
    @exttitle             = "Place Shapes Toolbar"
    @extname              = "as_shapestoolbar"
    
    @extdir = File.dirname(__FILE__)
    @extdir.force_encoding('UTF-8') if @extdir.respond_to?(:force_encoding)
    
    loader = File.join( @extdir , @extname , "as_shapestoolbar.rb" )
   
    extension             = SketchupExtension.new( @exttitle , loader )
    extension.copyright   = "Copyright 2015-#{Time.now.year} Alexander C. Schreyer"
    extension.creator     = "Alexander C. Schreyer, www.alexschreyer.net"
    extension.version     = @extversion
    extension.description = "A toolbar (and Draw menu item) that lets you place several basic shapes (primitives). These can be scaled based on a picked unit size."
    
    Sketchup.register_extension( extension , true )
         
  end  # module AS_Shapestoolbar
  
end  # module AS_Extensions


# ========================
