//
// Some utils for calling the Processing API with PVector instead of x and y.
// I've used the pv_ prefix rather than overriding the original methods, so as not
// to create hard to find bugs in JavaScript-mode.
//

void pv_vertex(PVector pv)
{
  vertex(pv.x, pv.y);
}


