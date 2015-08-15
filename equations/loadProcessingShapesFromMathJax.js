//
// loadProcessingShapesFromMathJax
//
// Requires Processing.js, MathJax and JQuery.  MathJax should be set up to render as SVG.
//

function loadProcessingShapesFromMathJax(fnCallback)
{
    processing = new Processing()
    {
        MathJax.Hub.Queue(function()
        {
            var arrShapes = [];

            // Processing.js doesn't understand the <use> tag, so replace it with the thing being used
            $('use').each(function()
            {
                var id = $(this).attr('href');

                if ($(id).length == 1)
                {
                    var clone = $(id).clone();

                    if ($(this).attr('x') && $(this).attr('y'))
                    {
                        var x = $(this).attr('x');
                        var y = $(this).attr('y');
                        clone.wrap('<g transform="translate(' + x + ',' + y + ')"></g>');
                        clone = clone.parent();
                    }

                    if ($(this).attr('transform'))
                    {
    //                    console.log('has transform');
                    }

                    clone.wrap('<div>');
                    clone = clone.parent();

                    $(this).replaceWith(clone.html());
                }
            });

            var bFirst = true;

            $('svg').each(function()
            {
                if (bFirst == false)
                {
                    var clone = $(this).clone();
                    clone.wrap('<div>');
                    clone = clone.parent();
                    var html = clone.html();
                    var xml = processing.loadXML(html);
                    var myShape = new processing.PShapeSVG(xml);
                    arrShapes.push(myShape);
                }
                
                bFirst = false;
            });

            fnCallback(arrShapes);
        });
    }
}

