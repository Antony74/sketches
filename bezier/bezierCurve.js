/* global matrixMult */

function createBezierCurve(points) {

  // Create a matrix of t raised to various powers.  This is purely
  // for the documentation this program displays.
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

  var matrixT = [arrTerms];

  // Define a function for returning binomial coefficients
  function binom(n, k) {
  
      var coefficient = 1;
  
      for (var i = 1; i <= k; ++i) {
          coefficient *= (n + 1 - i) / i;
      }
  
      return coefficient;
  }

  // Populate a matrix with the curious pattern of
  // binomial coefficents used to generate bezier curves.
  var matrixBinomial = [];
  for (n = 0; n < points.length; ++n) {
    
    var row = [];
    var rowCoefficent = binom(points.length - 1, n);
    
    var sign1 = (points.length % 2) ? 1 : -1;

    for (var k = 0; k < points.length; ++k) {
      var value = binom(points.length - n - 1, k);
      var sign2 = ((k - n) % 2) ? -1 : 1;

      row.push(sign1 * sign2 * rowCoefficent * value);
    }

    matrixBinomial.push(row);
  }

  // Extract a matrix of x-control-points and y-control-points
  // from the array of points passed in
  var matrixX = [];
  var matrixY = [];

  for (n = 0; n < points.length; ++n) {
    matrixX.push([points[n].x]);
    matrixY.push([points[n].y]);
  }

  // And with a couple of calls to createBezierCurveDimension
  // we have our results, return them in this structure

  return {
    'matrixBinomial': matrixBinomial,
    't': {  
      'matrix': matrixT,
    },
    'x': createBezierCurveDimension(matrixBinomial, matrixX),
    'y': createBezierCurveDimension(matrixBinomial, matrixY)
  };
}

function createBezierCurveDimension(matrixBinomial, matrixControlPoints) {
  var matrixPolynomialCoefficients = matrixMult(matrixBinomial, matrixControlPoints);
  var arrPolynomialCofficients = [];
  
  for (var n = 0; n < matrixPolynomialCoefficients.length; ++n) {
    arrPolynomialCofficients.push(matrixPolynomialCoefficients[n][0]);
  }

  return {
    'matrixControlPoints': matrixControlPoints,
    'matrixPolynomialCoefficients': matrixPolynomialCoefficients,
    'fn': function(t) {
      var sum = 0;
      for (var n = 0; n < arrPolynomialCofficients.length; ++n) {
        var order = arrPolynomialCofficients.length - 1 - n;
        sum += arrPolynomialCofficients[n] * Math.pow(t, order);
      }
      return sum;
    }
  };
}