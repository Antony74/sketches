
function createGraph(config)
{
    var canvas = document.getElementById(config.sCanvasID);

    var processing = new Processing(canvas, function(processing)
    {
        processing.setup = function()
        {
            processing.size(config.width, config.height);

            processing.noFill();
        }
    });

    var getXplot = function(xPixel)
    {
        return processing.map(xPixel, 0, processing.width, config.xmin, config.xmax);
    }

    var getYplot = function(yPixel)
    {
        return processing.map(yPixel, processing.height, 0, config.ymin, config.ymax);
    }

    var getXpixel = function(xPlot)
    {
        return processing.map(xPlot, config.xmin, config.xmax, 0, processing.width);
    }

    var getYpixel = function(yPlot)
    {
        return processing.map(yPlot, config.ymin, config.ymax, processing.height, 0);
    }

    // Draw the x and y axis
    processing.line(getXpixel(0), getYpixel(config.ymin), getXpixel(0), getYpixel(config.ymax));
    processing.line(getXpixel(config.xmin), getYpixel(0), getXpixel(config.xmax), getYpixel(0));

    // Set a default stroke for plotting with
    processing.stroke(0, 0, 255);
    processing.strokeWeight(3);

    // Currently only the ploting of continuous functions is supported
    processing.plot = function(fnToPlot)
    {
        processing.beginShape();

        for (var xPixel = 0; xPixel < processing.width; ++xPixel)
        {
            var yPlot = fnToPlot(getXplot(xPixel));
            yPixel = getYpixel(yPlot);
            processing.vertex(xPixel, yPixel);
        }

        processing.endShape();
    }

    return processing;
}

