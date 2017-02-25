/* global createBezierCurve, matrixToString */

var points = [
  {x: 100, y: 600},
  {x: 200, y:   0},
  {x: 200, y: 900},
  {x: 300, y: 300},
  {x: 400, y: 600}
];

var bezierCurve = null;

function setup() {
  createCanvas(400, 400).parent('canvasParent');
  noLoop();
  
  $(document).ready(function() {
    bezierCurve = createBezierCurve(points);
    writeEquation('x');
    writeEquation('y');
    loop();
  });
}

function draw() {
  
}

function writeEquation(v) {

  var sEq = '\\begin{array}{ccc}' + v + '(t) = \\\\ \\textit{ } \\end{array}';
  sEq    += matrixToString(bezierCurve.t.matrix);
  sEq    += matrixToString(bezierCurve.matrixBinomial);
  sEq    += matrixToString(bezierCurve[v].matrix, 'control points ' + v);

  var arr = [];

  for (var n = 0; n < points.length; ++n) {
    var s = bezierCurve[v].matrix[n][0];
    var sT = bezierCurve.t.matrix[0][n];
    
    if (sT != '1') {
      s += sT;
    }
    
    arr.push(s); 
  }

  sEq += ' = ' + arr.join(' + ');

  while (sEq.indexOf(' + -') != -1) {
    sEq = sEq.replace(' + -', ' -'); // An addition followed by a negation is better written as a subtraction
  }
    
  $('#equation-' + v).text('\\( ' + sEq + '\\)');

}