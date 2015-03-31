
int rad = 10;        // Width of the shapes
int vitesseSimu = 1;
float latc, latl, longc, longl;
LinearTrajectoire l;
CircleMovement c;

void setup()
{
  size(640, 640);
  frameRate(vitesseSimu);
  ellipseMode(RADIUS);
  background(0);
  l=new LinearTrajectoire(width-100, height-100, -10, -10) ;
  c = new CircleMovement(rad, 0.05, 0, 300, width/2, height/2);
}
void draw() 
{
  l.move();
  l.display();  
  c.move();
  c.display();
}

class LinearTrajectoire
{
  float xpos, ypos;    // Starting position of shape 
  float vx, vy;

  LinearTrajectoire(float xpos, float ypos, float vx, float vy)
  {
    this.xpos = xpos;
    this.ypos = ypos;
    this.vx = vx;
    this.vy = vy;
  } 

  void move()
  {
    xpos = xpos + vx;      
    ypos = ypos + vy;
    latl = xpos;
    longl = ypos;
  }
  void display()
  {
    ellipse(xpos, ypos, rad, rad);
  }
}


class CircleMovement { 
  int rad;        // Width of the shape
  float xpos, ypos;    // Starting position of shape
  float angularSpeed;
  int t;
  float teta0;
  float r;
  int decalageX;
  int decalageY;
  String[] list ;
  String words="";

  CircleMovement(int rad, float angularSpeed, float teta0, float r, int decalageX, int decalageY) {
    this.rad = rad;
    this.angularSpeed = angularSpeed;
    this.teta0 = teta0;
    this.r = r;
    this.decalageX = decalageX;
    this.decalageY = decalageY;
    
  }

  void move() {
    // Update the position of the shape
    t=t+5;
    xpos = decalageX + r*cos(angularSpeed*t + teta0);
    ypos = decalageY + r*sin(angularSpeed*t + teta0);
    latc =xpos;
    longc = ypos;
    float mesure = calculeAngle(latc, latl, longc, longl);
    float mesurebruitee = mesure+randomGaussian()*0.05;
    println("Mesure réele: "+mesure);
    println("Mesure bruitée: "+mesurebruitee);    
    println();
   
    words += mesurebruitee+" ";
    saveStrings("yolo.txt",mesurebruitee); 
    
    
  }

  void display()
  {
    ellipse(xpos, ypos, rad, rad);
  }
}

static float calculeAngle(float lat2, float lat1, float long2, float long1)
{  
  float dy = lat2 - lat1;
  float dx = long2- long1;
  return atan2(dy, dx);
}

