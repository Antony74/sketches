
Object world;
int SCALE = 30;

void setup()
{
  size(900,500);
  
  world = new Box2D.Dynamics.b2World(
       new Box2D.Common.Math.b2Vec2(0, 10) //gravity
    , true //allow sleep
   );
  
   var fixDef = new Box2D.Dynamics.b2FixtureDef();
   fixDef.density = 1.0;
   fixDef.friction = 0.5;
   fixDef.restitution = 0.2;
   
   var bodyDef = new Box2D.Dynamics.b2BodyDef();
  
   //create ground
   bodyDef.type = Box2D.Dynamics.b2Body.b2_staticBody;
   
   // positions the center of the object (not upper left!)
   bodyDef.position.x = width / 2 / SCALE;
   bodyDef.position.y = height / SCALE;
   
   fixDef.shape = new Box2D.Collision.Shapes.b2PolygonShape();
   
   // half width, half height. eg actual height here is 1 unit
   fixDef.shape.SetAsBox((600 / SCALE) / 2, (10/SCALE) / 2);
   world.CreateBody(bodyDef).CreateFixture(fixDef);
   //create some objects
   bodyDef.type = Box2D.Dynamics.b2Body.b2_dynamicBody;

   for(int i = 0; i < 150; ++i)
   {
    if(Math.random() > 0.5)
    {
       fixDef.shape = new Box2D.Collision.Shapes.b2PolygonShape();
       fixDef.shape.SetAsBox(
             Math.random() + 0.1 //half width
          , Math.random() + 0.1 //half height
       );
    }
    else
    {
       fixDef.shape = new Box2D.Collision.Shapes.b2CircleShape(
          Math.random() + 0.1 //radius
       );
    }

    bodyDef.position.x = Math.random() * 25;
    bodyDef.position.y = Math.random() * 10;
    world.CreateBody(bodyDef).CreateFixture(fixDef);
  }
}

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
     ellipse(b.GetPosition().x * SCALE, b.GetPosition().y * SCALE, 10, 10);
   }

}


