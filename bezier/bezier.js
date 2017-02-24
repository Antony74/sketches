/* global matrixToString, matrixMult */

var points = [
  [100, 600],
  [200,   0],
  [200, 900],
  [300, 300],
  [400, 600]
];

var matrix = null;

function setup() {
  createCanvas(400, 400).parent('canvasParent');
  noLoop();
  
  $(document).ready(function() {
    matrix = updateMatrix();
    writeEquations();
    loop();
  });
}

function draw() {
  
}

function binom(n, k) {

    var coefficient = 1;

    for (var i = 1; i <= k; ++i) {
        coefficient *= (n + 1 - i) / i;
    }

    return coefficient;
}

function updateMatrix() {
  var matrix = [];
  for (var n = 0; n < points.length; ++n) {
    
    var row = [];
    var rowCoefficent = binom(points.length - 1, n);
    
    var sign1 = (points.length % 2) ? 1 : -1;

    for (var k = 0; k < points.length; ++k) {
      var value = binom(points.length - n - 1, k);
      var sign2 = ((k - n) % 2) ? -1 : 1;

      row.push(sign1 * sign2 * rowCoefficent * value);
    }

    matrix.push(row);
  }

  return matrix;
}

function writeEquations() {
  var matrixX = [];
  var matrixY = [];

  for (var n = 0; n < points.length; ++n) {
    matrixX.push([points[n][0]]);
    matrixY.push([points[n][1]]);
  }

  writeEquation('x', matrixX);
  writeEquation('y', matrixY);
}

function writeEquation(v, matrixV) {
  var arrTerms = [];
  
  for (var n = points.length - 1; n >= 0; --n) {
    switch(n) {
    default:
      arrTerms.push('t^' + n);
      break;
    case 1:
      arrTerms.push('t');
      break;
    case 0:
      arrTerms.push('1');
      break;
    }
  }

  var co = matrixMult(matrix, matrixV);

  var sEq = '\\begin{array}{ccc}' + v + '(t) = \\\\ \\textit{ } \\end{array}';
  sEq    += matrixToString([arrTerms]) + matrixToString(matrix) + matrixToString(matrixV, 'control points ' + v);

  var arr = [];

  for (n = 0; n < points.length; ++n) {
    var s = co[n][0];
    
    if (arrTerms[n] != '1') {
      s += arrTerms[n];
    }
    
    arr.push(s); 
  }

  sEq += ' = ' + arr.join(' + ');
    
  $('#equation-' + v).text('\\( ' + sEq + '\\)');

}