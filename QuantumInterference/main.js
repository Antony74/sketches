$(document).ready(function()
{
    var sNormFn = $('#NormFn').val();
    var sLeftFn = $('#LeftFn').val();
    var sRightFn = $('#RightFn').val();

    $('#prettyNormFn').html('$$' + math.parse(sNormFn).toTex() + '$$');

    var graph = createGraph(
    {
        sCanvasID: 'canvasPlot',
        width:     640,
        height:    300,
        xmin:       -4,
        ymin:     -0.1,
        xmax:        4,
        ymax:      0.5,
    });

    var normFn = math.eval(sNormFn);
    var leftFn = math.eval(sLeftFn,   {Norm: normFn});
    var rightFn = math.eval(sRightFn, {Norm: normFn});
    graph.plot(leftFn);
    graph.plot(rightFn);
});

