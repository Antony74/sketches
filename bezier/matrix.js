
function matrixToString(matrix) {

  var arrRows = [];
  for (var n = 0; n < matrix.length; ++n) {
    arrRows.push(matrix[n].join(' && '));
  }

  var sMatrix = arrRows.join(' \\\\ ');
  return '\\begin{bmatrix}' + sMatrix + '\\end{bmatrix}';
}

