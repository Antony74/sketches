
Object world;
int SCALE = 30;

void setup()
{
  size(900,500);
  
  world = new Box2D.Dynamics.b2World(
                 new Box2D.Common.Math.b2Vec2(0, 0), // No gravity
                 true);                              // Allow bodies to sleep, although in this case they probably don't
  
   var fixDef = new Box2D.Dynamics.b2FixtureDef();
   fixDef.density = 1.0;
   fixDef.friction = 0;
   fixDef.restitution = 1;
   
   var bodyDef = new Box2D.Dynamics.b2BodyDef();
  
   //create ground
   bodyDef.type = Box2D.Dynamics.b2Body.b2_staticBody;
   
   fixDef.shape = new Box2D.Collision.Shapes.b2PolygonShape();
   
   bodyDef.position.x = width / 2 / SCALE;
   bodyDef.position.y = height / SCALE;
   fixDef.shape.SetAsBox((width / SCALE), (10/SCALE) / 2);
   world.CreateBody(bodyDef).CreateFixture(fixDef);

   bodyDef.position.y = 0;
   world.CreateBody(bodyDef).CreateFixture(fixDef);

   bodyDef.position.x = 0;
   bodyDef.position.y = height / SCALE;
   fixDef.shape.SetAsBox((10/SCALE) / 2, height);
   world.CreateBody(bodyDef).CreateFixture(fixDef);

   bodyDef.position.x = width / SCALE;
   world.CreateBody(bodyDef).CreateFixture(fixDef);

   //create some objects
   bodyDef.type = Box2D.Dynamics.b2Body.b2_dynamicBody;

   for(int i = 0; i < 15; ++i)
   {
    var dRadius = (Math.random() * 1.0) + 1.0;
    fixDef.shape = new Box2D.Collision.Shapes.b2CircleShape(dRadius);

    bodyDef.position.x = Math.random() * width / SCALE;
    bodyDef.position.y = Math.random() * height /SCALE;
    bodyDef.linearVelocity.x = (Math.random() * 20) - 5;
    bodyDef.linearVelocity.y = (Math.random() * 20) - 5;
    bodyDef.angle = Math.random() * TWO_PI;
    bodyDef.angularVelocity = (Math.random() * 50) - 25;
    b2Body body = world.CreateBody(bodyDef);
    body.CreateFixture(fixDef);
    body.SetUserData(dRadius);
  }
}

boolean bFirstTime = true;

void draw()
{
  background(128);

  world.Step(
         1 / 60 //frame-rate
      , 10 //velocity iterations
      , 10 //position iterations
   );

   world.ClearForces();

   Box2D.Dynamics.b2Body b;
   
   for (b = world.GetBodyList(); b != null; b = b.GetNext())
   {
     if (b.GetUserData() != null)
     {
       yinYang(b.GetPosition().x * SCALE, b.GetPosition().y * SCALE, b.GetUserData() * SCALE * 2.0, b.GetAngle());
     }
  }

  bFirstTime = false;
}

void yinYang(double x, double y, double diameter, double angle)
{
  pushMatrix();
  translate(x,y);
  rotate(angle);
  
  double radius = diameter / 2.0;
  double q = diameter / 4.0;
  double e = diameter / 8.0;
  
  stroke(0);

  fill(255);
  arc(0, 0, diameter, diameter, 0, PI);
 
  fill(0);
  arc(0, 0, diameter, diameter, PI, TWO_PI);

  noStroke();
  
  ellipse(0 - q, 0, radius, radius);

  fill(255);
  ellipse(0 + q, 0, radius, radius);

  ellipse(0 - q, 0, e, e);

  fill(0);
  ellipse(0 + q, 0, e, e);

  popMatrix();
}


