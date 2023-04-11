int iposX = 1;
int iposY = -1;

int posX = iposX;
int posY = iposY;
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
char[][][] labyrinthe ;
char[][][][] sides ;

PShape laby0[];
PShape ceiling0[];
PShape ceiling1[];

float wallW;
float wallH;

PImage  texture0;

int currentFloor = 0;

void setup() { 
  pixelDensity(2);
  randomSeed(2);
  texture0 = loadImage("stones.jpg");
  size(1000, 1000, P3D);
  labyrinthe = new char[LAB_SIZE/2-1][LAB_SIZE][LAB_SIZE];
  sides = new char[LAB_SIZE/2-1][LAB_SIZE][LAB_SIZE][4];
  laby0 = new PShape[LAB_SIZE/2-1];
  ceiling0 = new PShape[LAB_SIZE/2-1];
  ceiling1 = new PShape[LAB_SIZE/2-1];
  int j = 0;
  for(int i = 5; i <= LAB_SIZE; i+=2) {
    initPyramide(j, i);
    println(i + ", " + j);
    j++;
  }
}

void initPyramide(int etage, int SIZE) {
  int todig = 0;
  for (int j=0; j<SIZE; j++) {
    for (int i=0; i<SIZE; i++) {
      sides[etage][j][i][0] = 0;
      sides[etage][j][i][1] = 0;
      sides[etage][j][i][2] = 0;
      sides[etage][j][i][3] = 0;
      if (j%2==1 && i%2==1) {
        labyrinthe[etage][j][i] = '.';
        todig ++;
      } else
        labyrinthe[etage][j][i] = '#';
    }
  }
  int gx = 1;
  int gy = 1;
  while (todig>0 ) {
    int oldgx = gx;
    int oldgy = gy;
    int alea = floor(random(0, 4)); // selon un tirage aleatoire
    if      (alea==0 && gx>1)          gx -= 2; // le fantome va a gauche
    else if (alea==1 && gy>1)          gy -= 2; // le fantome va en haut
    else if (alea==2 && gx<SIZE-2) gx += 2; // .. va a droite
    else if (alea==3 && gy<SIZE-2) gy += 2; // .. va en bas

    if (labyrinthe[etage][gy][gx] == '.') {
      todig--;
      labyrinthe[etage][gy][gx] = ' ';
      labyrinthe[etage][(gy+oldgy)/2][(gx+oldgx)/2] = ' ';
    }
  }
  labyrinthe[etage][0][1]                   = ' '; // entree
  labyrinthe[etage][SIZE-2][SIZE-1] = 's'; // sortie

  for (int j=1; j<SIZE-1; j++) {
    for (int i=1; i<SIZE-1; i++) {
      if ((labyrinthe[etage][j][i]==' ' || labyrinthe[etage][j][i]=='s')) {
        if (labyrinthe[etage][j-1][i]=='#' && (labyrinthe[etage][j+1][i]==' ' || labyrinthe[etage][j+1][i]=='s') &&
          labyrinthe[etage][j][i-1]=='#' && labyrinthe[etage][j][i+1]=='#')
          sides[etage][j-1][i][0] = 1;// c'est un bout de couloir vers le haut 
        if ((labyrinthe[etage][j-1][i]==' ' || labyrinthe[etage][j-1][i]=='s')  && labyrinthe[etage][j+1][i]=='#' &&
          labyrinthe[etage][j][i-1]=='#' && labyrinthe[etage][j][i+1]=='#')
          sides[etage][j+1][i][3] = 1;// c'est un bout de couloir vers le bas 
        if (labyrinthe[etage][j-1][i]=='#' && labyrinthe[etage][j+1][i]=='#' &&
          (labyrinthe[etage][j][i-1]==' ' || labyrinthe[etage][j][i-1]=='s') && labyrinthe[etage][j][i+1]=='#')
          sides[etage][j][i+1][1] = 1;// c'est un bout de couloir vers la droite
        if (labyrinthe[etage][j-1][i]=='#' && labyrinthe[etage][j+1][i]=='#' &&
          labyrinthe[etage][j][i-1]=='#' && (labyrinthe[etage][j][i+1]==' ' || labyrinthe[etage][j][i+1]=='s'))
          sides[etage][j][i-1][2] = 1;// c'est un bout de couloir vers la gauche
      }
    }
  }

  // un affichage texte pour vous aider a visualiser le labyrinthe en 2D
  for (int j=0; j<SIZE; j++) {
    for (int i=0; i<SIZE; i++) {
      print(labyrinthe[etage][j][i]);
    }
    println("");
  }
  
  float wallW = width/LAB_SIZE;
  float wallH = height/LAB_SIZE;

  ceiling0[etage] = createShape();
  ceiling1[etage] = createShape();
  
  ceiling1[etage].beginShape(QUADS);
  ceiling0[etage].beginShape(QUADS);
  
  laby0[etage] = createShape();
  laby0[etage].beginShape(QUADS);
  laby0[etage].texture(texture0);
  laby0[etage].noStroke();
  //laby0.stroke(255, 32);
  //laby0.strokeWeight(0.5);
  
  for (int j=0; j<SIZE; j++) {
    for (int i=0; i<SIZE; i++) {
      if (labyrinthe[etage][j][i]=='#') {
        
        laby0[etage].fill(i*25, j*25, 255-i*10+j*10);
        if (j==0 || (labyrinthe[etage][j-1][i]==' ' || labyrinthe[etage][j-1][i]=='s') ) {
          laby0[etage].normal(0, -1, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              //float d1 = 15*(noise(0.3*(i*WALLD+(k+0)), 0.3*(j*WALLD), 0.3*(l+0))-0.5);
              //if (k==0)  d1=0;
              //if (l==-WALLD) d1=-2*abs(d1);
              laby0[etage].vertex(i*wallW-wallW/2+(k+0)*wallW/WALLD, j*wallH-wallH/2, (l+0)*50/WALLD, k/(float)WALLD*texture0.width, (0.5+l/2.0/WALLD)*texture0.height);
              
              //float d2 =15*(noise(0.3*(i*WALLD+(k+1)), 0.3*(j*WALLD), 0.3*(l+0))-0.5);
              //if (k+1==WALLD ) d2=0;
              //if (l==-WALLD) d2=-2*abs(d2);
              laby0[etage].vertex(i*wallW-wallW/2+(k+1)*wallW/WALLD, j*wallH-wallH/2, (l+0)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+l/2.0/WALLD)*texture0.height);
              
              //float d3 = 15*(noise(0.3*(i*WALLD+(k+1)), 0.3*(j*WALLD), 0.3*(l+1))-0.5);
              //if (k+1==WALLD ||l+1==WALLD) d3=0;
              laby0[etage].vertex(i*wallW-wallW/2+(k+1)*wallW/WALLD, j*wallH-wallH/2, (l+1)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              
              //float d4 = 15*(noise(0.3*(i*WALLD+(k+0)), 0.3*(j*WALLD), 0.3*(l+1))-0.5);
              //if (k==0 ||l+1==WALLD) d4=0;
              laby0[etage].vertex(i*wallW-wallW/2+(k+0)*wallW/WALLD, j*wallH-wallH/2, (l+1)*50/WALLD, k/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
            }
        }

        if (j==SIZE-1 || (labyrinthe[etage][j+1][i]==' ' || labyrinthe[etage][j+1][i]=='s')) {
          laby0[etage].normal(0, 1, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              laby0[etage].vertex(i*wallW-wallW/2+(k+0)*wallW/WALLD, j*wallH+wallH/2, (l+1)*50/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW-wallW/2+(k+1)*wallW/WALLD, j*wallH+wallH/2, (l+1)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW-wallW/2+(k+1)*wallW/WALLD, j*wallH+wallH/2, (l+0)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW-wallW/2+(k+0)*wallW/WALLD, j*wallH+wallH/2, (l+0)*50/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
            }
        }

        if (i==0 || (labyrinthe[etage][j][i-1]==' ' || labyrinthe[etage][j][i-1]=='s')) {
          laby0[etage].normal(-1, 0, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              laby0[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2+(k+0)*wallW/WALLD, (l+1)*50/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2+(k+1)*wallW/WALLD, (l+1)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2+(k+1)*wallW/WALLD, (l+0)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2+(k+0)*wallW/WALLD, (l+0)*50/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
            }
        }

        if (i==SIZE-1 || (labyrinthe[etage][j][i+1]==' ' || labyrinthe[etage][j][i+1]=='s')) {
          laby0[etage].normal(1, 0, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              laby0[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2+(k+0)*wallW/WALLD, (l+0)*50/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2+(k+1)*wallW/WALLD, (l+0)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2+(k+1)*wallW/WALLD, (l+1)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2+(k+0)*wallW/WALLD, (l+1)*50/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
            }
        }
        ceiling1[etage].fill(32, 255, 0);
        ceiling1[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2, 50);
        ceiling1[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2, 50);
        ceiling1[etage].vertex(i*wallW+wallW/2, j*wallH+wallH/2, 50);
        ceiling1[etage].vertex(i*wallW-wallW/2, j*wallH+wallH/2, 50);        
      } else {
        if(labyrinthe[etage][j][i] == 's') laby0[etage].fill(255); // ground
        else laby0[etage].fill(192); // ground
        laby0[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2, -50, 0, 0);
        laby0[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2, -50, 0, 1);
        laby0[etage].vertex(i*wallW+wallW/2, j*wallH+wallH/2, -50, 1, 1);
        laby0[etage].vertex(i*wallW-wallW/2, j*wallH+wallH/2, -50, 1, 0);
        
        ceiling0[etage].fill(32); // top of walls
        ceiling0[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2, 50);
        ceiling0[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2, 50);
        ceiling0[etage].vertex(i*wallW+wallW/2, j*wallH+wallH/2, 50);
        ceiling0[etage].vertex(i*wallW-wallW/2, j*wallH+wallH/2, 50);
      }
    }
  }
  
  laby0[etage].endShape();
  ceiling0[etage].endShape();
  ceiling1[etage].endShape();
}

void drawMiniMap(int SIZE, int etage) {
  wallW = width/SIZE;
  wallH = height/SIZE;
  for (int j=0; j<SIZE; j++) {
    for (int i=0; i<SIZE; i++) {
      if (labyrinthe[etage][j][i]=='#') {
        fill(i*25, j*25, 255-i*10+j*10);
        pushMatrix();
        translate(50+i*wallW/8, 50+j*wallH/8, 50);
        box(wallW/10, wallH/10, 5);
        popMatrix();
      }
    }
  }
  pushMatrix();
  fill(0, 255, 0);
  noStroke();
  translate(50+posX*wallW/8, 50+posY*wallH/8, 50);
  sphere(3);
  popMatrix();
  
}

void drawLaby(int SIZE, int etage) {
  //int Hauteur = LAB_SIZE * 50;
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
          if (i==posX || j==posY) {
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
          if (i==posX || j==posY) {
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
          if (i==posX || j==posY) {
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
          if (i==posX || j==posY) {
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
  
  shape(laby0[etage], 0, 0);
  if (inLab)
    shape(ceiling0[etage], 0, 0);
  //else shape(ceiling1, 0, 0);
}

void setupCam(int SIZE) {
  float wallW = width/SIZE;
  float wallH = height/SIZE;
  if (inLab) {
    perspective(2*PI/3, float(width)/float(height), 1, 10000);
    if (animT)
      camera((posX-dirX*anim/20.0)*wallW,      (posY-dirY*anim/20.0)*wallH,      -15+2*sin(anim*PI/5.0), 
             (posX-dirX*anim/20.0+dirX)*wallW, (posY-dirY*anim/20.0+dirY)*wallH, -15+4*sin(anim*PI/5.0), 0, 0, -1);
    else if (animR)
      camera(posX*wallW, posY*wallH, -15, 
            (posX+(odirX*anim+dirX*(20-anim))/20.0)*wallW, (posY+(odirY*anim+dirY*(20-anim))/20.0)*wallH, -15-5*sin(anim*PI/20.0), 0, 0, -1);
    else {
      camera(posX*wallW, posY*wallH, -15, 
             (posX+dirX)*wallW, (posY+dirY)*wallH, -15, 0, 0, -1);
    }
    //camera((posX-dirX*anim/20.0)*wallW, (posY-dirY*anim/20.0)*wallH, -15+6*sin(anim*PI/20.0), 
    //  (posX+dirX-dirX*anim/20.0)*wallW, (posY+dirY-dirY*anim/20.0)*wallH, -15+10*sin(anim*PI/20.0), 0, 0, -1);

    lightFalloff(0.0, 0.01, 0.0001);
    pointLight(255, 255, 255, posX*wallW, posY*wallH, 15);
  } else{
  float rotationAngle = map(mouseX, 0, width, 0, TWO_PI);
  float elevationAngle = map(mouseY, 0, height, 0, PI);

  centerX = cos(rotationAngle) * sin(elevationAngle);
  centerY = sin(rotationAngle) * sin(elevationAngle);
  centerZ = -cos(elevationAngle);
  camera(spectX, spectY, spectZ, 
        centerX + spectX, centerY + spectY, centerZ + spectZ, 
        0, 0, -1);
  }
}

void draw() {
  background(192);
  sphereDetail(6);
  if (anim>0) anim--;

  perspective();
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  noLights();
  stroke(0);
  drawMiniMap((currentFloor+2)*2+1, currentFloor);
  setupCam(21);
  drawLaby((currentFloor+2)*2+1,currentFloor);
}

void keyPressed() {

  if (key=='l') {
    inLab = !inLab;
    println("you are " + inLab + " inLab");
  }

  if (anim==0 && keyCode==38 && inLab) {
    if (posX+dirX>=0 && posX+dirX<LAB_SIZE && posY+dirY>=0 && posY+dirY<LAB_SIZE &&
      labyrinthe[currentFloor][posY+dirY][posX+dirX]!='#') {
      posX+=dirX; 
      posY+=dirY;
      anim=20;
      animT = true;
      animR = false;
    }
  }
  if (anim==0 && keyCode==40  && inLab && labyrinthe[currentFloor][posY-dirY][posX-dirX]!='#') {
    posX-=dirX; 
    posY-=dirY;
  }
  if (anim==0 && keyCode==37 && inLab) {
    odirX = dirX;
    odirY = dirY;
    anim = 20;
    int tmp = dirX; 
    dirX=dirY; 
    dirY=-tmp;
    animT = false;
    animR = true;
  }
  if (anim==0 && keyCode==39 && inLab) {
    odirX = dirX;
    odirY = dirY;
    anim = 20;
    animT = false;
    animR = true;
    int tmp = dirX; 
    dirX=-dirY; 
    dirY=tmp;
  }
  
  if (keyCode==38 && !inLab) {
    spectX += centerX * 15;
    spectY += centerY * 15;
    spectZ += centerZ * 15;
  }
  if (keyCode==40 && !inLab) {
    spectX -= centerX * 15;
    spectY -= centerY * 15;
    spectZ -= centerZ * 15;
  }
  if (keyCode==37 && !inLab) {
    spectX += centerY * 15;
    spectY -= centerX * 15;
  }
  if (keyCode==39 && !inLab) {
    spectX -= centerY * 15;
    spectY += centerX * 15;
  }
}
