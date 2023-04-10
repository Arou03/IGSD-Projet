int iposX = 1;
int iposY = -1;

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
char labyrinthe [][];
char sides [][][];

PShape laby0;
PShape ceiling0;
PShape ceiling1;

PImage  texture0;

PShape corps;
PShape tete;
PShape bras1;
PShape bras2;
PShape yeux1;
PShape yeux2;
PShape blancYeux1;
PShape blancYeux2;

int imX = 1;
int imY = 0;

int mX = imX;
int mY = imY;

int dxMomie = 0;
int dyMomie = 1;

int[][] dir;

PShape momie;

void setup() { 
  
  dir = new int[4][2];
  for(int i = 0; i < 4; i++) {
    if (i < 2) dir[i][0] = 0;
    else dir[i][1] = 0;
  }
  dir[0][1] = -1;
  dir[1][1] = 1;
  dir[2][0] = -1;
  dir[3][0] = 1;
  for(int i = 0; i < 4; i++) {
    print("(" + dir[i][0]+ ", " + dir[i][1] + ") ");
  }
      
  pixelDensity(2);
  randomSeed(2);
  texture0 = loadImage("stones.jpg");
  size(1000, 1000, P3D);
  labyrinthe = new char[LAB_SIZE][LAB_SIZE];
  sides = new char[LAB_SIZE][LAB_SIZE][4];
  int todig = 0;
  for (int j=0; j<LAB_SIZE; j++) {
    for (int i=0; i<LAB_SIZE; i++) {
      sides[j][i][0] = 0;
      sides[j][i][1] = 0;
      sides[j][i][2] = 0;
      sides[j][i][3] = 0;
      if (j%2==1 && i%2==1) {
        labyrinthe[j][i] = '.';
        todig ++;
      } else
        labyrinthe[j][i] = '#';
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
    else if (alea==2 && gx<LAB_SIZE-2) gx += 2; // .. va a droite
    else if (alea==3 && gy<LAB_SIZE-2) gy += 2; // .. va en bas

    if (labyrinthe[gy][gx] == '.') {
      todig--;
      labyrinthe[gy][gx] = ' ';
      labyrinthe[(gy+oldgy)/2][(gx+oldgx)/2] = ' ';
    }
  }

  labyrinthe[0][1]                   = ' '; // entree
  labyrinthe[LAB_SIZE-2][LAB_SIZE-1] = ' '; // sortie

  for (int j=1; j<LAB_SIZE-1; j++) {
    for (int i=1; i<LAB_SIZE-1; i++) {
      if (labyrinthe[j][i]==' ') {
        if (labyrinthe[j-1][i]=='#' && labyrinthe[j+1][i]==' ' &&
          labyrinthe[j][i-1]=='#' && labyrinthe[j][i+1]=='#')
          sides[j-1][i][0] = 1;// c'est un bout de couloir vers le haut 
        if (labyrinthe[j-1][i]==' ' && labyrinthe[j+1][i]=='#' &&
          labyrinthe[j][i-1]=='#' && labyrinthe[j][i+1]=='#')
          sides[j+1][i][3] = 1;// c'est un bout de couloir vers le bas 
        if (labyrinthe[j-1][i]=='#' && labyrinthe[j+1][i]=='#' &&
          labyrinthe[j][i-1]==' ' && labyrinthe[j][i+1]=='#')
          sides[j][i+1][1] = 1;// c'est un bout de couloir vers la droite
        if (labyrinthe[j-1][i]=='#' && labyrinthe[j+1][i]=='#' &&
          labyrinthe[j][i-1]=='#' && labyrinthe[j][i+1]==' ')
          sides[j][i-1][2] = 1;// c'est un bout de couloir vers la gauche
      }
    }
  }

  // un affichage texte pour vous aider a visualiser le labyrinthe en 2D
  for (int j=0; j<LAB_SIZE; j++) {
    for (int i=0; i<LAB_SIZE; i++) {
      print(labyrinthe[j][i]);
    }
    println("");
  }
  
  float wallW = width/LAB_SIZE;
  float wallH = height/LAB_SIZE;

  ceiling0 = createShape();
  ceiling1 = createShape();
  
  ceiling1.beginShape(QUADS);
  ceiling0.beginShape(QUADS);
  
  laby0 = createShape();
  laby0.beginShape(QUADS);
  laby0.texture(texture0);
  laby0.noStroke();
  //laby0.stroke(255, 32);
  //laby0.strokeWeight(0.5);
  
  for (int j=0; j<LAB_SIZE; j++) {
    for (int i=0; i<LAB_SIZE; i++) {
      if (labyrinthe[j][i]=='#') {
        
        laby0.fill(i*25, j*25, 255-i*10+j*10);
        if (j==0 || labyrinthe[j-1][i]==' ') {
          laby0.normal(0, -1, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              //float d1 = 15*(noise(0.3*(i*WALLD+(k+0)), 0.3*(j*WALLD), 0.3*(l+0))-0.5);
              //if (k==0)  d1=0;
              //if (l==-WALLD) d1=-2*abs(d1);
              laby0.vertex(i*wallW-wallW/2+(k+0)*wallW/WALLD, j*wallH-wallH/2, (l+0)*50/WALLD, k/(float)WALLD*texture0.width, (0.5+l/2.0/WALLD)*texture0.height);
              
              //float d2 =15*(noise(0.3*(i*WALLD+(k+1)), 0.3*(j*WALLD), 0.3*(l+0))-0.5);
              //if (k+1==WALLD ) d2=0;
              //if (l==-WALLD) d2=-2*abs(d2);
              laby0.vertex(i*wallW-wallW/2+(k+1)*wallW/WALLD, j*wallH-wallH/2, (l+0)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+l/2.0/WALLD)*texture0.height);
              
              //float d3 = 15*(noise(0.3*(i*WALLD+(k+1)), 0.3*(j*WALLD), 0.3*(l+1))-0.5);
              //if (k+1==WALLD ||l+1==WALLD) d3=0;
              laby0.vertex(i*wallW-wallW/2+(k+1)*wallW/WALLD, j*wallH-wallH/2, (l+1)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              
              //float d4 = 15*(noise(0.3*(i*WALLD+(k+0)), 0.3*(j*WALLD), 0.3*(l+1))-0.5);
              //if (k==0 ||l+1==WALLD) d4=0;
              laby0.vertex(i*wallW-wallW/2+(k+0)*wallW/WALLD, j*wallH-wallH/2, (l+1)*50/WALLD, k/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
            }
        }

        if (j==LAB_SIZE-1 || labyrinthe[j+1][i]==' ') {
          laby0.normal(0, 1, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              laby0.vertex(i*wallW-wallW/2+(k+0)*wallW/WALLD, j*wallH+wallH/2, (l+1)*50/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0.vertex(i*wallW-wallW/2+(k+1)*wallW/WALLD, j*wallH+wallH/2, (l+1)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0.vertex(i*wallW-wallW/2+(k+1)*wallW/WALLD, j*wallH+wallH/2, (l+0)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby0.vertex(i*wallW-wallW/2+(k+0)*wallW/WALLD, j*wallH+wallH/2, (l+0)*50/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
            }
        }

        if (i==0 || labyrinthe[j][i-1]==' ') {
          laby0.normal(-1, 0, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              laby0.vertex(i*wallW-wallW/2, j*wallH-wallH/2+(k+0)*wallW/WALLD, (l+1)*50/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0.vertex(i*wallW-wallW/2, j*wallH-wallH/2+(k+1)*wallW/WALLD, (l+1)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0.vertex(i*wallW-wallW/2, j*wallH-wallH/2+(k+1)*wallW/WALLD, (l+0)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby0.vertex(i*wallW-wallW/2, j*wallH-wallH/2+(k+0)*wallW/WALLD, (l+0)*50/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
            }
        }

        if (i==LAB_SIZE-1 || labyrinthe[j][i+1]==' ') {
          laby0.normal(1, 0, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              laby0.vertex(i*wallW+wallW/2, j*wallH-wallH/2+(k+0)*wallW/WALLD, (l+0)*50/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby0.vertex(i*wallW+wallW/2, j*wallH-wallH/2+(k+1)*wallW/WALLD, (l+0)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby0.vertex(i*wallW+wallW/2, j*wallH-wallH/2+(k+1)*wallW/WALLD, (l+1)*50/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0.vertex(i*wallW+wallW/2, j*wallH-wallH/2+(k+0)*wallW/WALLD, (l+1)*50/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
            }
        }
        ceiling1.fill(32, 255, 0);
        ceiling1.vertex(i*wallW-wallW/2, j*wallH-wallH/2, 50);
        ceiling1.vertex(i*wallW+wallW/2, j*wallH-wallH/2, 50);
        ceiling1.vertex(i*wallW+wallW/2, j*wallH+wallH/2, 50);
        ceiling1.vertex(i*wallW-wallW/2, j*wallH+wallH/2, 50);        
      } else {
        laby0.fill(192); // ground
        laby0.vertex(i*wallW-wallW/2, j*wallH-wallH/2, -50, 0, 0);
        laby0.vertex(i*wallW+wallW/2, j*wallH-wallH/2, -50, 0, 1);
        laby0.vertex(i*wallW+wallW/2, j*wallH+wallH/2, -50, 1, 1);
        laby0.vertex(i*wallW-wallW/2, j*wallH+wallH/2, -50, 1, 0);
        
        ceiling0.fill(32); // top of walls
        ceiling0.vertex(i*wallW-wallW/2, j*wallH-wallH/2, 50);
        ceiling0.vertex(i*wallW+wallW/2, j*wallH-wallH/2, 50);
        ceiling0.vertex(i*wallW+wallW/2, j*wallH+wallH/2, 50);
        ceiling0.vertex(i*wallW-wallW/2, j*wallH+wallH/2, 50);
      }
    }
  }
  
  laby0.endShape();
  ceiling0.endShape();
  ceiling1.endShape();
  
  //momie
  
   corps = createShape();
   corps.beginShape(QUAD_STRIP); 
   corps.fill(235, 216, 97);
   corps.noStroke();
   float rayon;
   float red;
   float green;
   int tailleBande = 4;
   for(int i = 0; i < 64; i+=2) {
     for(float j = 0; j < 2*PI; j+= 2*PI/64.0) {
       red = 120 + 105 * noise(i, j);
       green = 120 + 76 * noise(i, j);
       corps.fill(red, green, 50);
       rayon = 4 + tailleBande * sin((i + tailleBande*(j/(2*PI)))*PI/64.0);
       corps.vertex(rayon*cos(j), 5*sin(j), i + tailleBande*(j/(2*PI)));
       corps.vertex(rayon*cos(j), 5*sin(j), i + tailleBande + tailleBande*(j/(2*PI)));
     }
   }
   corps.endShape();
   
   
   tete = createShape();
   tete.beginShape(QUAD_STRIP); 
   tete.fill(235, 216, 97);
   tete.noStroke();
   tailleBande = 4;
   for(int i =0; i < 20; i+=2) {
     for(float j = 0; j < 2*PI; j+= 2*PI/64.0) {
       red = 120 + 105 * noise(i, j);
       green = 120 + 76 * noise(i, j);
       tete.fill(red, green, 50);
       rayon = 4 + 2 * sin((i + tailleBande*(j/(2*PI)))*PI/20.);
       tete.vertex(rayon*cos(j), rayon*sin(j), 64 + i + tailleBande*(j/(2*PI)));
       tete.vertex(rayon*cos(j), rayon*sin(j), 64 + i + tailleBande + tailleBande*(j/(2*PI)));
     }
   }
  tete.endShape();
  
   bras1 = createShape();
   bras1.beginShape(QUAD_STRIP); 
   bras1.fill(235, 216, 97);
   bras1.noStroke();
   tailleBande = 4;
   for(int i =0; i < 20; i+=2) {
     for(float j = 0; j < 2*PI; j+= 2*PI/64.0) {
       red = 120 + 105 * noise(i, j);
       green = 120 + 76 * noise(i, j);
       bras1.fill(red, green, 50);
       rayon = 1 + 2 * sin((i + tailleBande*(j/(2*PI)))*PI/20.);
       bras1.vertex(5+rayon*cos(j), i + tailleBande*(j/(2*PI)), 64 +rayon*sin(j));
       bras1.vertex(5+rayon*cos(j), i + tailleBande + tailleBande*(j/(2*PI)), 64 +rayon*sin(j));
     }
   }
  bras1.endShape();
  
   bras2 = createShape();
   bras2.beginShape(QUAD_STRIP);  
   bras2.fill(235, 216, 97);
   bras2.noStroke();
   for(int i =0; i < 20; i+=2) {
     for(float j = 0; j < 2*PI; j+= 2*PI/64.0) {
       red = 120 + 105 * noise(i, j);
       green = 120 + 76 * noise(i, j);
       bras2.fill(red, green, 50);
       rayon = 1 + 2 * sin((i + tailleBande*(j/(2*PI)))*PI/20.);
       bras2.vertex(-5+rayon*cos(j), i + tailleBande*(j/(2*PI)), 64 +rayon*sin(j));
       bras2.vertex(-5+rayon*cos(j), i + tailleBande + tailleBande*(j/(2*PI)), 64 +rayon*sin(j));
     }
   }
  bras2.endShape();
  
  yeux1 = createShape(SPHERE, 1); 
   yeux1.setFill(color(0));
   yeux1.setStroke(0);
  yeux1.translate(3, 4.5, 78);
  yeux2 = createShape(SPHERE, 1); 
   yeux2.setFill(color(0));
   yeux2.setStroke(0);
  yeux2.translate(-3, 4.5, 78);
  
  blancYeux1 = createShape(SPHERE, 2); 
   blancYeux1.setFill(color(236));
   blancYeux1.setStroke(0);
  blancYeux1.translate(2.5, 3.5, 78);
  blancYeux2 = createShape(SPHERE, 2); 
   blancYeux2.setFill(color(236));
   blancYeux2.setStroke(0);
  blancYeux2.translate(-2.5, 3.5, 78);
  
  
  momie = createShape(GROUP);
  momie.addChild(corps);
  momie.addChild(tete);
  momie.addChild(bras1);
  momie.addChild(bras2);
  momie.addChild(yeux1);
  momie.addChild(yeux2);
  momie.addChild(blancYeux1);
  momie.addChild(blancYeux2);
}

void draw() {
  background(192);
  sphereDetail(6);
  if (anim>0) anim--;

  float wallW = width/LAB_SIZE;
  float wallH = height/LAB_SIZE;

  perspective();
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  noLights();
  stroke(0);
  for (int j=0; j<LAB_SIZE; j++) {
    for (int i=0; i<LAB_SIZE; i++) {
      if (labyrinthe[j][i]=='#') {
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
  
  pushMatrix();
  fill(255, 255, 0);
  noStroke();
  translate(50+imX*wallW/8, 50+imY*wallH/8, 50);
  sphere(3);
  popMatrix();

  stroke(0);
  if (inLab) {
    perspective(2*PI/3.0, float(width)/float(height), 1, 1000);
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
    lightFalloff(0.0, 0.05, 0.0001);
    pointLight(255, 255, 255, posX*wallW, posY*wallH, 15);
  }

  noStroke();
  for (int j=0; j<LAB_SIZE; j++) {
    for (int i=0; i<LAB_SIZE; i++) {
      pushMatrix();
      translate(i*wallW, j*wallH, 0);
      if (labyrinthe[j][i]=='#') {
        beginShape(QUADS);
        if (sides[j][i][3]==1) {
          pushMatrix();
          translate(0, -wallH/2, 40);
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

        if (sides[j][i][0]==1) {
          pushMatrix();
          translate(0, wallH/2, 40);
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
         
         if (sides[j][i][1]==1) {
          pushMatrix();
          translate(-wallW/2, 0, 40);
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
         
        if (sides[j][i][2]==1) {
          pushMatrix();
          translate(0, wallH/2, 40);
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
  
  shape(laby0, 0, 0);
  if (inLab)
    shape(ceiling0, 0, 0);
  else
    shape(ceiling1, 0, 0);
  
  mX = int (imX * wallW);
  mY = int (imY * wallH);
  translate(0, 0, -50);
  shape(momie, mX, mY);
}

void mouvementMomie() {
  int i;
  while (labyrinthe[imY + dyMomie][imX + dxMomie]=='#') {
    i = (int) random(0, 4);
    dxMomie = dir[i][0];
    dyMomie = dir[i][1];
    println("j'essaye x = " + dxMomie + ", y = " + dyMomie);
    momie.resetMatrix();
    if(dyMomie == -1)momie.rotateZ(PI);
    if(dxMomie == 1)momie.rotateZ(-HALF_PI);
    if(dxMomie == -1)momie.rotateZ(HALF_PI);
  }
  imX += dxMomie;
  imY += dyMomie;
}

void keyPressed() {
  mouvementMomie();
  println("pos x = " + imX + ", y = " + imY);
  println("dir x = " + dxMomie + ", y = " + dyMomie);
  if (key=='l') inLab = !inLab;

  if (anim==0 && keyCode==38) {
    if (posX+dirX>=0 && posX+dirX<LAB_SIZE && posY+dirY>=0 && posY+dirY<LAB_SIZE &&
      labyrinthe[posY+dirY][posX+dirX]!='#') {
      posX+=dirX; 
      posY+=dirY;
      anim=20;
      animT = true;
      animR = false;
    }
  }
  if (anim==0 && keyCode==40 && labyrinthe[posY-dirY][posX-dirX]!='#') {
    posX-=dirX; 
    posY-=dirY;
  }
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
}
