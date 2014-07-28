
CompositeShape cube(PVector pvPosition, PVector pvSize)
{
  return (new CompositeShape())
                          .vertex(new Vertex("A", pvPosition.x,            pvPosition.y,            pvPosition.z))
                          .vertex(new Vertex("B", pvPosition.x + pvSize.x, pvPosition.y,            pvPosition.z))
                          .vertex(new Vertex("C", pvPosition.x + pvSize.x, pvPosition.y + pvSize.y, pvPosition.z))
                          .vertex(new Vertex("D", pvPosition.x,            pvPosition.y + pvSize.y, pvPosition.z))
                          .vertex(new Vertex("E", pvPosition.x,            pvPosition.y,            pvPosition.z + pvSize.z))
                          .vertex(new Vertex("F", pvPosition.x + pvSize.x, pvPosition.y,            pvPosition.z + pvSize.z))
                          .vertex(new Vertex("G", pvPosition.x + pvSize.x, pvPosition.y + pvSize.y, pvPosition.z + pvSize.z))
                          .vertex(new Vertex("H", pvPosition.x,            pvPosition.y + pvSize.y, pvPosition.z + pvSize.z))
                          .outline("ABCD")
                          .outline("EFGH")
                          .outline("AE")
                          .outline("BF")
                          .outline("CG")
                          .outline("DH")
                          .fill("ABCD")
                          .fill("EFGH")
                          .fill("ABFE")
                          .fill("BCGF")
                          .fill("CDHG")
                          .fill("DAEH");
}

float dombasWidth =  1400.0;
float dombasDepth =   510.0;
float dombasHeight = 1810.0;

CompositeShape dombas = cube(new PVector(500.0, 0.0, 0.0), new PVector(dombasWidth, -dombasHeight, dombasDepth)); 



