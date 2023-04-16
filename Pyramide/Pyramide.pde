int iposX = 1;
int iposY = 0;

int posX = iposX;
int posY = iposY;

//coord en temps réel de la caméra pour avoir une lumière plus smooth lors des déplacement
float cX;
float cY;
float cZ;

//mode spectateur
float spectX = 0;
float spectY = 0;
float spectZ = 0;

float centerX;
float centerY;
float centerZ;

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

float wallW;
float wallH;

PImage texture0;
PImage texture1;
PImage texture2;
PImage texture3;
PImage texture4;

int currentFloor = 0;


void setup() { 
  pixelDensity(2);
  randomSeed(2);
  
  texture0 = loadImage("stones.jpg");
  texture1 = loadImage("sortie.jpg");
  texture2 = loadImage("stones_exterior.jpg");
  texture3 = loadImage("sable.jpg");
  texture4 = loadImage("boussole.png");
  size(1000, 1000, P3D);
  
  wallW = width/LAB_SIZE;
  wallH = height/LAB_SIZE;
  
  initDirection();
  initMomie();
  initExterieur();
  exterieur.translate(-wallW/2.0 - wallW, -wallH/2.0 - wallH, -((wallH+wallW)/2));
  
  labyrinthe = new char[LAB_SIZE/2-1][LAB_SIZE][LAB_SIZE];
  sides = new char[LAB_SIZE/2-1][LAB_SIZE][LAB_SIZE][4];
  laby0 = new PShape[LAB_SIZE/2-1];
  ceiling0 = new PShape[LAB_SIZE/2-1];
  ceiling1 = new PShape[LAB_SIZE/2-1];
  sortie = new PShape[LAB_SIZE/2-1];
  int j = 0;
  for(int i = 5; i <= LAB_SIZE; i+=2) {
    initPyramide(j, i);
    j++;
  }
}

void drawMiniMap(int SIZE, int etage) {
  wallW = width/SIZE;
  wallH = height/SIZE;
  for (int j=0; j<SIZE; j++) {
    for (int i=0; i<SIZE; i++) {
      if (labyrinthe[etage][j][i]=='#') {
        fill(i*25, j*25, 255-i*10+j*10);
        pushMatrix();
        translate(((wallH+wallW)/2)+i*wallW/8, ((wallH+wallW)/2)+j*wallH/8, ((wallH+wallW)/2));
        box(wallW/10, wallH/10, 5);
        popMatrix();
      }
    }
  }
  pushMatrix();
  fill(0, 255, 0);
  noStroke();
  translate(((wallH+wallW)/2)+posX*wallW/8, ((wallH+wallW)/2)+posY*wallH/8, ((wallH+wallW)/2));
  sphere(3);
  popMatrix();
  
  //Momie mini-map
  pushMatrix();
  fill(255, 255, 0);
  noStroke();
  translate(((wallH+wallW)/2)+mX*wallW/8, ((wallH+wallW)/2)+mY*wallH/8, ((wallH+wallW)/2));
  sphere(3);
  popMatrix();
}

void drawLaby(int SIZE, int etage) {
  //int Hauteur = LAB_SIZE * ((wallH+wallW)/2);
  int Hauteur = 0;
  wallW = width/LAB_SIZE;
  wallH = height/LAB_SIZE;
  for (int j=0; j<SIZE; j++) {
    for (int i=0; i<SIZE; i++) {
      pushMatrix();
      translate(i*wallW, j*wallH, 0 + Hauteur);
      if (labyrinthe[etage][j][i]=='#') {
        beginShape(QUADS);
        if (sides[etage][j][i][3]==1) {
          pushMatrix();
          translate(0, -wallH/2, 40 + Hauteur);
          if ((i==posX && j - posY < 4) || (j==posY && j - posX < 4)) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            sphere(15);
          }
          popMatrix();
        }

        if (sides[etage][j][i][0]==1) {
          pushMatrix();
          translate(0, wallH/2, 40 + Hauteur);
          if ((i==posX && j - posY < 4) || (j==posY && j - posX < 4)) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            sphere(15);
          }
          popMatrix();
        }
         
         if (sides[etage][j][i][1]==1) {
          pushMatrix();
          translate(-wallW/2, 0, 40 + Hauteur);
          if ((i==posX && j - posY < 4) || (j==posY && j - posX < 4)) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            sphere(15);
          }
          popMatrix();
        }
         
        if (sides[etage][j][i][2]==1) {
          pushMatrix();
          translate(0, wallH/2, 40 + Hauteur);
          if ((i==posX && j - posY < 4) || (j==posY && j - posX < 4)) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            sphere(15);
          }
          popMatrix();
        }
      } 
      popMatrix();
    }
  }
  shape(sortie[etage], 0, 0);
  shape(laby0[etage], 0, 0);
  if (inLab)
    shape(ceiling0[etage], 0, 0);
  //else shape(ceiling1, 0, 0);
  /**
  if (currentFloor == (LAB_SIZE - 5)/2) {
    shape(Pyramide);
  }
  **/
}

void drawMomie() {
  pushMatrix();
  translate(0, 0, -((wallH+wallW)/2));
  shape(momie, mX * wallW, mY * wallH);
  popMatrix();
}

void drawExterieur() {
  pushMatrix();
  translate(wallW, wallH, 0);
  shape(exterieur);
  popMatrix();
}

void draw() {
  background(135, 206, 235);
  sphereDetail(6);
  if (anim>0) anim--;
  else if (anim<0) anim++;
  
  perspective();
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  //noLights();
  stroke(0);
  drawMiniMap((currentFloor)*2+5, currentFloor);
  setupCam(21);
  drawLaby((currentFloor)*2+5,currentFloor);
  drawMomie();
  if (currentFloor == 8) shape(exterieur);
  
  drawBoussole();
}

void mouvementMomie() {
  int i;
  if(mY == 0 && mX == 1) {
    dxMomie = 0;
    dyMomie = 1;
    momie.resetMatrix();
  }
  if(mY == (LAB_SIZE - (LAB_SIZE - ((currentFloor)*2+5)) - 2) && mX == (LAB_SIZE - (LAB_SIZE - ((currentFloor)*2+5))) - 1) {
    dxMomie = -1;
    dyMomie = 0;
  } else {
    while (labyrinthe[currentFloor][mY + dyMomie][mX + dxMomie]=='#') {
      i = (int) random(0, 4);
      dxMomie = dir[i][0];
      dyMomie = dir[i][1];
      momie.resetMatrix();
      if(dyMomie == -1)momie.rotateZ(PI);
      if(dxMomie == 1)momie.rotateZ(-HALF_PI);
      if(dxMomie == -1)momie.rotateZ(HALF_PI);
    }
    
  }
  mX += dxMomie;
  mY += dyMomie;
}
