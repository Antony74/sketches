
import java.lang.Math;

// return pdf(x) = standard Gaussian pdf
float pdf(float x) {
    double pdf = Math.exp(-x*x / 2) / Math.sqrt(2 * Math.PI);
    return (float)pdf;
}

void setup() {
  size(300, 300);
  for (float x = -4; x <= 4; x += 0.01) {
    float y = pdf(x);
    point(
      map(x, -4, 4, 0, width),
      map(y,  0, 1, 0, height)
    );
  }
}
