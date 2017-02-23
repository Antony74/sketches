
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