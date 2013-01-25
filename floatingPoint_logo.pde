

PImage floatingPoint;
float pointX = 655;
float pointY = 125;
float pointXT = pointX;
float pointYT = pointY;
float ease = 1;
float speed = -.35;
int pointD = 20;
float floatH = 30;
float scaler;
float yScale;

boolean spring =false;
boolean grabbed = false;

void setup(){
size(900,300);
 floatingPoint = loadImage("fp_logo_blank.jpg");
  
  scaler = width/ floatingPoint.width;
  yScale = floatingPoint.height*scaler;
}

void draw(){
image(floatingPoint,0,0, width, height);

noStroke();
fill(50,130,50);

ellipse(pointX,pointY,pointD,pointD);

if(!grabbed){
floatIt();
}

if(spring && !mousePressed){
grabbed=false;
  springback();


}
}

void floatIt(){
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
  pointY-=ease*(pointY-pointYT)/5;
}
if(pointX!=pointXT){
  pointX-=ease*(pointX-pointXT)/5;
}

if(abs(pointX-pointXT)<2){
pointX=pointXT;
}

if(abs(pointY-pointYT)<2){
pointY=pointYT;
}

if(pointY==pointYT && pointX == pointXT){
spring =false;
grabbed=false;
}

  
}

void mouseDragged(){
  
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

