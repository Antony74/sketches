
function matrixToString(matrix, sDescription) {

  var arrRows = [];
  for (var n = 0; n < matrix.length; ++n) {
    arrRows.push(matrix[n].join(' && '));
  }

  var sMatrix = arrRows.join(' \\\\ ');

  var sText = '\\begin{array}{ccc}';

  if (sDescription) {
    sText  += '\\underbrace{';
  }
  
  sText    += '\\begin{bmatrix}' + sMatrix + '\\end{bmatrix}';

  if (sDescription) {
    sText  += '}';
  } else {
    sDescription = ' ';
  }
  
  sText    += '\\\\';
  sText    += '\\textit{' + sDescription + '}';
  sText    += '\\end{array}';

  return sText;
}

function matrixMult(a, b) {
  
  var c = [];
  
  for(var i = 0; i < a.length; ++i) {
      c[i] = [];
      for (var j = 0; j < b[0].length; j++) {
          var sum = 0;
          for (var k = 0; k < b.length; k++) {
              sum += a[i][k] * b[k][j];
          }
          c[i][j] = sum;
      }
   }

  return c;
}