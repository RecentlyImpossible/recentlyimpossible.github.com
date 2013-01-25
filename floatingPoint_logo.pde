

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

void setup(){
size(900,300);
 floatingPoint = loadImage("fp_logo_blank.jpg");
  
  scaler = width/ floatingPoint.width;
  yScale = floatingPoint.height*scaler;
}

void draw(){
  
  
//println("mX: "+mouseX+ "mY: "+mouseY);
image(floatingPoint,0,0, width, height);

noStroke();
fill(50,130,50);

ellipse(pointX,pointY,pointD,pointD);

if(floating){
floatIt();
}

if(spring && !mousePressed){
grabbed=false;
  springback();
}

if(oTunnel){
 oTunnel();
}

}

void floatIt(){
  spring =false;
pointY+=speed;
if(pointY>pointYT || pointY< pointYT-floatH){
speed*=-1;
}
if(pointY==pointYT &&  pointX== pointXT){
speed=-.35;
}
}

void springback(){
if(pointY!=pointYT){
  pointY-=ease*(pointY-pointYT)/8;
}
if(pointX!=pointXT){
  pointX-=ease*(pointX-pointXT)/8;
}

if(abs(pointX-pointXT)<2){
pointX=pointXT;
}

if(abs(pointY-pointYT)<2){
pointY=pointYT;
}

if(pointY==pointYT && pointX == pointXT){
spring =false;
floating = true;
}

if(pointD<=pointDT){
pointD+=1;
}

if(pointD>=pointDT){
pointD-=1;
}
  
}

void mouseDragged(){
 floating = false;
  spring=true;
  
//if(mouseX>=pointX-pointD/2 && mouseX<=pointX+pointD/2 && mouseY<=pointY+pointD/2 && mouseY>=pointY-pointD/2){
if(abs(mouseX-pointX)<pointD/2 &&abs(mouseY-pointY)<pointD/2){
  
  grabbed = true;
  pointX = mouseX;
pointY = mouseY;

}
if(grabbed){
pointX = mouseX;
pointY = mouseY;
}


}

void mouseReleased(){
  
if(abs(pointX-o2X)<oW/2 && abs(pointY-o2Y)<oH/2){
 oTunnel = true;
 pointDT = 0;
pointXT= o2X;
pointYT= o2Y;

}
}

void oTunnel(){
floating = false;
spring =true;
 


if(pointDT==0 && abs(pointD-pointDT)<1){
pointXT= o1X;
pointYT= o1Y;
//pointDT = pointDI;
}

if(abs(pointX-o1X)<1){
  pointDT = pointDI;  
  
}
if(pointXT== o1X && pointDT == pointDI && abs(pointD-pointDT)<2){
  pointXT= pointXI; 
  pointYT= pointYI;
 
  }
  
 if(pointXT == pointXI && abs(pointXT-pointX)<1){
  oTunnel = false;
 floating = true;
 }

  
//println("otunnel 2");  
  
}

