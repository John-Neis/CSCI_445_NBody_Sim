final int width  = 1000;
final int height = 1000;
final float GRAVITATION = 6.674e-5;

Body bodies[];

void setup()
{
  bodies = new Body[2];
  bodies[0] = new Body(width / 4, height / 2, 0, 200);
  bodies[0].vec_x = 0.0; bodies[0].vec_y = -0.16;
  
  bodies[1] = new Body(width / 2, height / 2, 0, 800);
  bodies[1].vec_x = 0.0; bodies[1].vec_y = 0.04;
  
  //System.out.println(sqrt(4 * GRAVITATION / 5));
  
  /*bodies[2] = new Body(width / 2, height / 2, 0, 400);
  bodies[2].vec_x = 0.0; bodies[2].vec_y = 0.0;
  
  bodies[3] = new Body(3 * width / 4, 3 * height / 4, 0, 10);
  bodies[3].vec_x = -0.08; bodies[3].vec_y = 0.08;
  
  bodies[4] = new Body(width / 4, 3 * height / 4, 0, 10);
  bodies[4].vec_x = -0.08; bodies[4].vec_y = -0.08;*/
  
  frameRate(240);
  size(1000, 1000);
  background(0);
}

void draw()
{ 
  background(0);
  fill(255);
  stroke(255);
  
  for(int i = 0; i < bodies.length; i++)
  {
    bodies[i].Update();
    bodies[i].Show();
  }
  //CheckMinMax();
  
  CalculateForces();
}

void CalculateForces()
{
  PVector r, acceleration;
  r = new PVector(0, 0);
  acceleration = new PVector(0, 0);
  float mag_r = 0.0;
  
  for(int i = 0; i < bodies.length; i++) 
  {
    for(int j = 0; j < bodies.length; j++)
    {
      if(i != j)
      {
        r.x = bodies[j].pos.x - bodies[i].pos.x;
        r.y = bodies[j].pos.y - bodies[i].pos.y;
        
        mag_r = sqrt(r.x * r.x + r.y * r.y);
        
        acceleration.x += (GRAVITATION * bodies[j].Mass / mag_r) * (r.x / mag_r);
        acceleration.y += (GRAVITATION * bodies[j].Mass / mag_r) * (r.y / mag_r);
      }
    }
    bodies[i].acc_x = acceleration.x;
    bodies[i].acc_y = acceleration.y;
    acceleration.x = 0;
    acceleration.y = 0;
    
    //System.out.printf("Body: %d | x = %f,  y = %f,  z = %f\n", i + 1, bodies[i].pos.x, bodies[i].pos.y, bodies[i].pos.z);
    //System.out.printf("          vx = %f, vy = %f, vz = %f\n", bodies[i].vec_x, bodies[i].vec_y, bodies[i].vec_z);
    //System.out.printf("          ax = %f, ay = %f, az = %f\n\n", bodies[i].acc_x, bodies[i].acc_y, bodies[i].acc_z);
  }
}

void CheckMinMax()
{
  float r_x, r_y, mag_r;
  r_x = bodies[1].pos.x - bodies[0].pos.x;
  r_y = bodies[1].pos.y - bodies[0].pos.y;
  mag_r = sqrt(r_x * r_x + r_y * r_y);
  
  if(bodies[0].perigee > mag_r)
  {
    bodies[0].perigee = mag_r;
    bodies[0].perigee_v.x = bodies[0].pos.x;
    bodies[0].perigee_v.y = bodies[0].pos.y;
  }
  
  if(bodies[0].apogee < mag_r)
  {
    bodies[0].apogee = mag_r;
    bodies[0].apogee_v.x = bodies[0].pos.x;
    bodies[0].apogee_v.y = bodies[0].pos.y;
  }
  
  r_x = bodies[1].pos.x - bodies[2].pos.x;
  r_y = bodies[1].pos.y - bodies[2].pos.y;
  mag_r = sqrt(r_x * r_x + r_y * r_y);
  
  if(bodies[2].perigee > mag_r)
  {
    bodies[2].perigee = mag_r;
    bodies[2].perigee_v.x = bodies[2].pos.x;
    bodies[2].perigee_v.y = bodies[2].pos.y;
  }
  
  if(bodies[2].apogee < mag_r)
  {
    bodies[2].apogee = mag_r;
    bodies[2].apogee_v.x = bodies[2].pos.x;
    bodies[2].apogee_v.y = bodies[2].pos.y;
  }
  
  fill(255, 0, 0);
  ellipse(bodies[0].perigee_v.x, bodies[0].perigee_v.y, 20, 20);
  ellipse(bodies[2].perigee_v.x, bodies[2].perigee_v.y, 20, 20);
  
  fill(0, 255, 0);
  ellipse(bodies[0].apogee_v.x, bodies[0].apogee_v.y, 20, 20);
  ellipse(bodies[2].apogee_v.x, bodies[2].apogee_v.y, 20, 20);
}
