
var decimalPlaces = 0;

function matrixToString(matrix, sDescription) {

  var displayMatrix = [];
  
  for (var i = 0; i < matrix.length; ++i) {

    var arrRow = [];
    
    for (var j = 0; j < matrix[i].length; ++j) {
      var value = matrix[i][j];
      
      if (value.toFixed) {
        value = value.toFixed(decimalPlaces);
      }
      
      arrRow.push(value);
    }

    displayMatrix.push(arrRow);
  }
  
  var arrRows = [];
  for (i = 0; i < displayMatrix.length; ++i) {
    arrRows.push(displayMatrix[i].join(' && '));
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