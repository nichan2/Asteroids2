class Asteroids extends Floater  
{   
    public void setx(int x) {cenx = x;}
    public int getX() {return (int) cenx;}
    public void sety(int y) {ceny = y;}
    public int getY() {return (int) ceny;}
    public void setDirectionX(double x) {myDirectionX = x;}
    public double direcX() {return myDirectionX;}
    public void setDirectionY(double y) {myDirectionY = y;}
    public double direcy() {return myDirectionY;}
    public void setPointDirection(int degrees) {myPointDirection = degrees;}   
    public double getPointDirection() {return myPointDirection;} 
  protected int rotSpeed;
    private double x, y;
    private int AY, AX;
    public Asteroids()
    {   
        int variab = (int)(Math.random()*100);
        if(variab < 25) {AX = (int)(Math.random() * 800);}
        else if(variab < 50) {AX = (int)(Math.random() * 800); AY = 800;}
        else if(variab < 75) {AX = 0; AY = (int)(Math.random() * 800);}
        else {AX = 800; AY = (int)(Math.random() * 800);}
      
      corners = 12;
      cornerx = new int[corners];
      cornery = new int[corners];
      int[] xS = {2,5,10,8,10,3,-6,-7,-6,-9,-11,-8};
        int[] yS = {16,7,7,3,-10,-13,-10,-11,-3,0,4,18};
        cornerx = xS;
        cornery = yS;
      
        Colour = 76;
        Colour2=201;
        Colour3=240;
      ceny = 0 + AY;
      cenx = 0 + AX;
      myDirectionY = 0;
      myDirectionY = 0;
      myPointDirection = 0;
      rotSpeed = (int)(Math.random() * 11) -5;
        if(rotSpeed == 0) {if(Math.random() < 0.5) {rotSpeed = (int)(Math.random()*4) + 1;} else {rotSpeed = (int)(Math.random()*4) - 5;}}
        x = (Math.random() * 5) - 2;
        if(x == 0) {if(Math.random() < 0.5) {x = (Math.random()*2) + 1;} else {x = (Math.random()*2) - 3;}}
        y = (Math.random() * 5) - 2;
        if(y == 0) {if(Math.random() < 0.5) {y = (Math.random()*2) + 1;} else {y = (Math.random()*2) - 3;}}
        
        
    }
    public void move()
    {
    myPointDirection = myPointDirection + rotSpeed;
        setDirectionY(x);
        setDirectionX(y);
    super.move();

    }
}
Spaceship one = new Spaceship();
ArrayList<Asteroids> numAsteroids = new ArrayList<Asteroids>(); 
Stars[] starsNum = new Stars[100];
ArrayList<Bullet> numBullets = new ArrayList<Bullet>();
int numAsteroidsDestroyed = 0;
int health = 100;

