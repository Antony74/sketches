$(document).ready(function()
{
    var sNormFn = $('#NormFn').val();

    $('#prettyNormFn').html('$$' + math.parse(sNormFn).toTex() + '$$');

    var graph = createGraph(
    {
        sCanvasID: 'canvasPlot',
        width:     640,
        height:    300,
        xmin:       -2,
        ymin:    - 0.1,
        xmax:        2,
        ymax:      0.5,
    });

    var scope = 
    {
        mu:    0,
        sigma: 1,
    };

    var thing = math.eval(sNormFn, scope);
    graph.plot(thing);
});

