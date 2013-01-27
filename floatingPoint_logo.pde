
parasite[] paras = new parasite[10];

PFont fpFont;

PImage floatingPoint;
float pointXI = 655;
float pointYI = 125;
float pointX = pointXI;
float pointY = pointYI;
float pointXT = pointX;
float pointYT = pointY;
float ease = 1;
float speed = -.35;
float pointDI = 20;
float pointD =  pointDI;
float pointDT = pointD;

String theOs = "the Os are not what they seem";
int oAlpha =-500;
int oAlphaDir =1;

String[] names = {"Noah", "Jack", "Steve", "Gabriella", "Nick"}; 
String[] URLs = {
  "http://noahcrowley.com/",
  "http://portfolio.jackkalish.com/filter/featured/News",
  "http://skli.se/",
  "http://gabriellalevine.com/",
  "http://nysoundworks.org/"
};
  
fpLink[] links = new fpLink[5];


int releaseX;

PVector fPoint;

float floatH = 30;
float scaler;
float yScale;
float xScale;
int offsetX;


int oW = 18;
int oH = 27;
int o1X = 246;
int o1Y = 165;
int o2X = 615;
int o2Y = 165;

int alphaDir = 2;
int alphaT =0;

boolean floating = true;
boolean spring =false;
boolean grabbed = false;
boolean oTunnel = false;
boolean pTunnel = false;
boolean shaking = false;
boolean parasites = true;

int shakeCount = 0;
int shakeDir = 1;

void setup() {
  
  fpFont = loadFont("CenturyGothic-Italic-24.vlw");
  size(900, 300);
  
   for(int i = 0; i<5; i++){
  links[i] = new fpLink(names[i], URLs[i],170*i+100, height-20);
  }
  if(parasites){  
  for(int i = 0; i< paras.length; i++){
  paras[i] = new parasite();
  
  }
  }
  floatingPoint = loadImage("fp_logo_blank.jpg");


// scaler = float(height)/float(floatingPoint.height);
 scaler = float(300)/float(floatingPoint.height);
  xScale = floatingPoint.width*scaler;
  yScale = floatingPoint.height*scaler;
 // offsetX = (width - int(floatingPoint.width*scaler))/2;
  offsetX=0;
  
  
pointXI += offsetX;
pointX = pointXI;
pointXT = pointX;
o1X +=  offsetX;
o2X +=  offsetX;

  
  //fPoint = new PVector(pointXI, pointYI);
}

void draw() {
  //println("mX: "+mouseX+ " mY: "+mouseY);
  background(255);
  //image(floatingPoint, offsetX, 0, xScale, yScale);
image(floatingPoint, offsetX, 0, 900, 300);
  if (floating) {
    floatIt();
  }

  if (spring && !mousePressed) {
    grabbed=false;
    springback();
  }

  if (oTunnel) {
   //drawTunnel();
    if(abs(releaseX-o2X)<abs(releaseX-o1X)){
   Tunnel(o2X, o2Y, o1X, o1Y);
    }
    else 
     Tunnel(o1X, o1Y, o2X, o2Y);
    
    // Tunnel();
    //drawEllipse();
    //ellipse(100,100,100,100);
  }

  checkEdges();
  
   if (grabbed) {
    pointX = mouseX;
    pointY = mouseY;
    //drawTunnel();
  }
   
  drawPoint();
  drawLinks();
    if(parasites){
  drawParasites();
    }
  theOsAre();
}


void drawPoint(){
  noStroke();
  fill(50, 130, 50);
   ellipse(pointX, pointY, pointD, pointD);

}
void floatIt() {
  spring =false;
   shake();
  
  if(shakeCount == 0){ 
  pointY+=speed;
  if (pointY>pointYT || pointY< pointYT-floatH) {
    speed*=-1;
  }
  if (pointY==pointYT &&  pointX== pointXT) {
    speed=-.35;
  }
  }
}

void springback() {
  if(shakeCount>0){
   if (pointX!=pointXT) {
    pointX-=ease*(pointX-pointXT)/2;
  }
    
  }
  
  floating = false;
  if (pointY!=pointYT) {
    pointY-=ease*(pointY-pointYT)/8;
  }
  if (pointX!=pointXT) {
    pointX-=ease*(pointX-pointXT)/8;
  }

  if (abs(pointX-pointXT)<1) {
    pointX=pointXT;
  }

  if (abs(pointY-pointYT)<1) {
    pointY=pointYT;
  }

  if (pointY==pointYT && pointX == pointXT && oTunnel == false) {
    if(pointXT == pointXI || shakeCount>0){
    spring =false;
    floating = true;
    }
  }

  if (pointD<=pointDT) {
    pointD+=1;
  }

  if (pointD>=pointDT) {
    pointD-=1;
  }
}


