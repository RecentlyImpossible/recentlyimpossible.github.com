

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

int releaseX;

PVector fPoint;

float floatH = 30;
float scaler;
float yScale;


int oW = 18;
int oH = 27;
int o1X = 247;
int o1Y = 165;
int o2X = 615;
int o2Y = 165;

boolean floating = true;
boolean spring =false;
boolean grabbed = false;
boolean oTunnel = false;
boolean pTunnel = false;
boolean shaking = false;

int shakeCount = 0;
int shakeDir = 1;

void setup() {
  size(900, 300);
  floatingPoint = loadImage("fp_logo_blank.jpg");
  scaler = width/ floatingPoint.width;
  yScale = floatingPoint.height*scaler;
  
  //fPoint = new PVector(pointXI, pointYI);
}

void draw() {
  //println("mX: "+mouseX+ " mY: "+mouseY);
  image(floatingPoint, 0, 0, width, height);

  noStroke();
  fill(50, 130, 50);

  ellipse(pointX, pointY, pointD, pointD);

  if (floating) {
    floatIt();
  }

  if (spring && !mousePressed) {
    grabbed=false;
    springback();
  }

  if (oTunnel) {
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
  }
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
    spring =false;
    floating = true;
  }

  if (pointD<=pointDT) {
    pointD+=1;
  }

  if (pointD>=pointDT) {
    pointD-=1;
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
}

void drawEllipse() {
  ellipse(100, 100, 100, 100);
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
shakeDir*=-1;
shakeCount--;
}
if(shakeCount==0){
pointXT=pointXI;
if(pointX==pointXT){
spring = false;
}
}
}

