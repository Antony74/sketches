//
// loadProcessingShapesFromMathJax
//
// Requires Processing.js, MathJax and JQuery.  MathJax should be set up to render as SVG.
//

function loadProcessingShapesFromMathJax(fnCallback)
{
    processing = new Processing()
    {
        MathJax.Hub.Queue(function() // Let MathJax do its thing
        {
            var arrShapes = [];

            // The first chunk of SVG that MathJax creates is its cache of glyphs, which we skip.
            // The other chunks are the equations we want, so we iterate through them.

            var bFirst = true;

            $('svg').each(function()
            {
                if (bFirst == false)
                {
                    // Clone this chunk of SVG
                    var svg = $(this).clone();

                    // Processing.js doesn't support the <use> tag, so replace it with the thing being used
                    svg.find('use').each(function()
                    {
                        var id = $(this).attr('href');

                        if ($(id).length == 1)
                        {
                            // Clone the glyph
                            var glyph = $(id).clone();

                            // If the <use> tag had x and y attributes, place the glyph within a group which mimics these
                            if ($(this).attr('x') && $(this).attr('y'))
                            {
                                var x = $(this).attr('x');
                                var y = $(this).attr('y');
                                glyph = createParent(glyph, '<g transform="translate(' + x + ',' + y + ')"></g>');
                            }

                            // If the <use> tag had a transform attribute, place the glyph within a group which mimics these
                            if ($(this).attr('transform'))
                            {
                                glyph = createParent(glyph, '<g transform="' + $(this).attr('transform') + '"></g>');
                            }

                            // Now replace the <use> tag with our (properly wrapped) glyph
                            glyph = createParent(glyph, '<div>');
                            $(this).replaceWith(glyph.html());
                        }
                    });

                    // Get the text of this SVG
                    svg = createParent(svg, '<div>');
                    var html = svg.html();

                    // Load it into Processing, first as XML, then as a shape
                    var xml = processing.loadXML(html);
                    var myShape = new processing.PShapeSVG(xml);

                    // And add it to the array of shapes we are creating
                    arrShapes.push(myShape);
                }
                
                bFirst = false;
            });

            fnCallback(arrShapes);
        });
    }
}

function createParent(element, wrapper)
{
    element.wrap(wrapper);
    return element.parent();
}