void Tunnel() {
  floating = false;
  spring =true;
  if (pointDT==0 && abs(pointD-pointDT)<1) {
    pointXT= o1X;
    pointYT= o1Y;
    //pointDT = pointDI;
  }

  if (abs(pointX-o1X)<1) {
    pointDT = pointDI;
  }
  if (pointXT== o1X && pointDT == pointDI && abs(pointD-pointDT)<2) {
    pointXT= pointXI; 
    pointYT= pointYI;
  }

  if (pointXT == pointXI && abs(pointXT-pointX)<1) {
    oTunnel = false;
    floating = true;
  }
  //println("otunnel 2");
}

void Tunnel(int _x1, int _y1, int _x2, int _y2) {
    if(!pTunnel){
  //set D targ to 0 & position Targs to middle of 1st O
    pointDT = 0;
    pointXT= _x1;
    pointYT= _y1;
   
    floating = false;
    spring =true;
  pTunnel = true;  
  }
    
  //if it's shrunk and & centered in O set the target to the 2nd 0
  if (pointDT==0 && abs(pointD-pointDT)<1) {
    pointXT= _x2;
    pointYT= _y2;
    //pointDT = pointDI;
  }

//if we reach the 2nd O  make it big again 
  if (abs(pointX-_x2)<1) {
    pointDT = pointDI;
    
    //make the barasites visible
  
    for(int i = 0; i< paras.length; i++){
    paras[i].dT = 3;
     paras[i].onPoint = true;
    }
    
    
    
  }
  
  //if it's big again, move it back to the origin
  if (pointXT== _x2 && pointDT == pointDI && abs(pointD-pointDT)<2) {
    pointXT= pointXI; 
    pointYT= pointYI; 
  }

//if we get back to origin, end the tunnel function and float again
  if (pointXT == pointXI && abs(pointXT-pointX)<1) {
    oTunnel = false;
     pTunnel = false;
     shakeCount = 10;
    floating = true;
  }
  //println("otunnel 2");
}




void checkEdges() {

  if (pointX-pointD/2<0) {
    pointX=pointD/2;
    grabbed = false;
    spring = true;
    mousePressed = false;
  }
  if (pointY-pointD/2<0) {
    pointY=pointD/2;
     grabbed = false;
     spring = true;
     mousePressed = false;
  }

  if (pointX+pointD>width) {
    pointX=width-pointD/2;
     grabbed = false;
     spring = true;
     mousePressed = false;
  }

  if (pointY+pointD>height) {
    pointY=height-pointD/2;
     grabbed = false;
     spring = true;
     mousePressed = false;
 
  }
  if (mousePressed == true  && grabbed==false) {
    if (spring==true) {
      springback();
    }
  }
}


void shake(){
  
if(abs(pointXT-pointX)<1 && shakeCount>0){
spring = true;
pointXT = pointXI+shakeCount*shakeDir;
float _y = 2000*random(-3,2);
if(_y==0){
_y=1;
}
paras[shakeCount-1].buck(1000*shakeDir, _y);
shakeDir*=-1;

shakeCount--;
if(shakeCount == 1){
}
}
if(shakeCount==0){
pointXT=pointXI;
if(pointX==pointXT){
spring = false;
}
}
}

void drawLinks(){
  
  for(int i=0; i<5; i++){
    links[i].drawLink();
  
  }

  
}

void drawTunnel(){
alphaT+= alphaDir;

if(alphaT < 0 || alphaT> 255){
alphaDir*=-5;
//println(alphaDir);
//println(alphaT);
}

for(int i = 10; i>0 ; i--){
stroke(.001);
 noFill();
 stroke(255-25*i,alphaT);
  ellipse(o1X,o1Y, oW/7*i, oH/7*i);
   ellipse(o2X,o1Y, oW/7*i, oH/7*i);

}

}


void drawParasites(){
for(int i = 0; i< paras.length; i++){

  paras[i].draw();

}

}

void theOsAre(){
  
  if(oAlpha>0){
  textFont(fpFont,18);
  fill(210,oAlpha);
  text(theOs, 100,30);
  }
oAlpha+=oAlphaDir;

if(oAlpha > 255 || oAlpha <-1200){
oAlphaDir*=-1;
}

}
void mouseDragged() {
  //if(mouseX>=pointX-pointD/2 && mouseX<=pointX+pointD/2 && mouseY<=pointY+pointD/2 && mouseY>=pointY-pointD/2){
  if (abs(mouseX-pointX)<pointD/2 &&abs(mouseY-pointY)<pointD/2) {
    floating = false;
   // spring=true;
    grabbed = true;
    
    pointX = mouseX;
    pointY = mouseY;
    
  }
 
 if (grabbed) {
    spring = false;
    pointX = mouseX;
    pointY = mouseY;
  }

  if (mouseX<0 || mouseX>width || mouseY<0 || mouseY>height) {
    grabbed=false;
    spring = true;
  }

  

  if (spring==true) {
    springback();
  }
}

void mouseMoved(){
  

  
if(!mousePressed){
  grabbed=false;
    spring = true;
  }

}


