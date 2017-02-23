
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

// https://rosettacode.org/wiki/Evaluate_binomial_coefficients#JavaScript
function binom(n, k) {
    var coeff = 1;
    for (var i = n-k+1; i <= n; i++) coeff *= i;
    for (var i = 1;     i <= k; i++) coeff /= i;
    return coeff;
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

  var arrTerms = [];
  
  for (var n = points.length; n >= 0; --n) {
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

  var sMatrixT = '\\begin{bmatrix}' + arrTerms.join(' && ') + '\\end{bmatrix}';
  
  var arrRows = [];
  for (var n = 0; n < matrix.length; ++n) {
    arrRows.push(matrix[n].join(' && '));
  }

  var sMatrix = arrRows.join(' \\\\ ');
  sMatrix = '\\begin{bmatrix}' + sMatrix + '\\end{bmatrix}';
    
  var sEqX = 'x(t) = ' + sMatrixT + sMatrix;
    
  $('#matrix').text('\\( ' + sEqX + '\\)');

}