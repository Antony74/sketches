//
// LoadShapesFromMathJaxToProcessing
//
// Requires Processing.js, MathJax and JQuery.  MathJax should be set up to render as SVG.
//

var shapesFromMathJax = {size: function() {return 0;} };

MathJax.Hub.Queue(function() // Let MathJax do its thing
{
    var processing = new Processing();

    shapesFromMathJax = new processing.ArrayList();

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

            // Set the height and width to something meaningful
            var min = eachVertex(myShape, Math.min, Number.MAX_SAFE_INTEGER, Number.MAX_SAFE_INTEGER);
            var max = eachVertex(myShape, Math.max, Number.MIN_SAFE_INTEGER, Number.MIN_SAFE_INTEGER);
            myShape.width =  max[0] - min[0];
            myShape.height = max[1] - min[1];

            // And add it to the array of shapes we are creating
            shapesFromMathJax.add(myShape);
        }
                
        bFirst = false;
    });

    function createParent(element, wrapper)
    {
        element.wrap(wrapper);
        return element.parent();
    }

    function eachVertex(shape, fn, x, y)
    {
        for (var n = 0; n < shape.getChildCount(); ++n)
        {
            var value = eachVertex(shape.getChild(n), fn, x, y);
            x = value[0];
            y = value[1];
        }

        for (var n = 0; n < shape.vertices.length; ++n)
        {
            x = fn(shape.vertices[n][0], x);
            y = fn(shape.vertices[n][1], y);
        }

        return [x, y];
    }
});


