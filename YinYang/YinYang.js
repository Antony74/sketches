
var world;
var SCALE;
var body;

function worldInit(width, height, nScale)
{
  SCALE = nScale;

  world = new Box2D.Dynamics.b2World(
                 new Box2D.Common.Math.b2Vec2(0, 0), // No gravity
                 true);                              // Allow bodies to sleep, although in this case they probably don't

   var fixDef = new Box2D.Dynamics.b2FixtureDef();
   fixDef.density = 1.0;
   fixDef.friction = 0.0;
   fixDef.restitution = 1.0;

   var bodyDef = new Box2D.Dynamics.b2BodyDef();
  
   // Create a box around the visible extents of our little world

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

   // Create some circular bodies

   bodyDef.type = Box2D.Dynamics.b2Body.b2_dynamicBody;

   for(i = 0; i < 15; ++i)
   {
    var dRadius = (Math.random() * 1.0) + 1.0;
    fixDef.shape = new Box2D.Collision.Shapes.b2CircleShape(dRadius);

    bodyDef.position.x = Math.random() * width / SCALE;
    bodyDef.position.y = Math.random() * height / SCALE;
    bodyDef.linearVelocity.x = (Math.random() - 0.5) * 7.0;
    bodyDef.linearVelocity.y = (Math.random() - 0.5) * 7.0;
    bodyDef.angle = Math.random() * 2.0 * Math.PI;
    bodyDef.angularVelocity = (Math.random() - 0.5) * 15;
    var body = world.CreateBody(bodyDef);
    body.CreateFixture(fixDef);
    body.SetUserData(dRadius);
  }
}

function worldStep()
{
  world.Step(
         1 / 10,  // frame-rate
         8,       // velocity iterations
         3);      // position iterations

   world.ClearForces();
}

function worldGetFirstBody()
{
  body = world.GetBodyList();
  
  if (body.GetUserData() == null)
  {
    return worldGetNextBody();
  }
  
  return body != null;
}

function worldGetNextBody()
{
  body = body.GetNext();

  while (body != null && body.GetUserData() == null)
  {
    body = body.GetNext();
  }
  
  return body != null;
}