void mouseReleased() {
  
 if(grabbed){
 grabbed = false;
 spring = true;
 }
 
 if (abs(pointX-o1X)<oW/2 && abs(pointY-o1Y)<oH/2) {
   releaseX = mouseX;
  oTunnel = true;
  spring = false;
   
 }
 
  if (abs(pointX-o2X)<oW/2 && abs(pointY-o2Y)<oH/2) {
     releaseX = mouseX;
    oTunnel = true;
    spring = false;
   // pointDT = 0;
    //pointXT= o2X;
    //pointYT= o2Y;
  }
  
  for(int i = 0; i<5; i++){
  links[i].checkPoint(i);
  }
}

class fpLink {

  String name;
  String url;
  float xPos;
  float yPos;

  PVector v1a; 
  PVector v1b; 

  PVector v1T; 
  PVector v2;
  PVector v3;
  PVector v4;
  PVector boxC;

  int releaseCounter;

  float rot1 = 0;
  float rot1T = rot1;
  
  int linkCol = 180;
  int boxOS = 30;
  int boxW = 20;

  boolean isOpen = false;
  boolean hasPoint = false;
  boolean linkOpened = false;


  fpLink(String _name, String _url, float _x, float _y) {

    name = _name;
    url= _url;
    xPos = _x;
    yPos = _y;

    v1a = new PVector(xPos-boxOS, yPos-boxW);
    v1b = new PVector(xPos-boxOS+boxW/2, yPos-boxW);
    v1T = new PVector(xPos-boxOS, yPos-boxW);
    v2 = new PVector(xPos-boxOS, yPos);
    v3 = new PVector(xPos-boxOS+boxW, yPos);
    v4 = new PVector(xPos-boxOS+boxW, yPos-boxW);

    boxC = new PVector(v1b.x, (v3.y+v1a.y)/2);
  }


  void drawLink() {
    
    
    if(hasPoint){
    linkCol =80;
    }
    
    fill(linkCol);
    textFont(fpFont, 18);
    text(name, xPos, yPos);
    noFill();
    stroke(linkCol);
    strokeWeight(2);
    line(v1a.x, v1a.y, v2.x, v2.y);
    line(v2.x, v2.y, v3.x, v3.y);
    line(v3.x, v3.y, v4.x, v4.y);

    pushMatrix();
    translate(v1a.x, v1a.y);
    rotate(radians(-rot1));
    line(0, 0, 10, 0);
    popMatrix();

    pushMatrix();
    translate(v4.x, v4.y);
    rotate(radians(rot1));
    line(0, 0, -10, 0);
    popMatrix();

    
    update();
  }


  void openLid() {
    rot1T = 90;
    isOpen = true;
  }

  void closeLid() {
    rot1T = 0;
    isOpen = false;
  }

  void update() {
    if (rot1 < rot1T) {
      rot1+=2;
    }
    if (rot1 > rot1T) {
      rot1-=2;
    }

if(grabbed){
openLid();
releaseCounter =0;
linkOpened = false;
hasPoint = false;
pointXT = pointXI;
        pointYT = pointYI;
 
}

    if(!hasPoint){
    linkCol = 180;
    }

    if (hasPoint) {
      if (releaseCounter == 0) {
        pointXT = pointXI;
        pointYT = pointYI;
        hasPoint = false;
        linkOpened = false;
    
       
      }
      else releaseCounter--;
      
      if(releaseCounter>150){
        closeLid();
      }
      
      if(releaseCounter == 150){
       openLid();
      }
      
      if(releaseCounter == 50){
      
        pointYT -=50;
      }
      
    }
     if(!grabbed && isOpen && !hasPoint){
 closeLid();
     }
     
    if(grabbed && !isOpen){
  openLid();
    }
    
  }

  void checkPoint(int _i) {
    if (abs(pointX-boxC.x)<pointD/2 && abs(pointY-boxC.y)<pointD/2 && !linkOpened) {
      //println( "link"+_i);
      
      link(url, "_blank");
      linkOpened = true;
      pointXT = boxC.x;
      pointYT = boxC.y;
      floating = false;
      hasPoint = true;
      releaseCounter = 500;
    }
  }

  //endclass
}



class parasite{

float x, y, xT, yT, xO, yO;

float d;
float dT=d;
color col;
boolean onPoint = false;
boolean onScreen = false;

parasite(){
x=0;
y=0;
d=0;
xO = random(-pointD/4, pointD/4);
yO = random(-pointD/4, pointD/4);

col = color(random(130,240),random(100,160),random(50,100));
//println(col);

}

void draw(){
  fill(col);
  noStroke();
  ellipse(x,y,d,d);
update();
}

void update(){
  if(onPoint){
    onScreen = true;
  x=pointX-xO+random(-1,1);
  y=pointY-yO+random(-1,1);
  dT=5;
  }
  
if(d<dT){
d+=.1;
}

if(x<xT){
x+=5;
}
if(x>xT){
x-=5;
}

if(y<yT){
y+=5;
}
if(y>yT){
y-=5;
}


}

void buck(float _x,float _y){
xT=_x;
yT =_y;
onPoint =false;
}



//end class
}