public void setup() 
{
  size(800,800);
  background(0);
  //one = new Spaceship();
  for(int i = 0;i < starsNum.length; i++) {starsNum[i] = new Stars();}
  for(int i = 0; i < 20; i++) {numAsteroids.add(new Asteroids());}

}
public void draw() 
{
  background(0);
  for(int i = 0; i < starsNum.length; i++) {starsNum[i].show();}
  for(int i = 0; i < numAsteroids.size(); i++) {numAsteroids.get(i).show(); numAsteroids.get(i).move();}
   one.show();
   one.move();
  for(int i = 0; i < numAsteroids.size(); i++)
  {
    if(dist(numAsteroids.get(i).getX(),numAsteroids.get(i).getY(),one.getX(),one.getY()) < 25)
    {
      numAsteroids.remove(i);
      health=health-10;
    }
    for(int k = 0;k < numBullets.size(); k++)
  {
    numBullets.get(k).show();
    numBullets.get(k).move();
    if(dist(numAsteroids.get(i).getX(),numAsteroids.get(i).getY(),numBullets.get(k).getX(),numBullets.get(k).getY()) < 35)
    {
      numAsteroids.remove(i);
      numBullets.remove(k);
      numAsteroids.add(new Asteroids());
      numAsteroidsDestroyed++;
    }
  }
    
  }
  
 
}
public void keyPressed()
{
  if(key == 'h') //hyperspace
  {
    //System.out.println("nnn");
    one.setDirectionX(0);
    one.setDirectionY(0);
    one.setPointDirection((int)(Math.random()*360));
    one.setx((int)(Math.random()*800));
    one.sety((int)(Math.random()*800));

  }
  if(key == 'w') //accelerate
  {
    one.accelerate(0.5);
  }

  if(key == 'a') //turn left
  {
    one.turn(-15);
  }
  if(key == 'd') //turn right
  {
    one.turn(15);
  }
  if(key == ' ')
  {
    numBullets.add(new Bullet(one));
  }
}
class Bullet extends Floater
{
  public void setx(int x) {cenx = x;}
    public int getX() {return (int) cenx;}
    public void sety(int y) {ceny = y;}
    public int getY() {return (int) ceny;}
    public void setDirectionX(double x) {myDirectionX = x;}
    public double direcX() {return myDirectionX;}
    public void setDirectionY(double y) {myDirectionY = y;}
    public double direcy() {return myDirectionY;}
    public void setPointDirection(int degrees) {myPointDirection = degrees;}   
    public double getPointDirection() {return myPointDirection;} 
    protected int x,y = 0;
  Bullet(Spaceship theShip)
  {
    
    cenx = theShip.getX();
    ceny = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    double dRadians = myPointDirection*(Math.PI/180);
    myDirectionY = 5*Math.sin(dRadians) + theShip.direcy();
    myDirectionX = 5*Math.cos(dRadians) + theShip.direcX();
  }
  public void show()
  {
  stroke(247,37,133);
 
    fill(255,255,0);
    ellipse((float)cenx,(float)ceny,(float)5,(float)5);
  }
  public void move()
  {
    cenx += myDirectionX;    
      ceny += myDirectionY;
  }
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the Spaceship class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] cornerx;   
  protected int[] cornery;   
  protected int Colour; 
  protected int Colour2;
  protected int Colour3;
  protected double cenx, ceny; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setx(int x);  
  abstract public int getX();   
  abstract public void sety(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double direcX();   
  abstract public void setDirectionY(double y);   
  abstract public double direcy();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void turn (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    cenx += myDirectionX;    
    ceny += myDirectionY;     

    //wrap around screen    
    if(cenx >width)
    {     
      cenx = 0;    
    }    
    else if (cenx<0)
    {     
      cenx = width;    
    }    
    if(ceny >height)
    {    
      ceny = 0;    
    } 
    
    else if (ceny < 0)
    {     
      ceny = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(Colour,Colour2,Colour3);   
    stroke(Colour);    
    
    //translate the (x,y) center of the ship to the correct position
    translate((float)cenx, (float)ceny);

    //convert degrees to radians for rotate()     
    float dRadians = (float)(myPointDirection*(Math.PI/180));
    
    //rotate so that the polygon will be drawn in the correct direction
    rotate(dRadians);
    
    //draw the polygon
    beginShape();
    for (int nI = 0; nI < corners; nI++)
    {
      vertex(cornerx[nI], cornery[nI]);
    }
    endShape(CLOSE);

    //"unrotate" and "untranslate" in reverse order
    rotate(-1*dRadians);
    translate(-1*(float)cenx, -1*(float)ceny);
  }   
} 
class Spaceship extends Floater  
{   
    public void setx(int x) {cenx = x;}
    public int getX() {return (int) cenx;}
    public void sety(int y) {ceny = y;}
    public int getY() {return (int) ceny;}
    public void setDirectionX(double x) {myDirectionX = x;}
    public double direcX() {return myDirectionX;}
    public void setDirectionY(double y) {myDirectionY = y;}
    public double direcy() {return myDirectionY;}
    public void setPointDirection(int degrees) {myPointDirection = degrees;}   
    public double getPointDirection() {return myPointDirection;}

    public Spaceship()
    {
      corners = 4;
      cornerx = new int[corners];
      cornery = new int[corners];
      cornerx[0] = -8;
      cornery[0] = -8;
      cornerx[1] = 16;
      cornery[1] = 0;
      cornerx[2] = -8;
      cornery[2] = 8;
      cornerx[3] = -2;
      cornery[3] = 0;
      Colour = 181;
      Colour2= 23;
      Colour3=153;
      ceny = 400;
      cenx = 400;
      myDirectionY = 0;
      myDirectionY = 0;
      myPointDirection = 0;
    }
}
class Stars //note that this class does NOT extend Floater
{    
  protected int x,y;
  public Stars()
  {
    x = (int)(Math.random()*800);
    y = (int)(Math.random()*800);
  }
  public void show()
  {
    fill(255,255,255);
    ellipse(x,y,(int)(Math.random()*8),(int)(Math.random()*8));
    textSize(40);
    text("HP: "+health,10,40);
    text("Points: "+numAsteroidsDestroyed,10,90);
    if(health <= 0) {textSize(100);fill(255,0,0);text("Try Again",150,400);}

  }
}
