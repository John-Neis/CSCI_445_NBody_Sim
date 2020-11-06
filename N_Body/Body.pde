public class Body
{
  public PVector pos, apogee_v, perigee_v;
  public float Mass, apogee, perigee;
  public float radius;
  
  public float vec_x, vec_y, vec_z;
  public float acc_x, acc_y, acc_z;
  
  Body(float x, float y, float z, float Mass)
  {
    apogee = Float.MIN_VALUE; apogee_v = new PVector(0, 0, 0);
    perigee = Float.MAX_VALUE; perigee_v = new PVector(0, 0, 0);
    
    pos = new PVector(x, y, z);
    this.Mass = Mass;
    this.radius = Mass / 10;
  }
  
  public void Update()
  {
    pos.x += vec_x; vec_x += acc_x;
    pos.y += vec_y; vec_y += acc_y;
    pos.z += vec_z; vec_z += acc_z;
  }
  
  public void SetAccel(float x, float y, float z)
  {
    acc_x = x;
    acc_y = y;
    acc_z = z;
  }
  
  public void Show()
  {
    ellipse(pos.x, pos.y, radius, radius);
  }
  
  public PVector GetPos()
  {
    return pos;
  }
}
