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
                TBD:
                - Code cleanup

Issues:         N/A

TODO List:      - Preferences: Base unit (inch, mm,...) and scale, stickyness

=end


# =====================


require 'sketchup'
require 'extensions'


# =====================


as_shapestoolbar = SketchupExtension.new "Place Shapes Toolbar", "as_shapestoolbar/as_shapestoolbar.rb"
as_shapestoolbar.copyright= 'Copyright 2015 Alexander C. Schreyer'
as_shapestoolbar.creator= 'Alexander C. Schreyer, www.alexschreyer.net'
as_shapestoolbar.version = '1.0'
as_shapestoolbar.description = "A toolbar (and menu item) that lets you place several primitives. All are based on 1 ft in the US and 1 m everywhere else."
Sketchup.register_extension as_shapestoolbar, true


# =====================