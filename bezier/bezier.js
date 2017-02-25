/* global createBezierCurve, matrixToString */

var points = [
  {x:  75, y: 300},
  {x: 150, y:  50},
  {x: 225, y: 350},
  {x: 300, y: 150},
  {x: 375, y: 300}
];

var bezierCurve = null;
var rectRadius = 10;
var dragIndex = -1;

function setup() {
  createCanvas(400, 400).parent('canvasParent');
  rectMode(RADIUS);
  drawCurve();
  noLoop();
  
  writeEquation('x');
  writeEquation('y');
}

function drawCurve() {
  bezierCurve = createBezierCurve(points);

  // Draw the curve
  stroke(0);
  strokeWeight(2);
  noFill();

  var x = bezierCurve.x.fn;
  var y = bezierCurve.y.fn;
  
  beginShape();
  for (var t = 0; t <= 1; t += 0.004) {
    vertex(x(t), y(t));
  }
  endShape();
  
  // Draw the control points

  noStroke();

  for (var n = 0; n < points.length; ++n) {
    
     if (n == 0 || n == points.length - 1) {
       fill(255, 0, 0, 128);
     } else {
       fill(0, 255, 0, 128);
     }
    
     rect(points[n].x, points[n].y, rectRadius, rectRadius);
  }
}

function writeEquation(v) {

  var sEq = '\\begin{array}{ccc}' + v + '(t) = \\\\ \\textit{ } \\end{array}';
  sEq    += matrixToString(bezierCurve.t.matrix);
  sEq    += matrixToString(bezierCurve.matrixBinomial);
  sEq    += matrixToString(bezierCurve[v].matrixControlPoints, 'control points ' + v);

  var arr = [];

  for (var n = 0; n < points.length; ++n) {
    var s = bezierCurve[v].matrixPolynomialCoefficients[n][0];
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
 
  document.getElementById('equation-' + v).textContent = '\\( ' + sEq + '\\)';
}