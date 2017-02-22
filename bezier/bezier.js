
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
    
    for (var k = 0; k < points.length; ++k) {
      row.push(binom(n,k));
    }

    matrix.push(row);
  }

  var rows = [];
  for (var n = 0; n < matrix.length; ++n) {
    rows.push(matrix[n].join(' && '));
  }

  var sMatrix = rows.join(' \\\\ ');
    
  $('#matrix').text('\\( \\begin{bmatrix}' + sMatrix + '\\end{bmatrix} \\)');
}