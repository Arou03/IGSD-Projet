PShape head, body, hands, hand, eye1, eye2, eyeball1,eyeball2, mommie, main1, main2,pyramid;



int iposX = 1;
int iposY = -1;

boolean outlab=true;
boolean out= false;

int posX = iposX;
int posY = iposY;

int dirX = 0;
int dirY = 1;
int odirX = 0;
int odirY = 1;
int WALLD = 1;

int anim = 0;
boolean animT=false;
boolean animR=false;

boolean inLab = true;

int LAB_SIZE = 21;
//int todig = 0;
char labyrinthe [][][];
boolean deplace [][][];
char sides [][][][];

float wallW ;
float wallH ;
//int mx=LAB_SIZE-1;
//int my=LAB_SIZE-2;     //coordonées de la mommie
int mx=1;
int my= 1;
int dx=0;
int dy=1;   


int count1=1;
int count2=1;

int currentFloor = 0;

PImage  texture0;
PImage  texture1;
PImage img;

void setup() { 
  pixelDensity(2);
  randomSeed(2);
  
  // creation de ma 
  Mommie();
  
  texture0 = loadImage("stones.jpg");
  texture1 = loadImage ("sol.jpg");
  img= loadImage("sky.jpg");
  
  //pyra();
  //size(1000, 1000, P3D);
  size(600, 600, P3D);
  labyrinthe = new char[LAB_SIZE/2-1][LAB_SIZE][LAB_SIZE];
  sides = new char[LAB_SIZE/2-1][LAB_SIZE][LAB_SIZE][4];
  deplace = new boolean[LAB_SIZE/2-1][LAB_SIZE][LAB_SIZE];
  laby0 = new PShape[LAB_SIZE/2-1];
  laby1 = new PShape[LAB_SIZE/2-1];
  ceiling0 = new PShape[LAB_SIZE/2-1];
  ceiling1 = new PShape[LAB_SIZE/2-1];
  sand();
  
  pyramide();
  
  int j = 0;
  for(int i = 5; i <= LAB_SIZE; i+=2) {
    //drawLaby(j, i);
    Laby(j, i);
    println(i + ", " + j);
    j++;
  }
  
}

void draw() {
  //background(192);
  sphereDetail(6);
  if (anim>0) anim--; 
  
  perspective();
  img.resize(width,height);
  background(img);
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  noLights();
  stroke(0);
  //drawMiniMap((currentFloor+2)*2+1, currentFloor);
  setCamera(LAB_SIZE);
  for(int i = 0; i < 9; i++)
  lightLaby(i,i*2+5);
  //Laby(currentFloor,(currentFloor+2)*2+1);  
  bougeMommie((currentFloor+2)*2+1,currentFloor);
  //shape(pyramide);
}

void keyPressed() {
  if (key=='l') inLab = !inLab;
  if(key=='f') outlab=false;
  if(key=='o') {
      outlab=true;
      out=true;
      posX=1;
      posY=0;
      dirX = 0;
      dirY = 1;
  }

  if (anim==0 && keyCode==38) {
    if (posX+dirX>=0 && posX+dirX<LAB_SIZE && posY+dirY>=0 && posY+dirY<LAB_SIZE &&
      labyrinthe[currentFloor][posY+dirY][posX+dirX]!='#') {
      posX+=dirX; 
      posY+=dirY;
      anim=20;
      animT = true;
      animR = false;
      //deplace[posY+dirY][posX+dirX]
      //mx=posX;
      //my=posY;
      
    }
  }
  if(keyCode==38 && outlab){
    posX+=dirX; 
    posY+=dirY;
  }
  //println("position après une touche up : coordonée en X " +posX +" ,coordonée en Y " + posY);
  if(inLab && !outlab){
  if (anim==0 && keyCode==40 && labyrinthe[currentFloor][posY-dirY][posX-dirX]!='#') {
    posX-=dirX; 
    posY-=dirY;
    //mx=posX;
    //my=posY;
    
  }
  }
  if(keyCode==40 && outlab){
    posX-=dirX; 
    posY-=dirY; 
  }
  //println("Position après une touche down : coordonée en X " +posX +" ,coordonée en Y " + posY);
  if (anim==0 && keyCode==37) {
    odirX = dirX;
    odirY = dirY;
    anim = 20;
    int tmp = dirX; 
    dirX=dirY; 
    dirY=-tmp;
    animT = false;
    animR = true;
    
  }
  //println("Pösition après une touche gauche : coordonée en X " +posX +" ,coordonée en Y " + posY);
  if (anim==0 && keyCode==39) {
    odirX = dirX;
    odirY = dirY;
    anim = 20;
    animT = false;
    animR = true;
    int tmp = dirX; 
    dirX=-dirY; 
    dirY=tmp;
    
  }
  if (keyCode==32 && inLab && labyrinthe[currentFloor][posY][posX] =='s') {
    posX = 1;
    posY = 0;
    mx=1;
    my=1;
    dx=0;
    dy=0;
    dirX = 0;
    dirY = 1;
    currentFloor++; 
  } 
  //println("Position après une touche droit : coordonée en X " +posX +" ,coordonée en Y " + posY);
}



  
