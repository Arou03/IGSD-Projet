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
char[][][] labyrinthe ;
char[][][][] sides ;

PShape laby0[];
PShape ceiling0[];
PShape ceiling1[];
PShape sortie[];

float wallW;
float wallH;

PImage  texture0;
PImage  texture1;

int currentFloor = 8;
boolean sorti = true;

//Momie
PShape corps;
PShape tete;
PShape bras1;
PShape bras2;
PShape yeux1;
PShape yeux2;
PShape blancYeux1;
PShape blancYeux2;

int imX = 1;
int imY = 2;

int mX = imX;
int mY = imY;

int dxMomie = 0;
int dyMomie = 1;

//Direction possible pour la momie afin d'en avoir une aléatoire
int[][] dir;

PShape momie;

//Pyramide
PShape murVertical;
PShape murHorizontal;
PShape Sable;

PShape exterieur;

PImage texture2;
PImage texture3;

void setup() { 
  pixelDensity(2);
  randomSeed(2);
  
  texture0 = loadImage("stones.jpg");
  texture1 = loadImage("sortie.jpg");
   texture2 = loadImage("stones_exterior.jpg");
   texture3 = loadImage("sable.jpg");
  size(1000, 1000, P3D);
  
  wallW = width/LAB_SIZE;
  wallH = height/LAB_SIZE;
  
  initDirection();
  initMomie();
  initExterieur();
  exterieur.translate(-wallW/2.0, -wallW/2.0, -((wallH+wallW)/2));
  
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

void initExterieur() {
   murVertical = createShape();
   murVertical.beginShape(QUAD);
   
   murHorizontal = createShape();
   murHorizontal.beginShape(QUAD);
   
   murVertical.texture(texture2);
   murHorizontal.texture(texture2);
   
   murVertical.noStroke();
   murHorizontal.noStroke();
   
   exterieur = createShape(GROUP);
   
   float decal = 0;
   for(int arete = LAB_SIZE + 2; arete >0; arete -= 2) {
     
     decal = (2 + LAB_SIZE - arete) * (wallH+wallW)/4;
     
     for(int i = 0; i < arete; i++) {
         murHorizontal.fill(i*255/arete, 255-(i*255/arete+arete*1255/LAB_SIZE), arete*255/LAB_SIZE);
         murHorizontal.rotateZ(PI/2);
         murHorizontal.vertex(wallH * i + decal, 0 + decal, (wallH + wallW) + decal * 2, 
                              ((0)/2.0)*texture2.height, (0)*texture2.width);
         murHorizontal.vertex(wallH * i + decal, 0 + decal + ((wallH+wallW)/2), (wallH + wallW) + decal * 2,  
                              ((0)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex(wallH * (i + 1) + decal, 0 + decal + ((wallH+wallW)/2), (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex(wallH * (i + 1) + decal, 0 + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (0)*texture2.width);
         
         murHorizontal.vertex(0 + decal, wallH * i + decal, (wallH + wallW) + decal * 2, 
                              ((0)/2.0)*texture2.height, (0)*texture2.width);
         murHorizontal.vertex(0 + decal + ((wallH+wallW)/2), wallH * i + decal, (wallH + wallW) + decal * 2,  
                              ((0)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex(0 + decal + ((wallH+wallW)/2), wallH * (i + 1) + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex(0 + decal, wallH * (i + 1) + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (0)*texture2.width);
         
         
         murHorizontal.vertex(wallH * i + decal, (arete - 1) * wallW + decal, (wallH + wallW) + decal * 2, 
                              ((0)/2.0)*texture2.height, (0)*texture2.width);
         murHorizontal.vertex(wallH * i + decal, (arete - 1) * wallW + decal + ((wallH+wallW)/2), (wallH + wallW) + decal * 2,  
                              ((0)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex(wallH * (i + 1) + decal, (arete - 1) * wallW + decal + ((wallH+wallW)/2), (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex(wallH * (i + 1) + decal, (arete - 1) * wallW + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (0)*texture2.width);
         
         murHorizontal.vertex((arete - 1) * wallH + decal, wallH * i + decal, (wallH + wallW) + decal * 2, 
                              ((0)/2.0)*texture2.height, (0)*texture2.width);
         murHorizontal.vertex((arete - 1) * wallH + decal + ((wallH+wallW)/2), wallH * i + decal, (wallH + wallW) + decal * 2,  
                              ((0)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex((arete - 1) * wallH + decal + ((wallH+wallW)/2), wallH * (i + 1) + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex((arete - 1) * wallH + decal, wallH * (i + 1) + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (0)*texture2.width);
     }
     
     
     for(int k = 0; k < 2; k++) {
       int h = (int)(k * ((wallH+wallW)/2));
       for(int i = 0; i < arete; i++) {
         murVertical.fill(i*255/arete, 255-(i*255/arete+arete*1255/LAB_SIZE), arete*255/LAB_SIZE);
         
         murVertical.vertex(wallW * i + decal, 0 + decal, h+0 + decal * 2, 
                           (1)*texture2.width, (0)*texture2.height/2.0);
         murVertical.vertex(wallH * i + decal, 0 + decal, h+((wallH+wallW)/2) + decal * 2, 
                           (1)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(wallH * (i + 1) + decal, 0 + decal, h+((wallH+wallW)/2) + decal * 2, 
                           (0)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(wallW * (i + 1) + decal, 0 + decal, h+0 + decal * 2, 
                           (0)*texture2.width, (0)*texture2.height/2.0);
         
         murVertical.vertex(0 + decal, wallW * i + decal, h+0 + decal * 2, 
                           (1)*texture2.width, (0)*texture2.height/2.0);
         murVertical.vertex(0 + decal, wallH * i + decal, h+((wallH+wallW)/2) + decal * 2, 
                           (1)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(0 + decal, wallH * (i + 1) + decal, h+((wallH+wallW)/2) + decal * 2, 
                           (0)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(0 + decal, wallW * (i + 1) + decal, h+0 + decal * 2, 
                           (0)*texture2.width, (0)*texture2.height/2.0);
         
         murVertical.vertex(wallW * i + decal, arete * wallW + decal, h+0 + decal * 2, 
                           (1)*texture2.width, (0)*texture2.height/2.0);
         murVertical.vertex(wallH * i + decal, arete * wallW + decal, h+((wallH+wallW)/2) + decal * 2, 
                           (1)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(wallH * (i + 1) + decal, arete * wallW + decal, h+((wallH+wallW)/2) + decal * 2, 
                           (0)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(wallW * (i + 1) + decal, arete * wallW + decal, h+0 + decal * 2, 
                           (0)*texture2.width, (0)*texture2.height/2.0);
         
         murVertical.vertex(arete * wallH + decal, wallW * i + decal, h+0 + decal * 2, 
                           (1)*texture2.width, (0)*texture2.height/2.0);;
         murVertical.vertex(arete * wallH + decal, wallH * i + decal, h+((wallH+wallW)/2) + decal * 2, 
                           (1)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(arete * wallH + decal, wallH * (i + 1) + decal, h+((wallH+wallW)/2) + decal * 2, 
                           (0)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(arete * wallH + decal, wallW * (i + 1) + decal, h+0 + decal * 2, 
                           (0)*texture2.width, (0)*texture2.height/2.0);
       }
     }
   }
   murVertical.setVisible(true);
   murHorizontal.setVisible(true);
   murVertical.endShape();
   murHorizontal.endShape();
   
   Sable = createShape();
   Sable.beginShape(QUAD);
   Sable.fill(200, 200, 90);
   Sable.texture(texture3);
   Sable.noStroke();
   PVector v1;
   PVector v2; 
   PVector v3;
   Sable.resetMatrix();
   for(int i = -21; i < 21 * 2; i++) {
     for(int j = -21; j < 21 * 2; j++) {
       Sable.vertex(wallH * i, wallW * j, noise(i/5.0, j/5.0) * 5, 
                            (0)*texture3.height, (0)*texture3.width);
       Sable.vertex(wallH * i, wallW * (j + 1), noise(i/5.0, (j+1)/5.0) * 5, 
                            (0)*texture3.height, (1)*texture3.width);
       Sable.vertex(wallH * (i + 1), wallW * (j + 1), noise((i+1)/5.0, (j+1)/5.0) * 5,   
                            (1)*texture3.height, (1)*texture3.width);
       Sable.vertex(wallH * (i + 1), wallW * j, noise((i+1)/5.0, j/5.0) * 5,  
                            (1)*texture3.height, (0)*texture3.width);
       v1 = new PVector(1 * wallW, 0, noise(i, j) + noise(i+1, j));
       v1.normalize();
       v2 = new PVector(0, 1 * wallH, noise(i, j) + noise(i, j+1));
       v2.normalize();
       v3 = v1.cross(v2);
       v3.normalize();
       println("v1 : " + v1 + " v2 : " + v2);
       println("v3 : " + v3);
       Sable.normal(v3.x, v3.y, -v3.z);
     }
   }
   Sable.setVisible(true);
   Sable.endShape();
   
   exterieur.addChild(murVertical);
   exterieur.addChild(murHorizontal);
   exterieur.addChild(Sable);
}

void initDirection() {
  dir = new int[4][2];
  for(int i = 0; i < 4; i++) {
    if (i < 2) dir[i][0] = 0;
    else dir[i][1] = 0;
  }
  dir[0][1] = -1;
  dir[1][1] = 1;
  dir[2][0] = -1;
  dir[3][0] = 1;
}

void initMomie() {
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
       corps.fill(red, green, ((wallH+wallW)/2));
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
       tete.fill(red, green, ((wallH+wallW)/2));
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
       bras1.fill(red, green, ((wallH+wallW)/2));
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
       bras2.fill(red, green, ((wallH+wallW)/2));
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
  
  sortie[etage] = createShape();
  sortie[etage].beginShape(QUADS);
  sortie[etage].texture(texture1);
  sortie[etage].noStroke();
  
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
              laby0[etage].vertex(i*wallW-wallW/2+(k+0)*wallW/WALLD, j*wallH-wallH/2, (l+0)*((wallH+wallW)/2)/WALLD, k/(float)WALLD*texture0.width, (0.5+l/2.0/WALLD)*texture0.height);
              
              //float d2 =15*(noise(0.3*(i*WALLD+(k+1)), 0.3*(j*WALLD), 0.3*(l+0))-0.5);
              //if (k+1==WALLD ) d2=0;
              //if (l==-WALLD) d2=-2*abs(d2);
              laby0[etage].vertex(i*wallW-wallW/2+(k+1)*wallW/WALLD, j*wallH-wallH/2, (l+0)*((wallH+wallW)/2)/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+l/2.0/WALLD)*texture0.height);
              
              //float d3 = 15*(noise(0.3*(i*WALLD+(k+1)), 0.3*(j*WALLD), 0.3*(l+1))-0.5);
              //if (k+1==WALLD ||l+1==WALLD) d3=0;
              laby0[etage].vertex(i*wallW-wallW/2+(k+1)*wallW/WALLD, j*wallH-wallH/2, (l+1)*((wallH+wallW)/2)/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              
              //float d4 = 15*(noise(0.3*(i*WALLD+(k+0)), 0.3*(j*WALLD), 0.3*(l+1))-0.5);
              //if (k==0 ||l+1==WALLD) d4=0;
              laby0[etage].vertex(i*wallW-wallW/2+(k+0)*wallW/WALLD, j*wallH-wallH/2, (l+1)*((wallH+wallW)/2)/WALLD, k/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
            }
        }

        if (j==SIZE-1 || (labyrinthe[etage][j+1][i]==' ' || labyrinthe[etage][j+1][i]=='s')) {
          laby0[etage].normal(0, 1, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              laby0[etage].vertex(i*wallW-wallW/2+(k+0)*wallW/WALLD, j*wallH+wallH/2, (l+1)*((wallH+wallW)/2)/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW-wallW/2+(k+1)*wallW/WALLD, j*wallH+wallH/2, (l+1)*((wallH+wallW)/2)/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW-wallW/2+(k+1)*wallW/WALLD, j*wallH+wallH/2, (l+0)*((wallH+wallW)/2)/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW-wallW/2+(k+0)*wallW/WALLD, j*wallH+wallH/2, (l+0)*((wallH+wallW)/2)/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
            }
        }

        if (i==0 || (labyrinthe[etage][j][i-1]==' ' || labyrinthe[etage][j][i-1]=='s')) {
          laby0[etage].normal(-1, 0, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              laby0[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2+(k+0)*wallW/WALLD, (l+1)*((wallH+wallW)/2)/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2+(k+1)*wallW/WALLD, (l+1)*((wallH+wallW)/2)/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2+(k+1)*wallW/WALLD, (l+0)*((wallH+wallW)/2)/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2+(k+0)*wallW/WALLD, (l+0)*((wallH+wallW)/2)/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
            }
        }

        if (i==SIZE-1 || (labyrinthe[etage][j][i+1]==' ' || labyrinthe[etage][j][i+1]=='s')) {
          laby0[etage].normal(1, 0, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              laby0[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2+(k+0)*wallW/WALLD, (l+0)*((wallH+wallW)/2)/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2+(k+1)*wallW/WALLD, (l+0)*((wallH+wallW)/2)/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2+(k+1)*wallW/WALLD, (l+1)*((wallH+wallW)/2)/WALLD, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby0[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2+(k+0)*wallW/WALLD, (l+1)*((wallH+wallW)/2)/WALLD, (k+0)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
            }
        }
        ceiling1[etage].fill(32, 255, 0);
        ceiling1[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2, ((wallH+wallW)/2));
        ceiling1[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2, ((wallH+wallW)/2));
        ceiling1[etage].vertex(i*wallW+wallW/2, j*wallH+wallH/2, ((wallH+wallW)/2));
        ceiling1[etage].vertex(i*wallW-wallW/2, j*wallH+wallH/2, ((wallH+wallW)/2));        
      } else {
        if(labyrinthe[etage][j][i]=='s') {
          sortie[etage].normal(0,0,1);
          sortie[etage].fill(156); //grounds
          sortie[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2, -((wallH+wallW)/2), (0)/(float)WALLD*texture1.width, ((0)/WALLD)*texture1.height);
          sortie[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2, -((wallH+wallW)/2), (1)/(float)WALLD*texture1.width, ((0)/WALLD)*texture1.height);
          sortie[etage].vertex(i*wallW+wallW/2, j*wallH+wallH/2, -((wallH+wallW)/2), (1)/(float)WALLD*texture1.width, ((1)/WALLD)*texture1.height);
          sortie[etage].vertex(i*wallW-wallW/2, j*wallH+wallH/2, -((wallH+wallW)/2), (0)/(float)WALLD*texture1.width, ((1)/WALLD)*texture1.height);
        } else {
          laby0[etage].fill(156); //grounds
          laby0[etage].normal(0,0,1);
          laby0[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2, -((wallH+wallW)/2), (0)/(float)WALLD*texture0.width, (0.5+(0)/2.0/WALLD)*texture0.height);
          laby0[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2, -((wallH+wallW)/2), (1)/(float)WALLD*texture0.width, (0.5+(0)/2.0/WALLD)*texture0.height);
          laby0[etage].vertex(i*wallW+wallW/2, j*wallH+wallH/2, -((wallH+wallW)/2), (1)/(float)WALLD*texture0.width, (0.5+(1)/2.0/WALLD)*texture0.height);
          laby0[etage].vertex(i*wallW-wallW/2, j*wallH+wallH/2, -((wallH+wallW)/2), (0)/(float)WALLD*texture0.width, (0.5+(1)/2.0/WALLD)*texture0.height);
          }
        ceiling0[etage].fill(32); // top of walls
        ceiling0[etage].vertex(i*wallW-wallW/2, j*wallH-wallH/2, ((wallH+wallW)/2));
        ceiling0[etage].vertex(i*wallW+wallW/2, j*wallH-wallH/2, ((wallH+wallW)/2));
        ceiling0[etage].vertex(i*wallW+wallW/2, j*wallH+wallH/2, ((wallH+wallW)/2));
        ceiling0[etage].vertex(i*wallW-wallW/2, j*wallH+wallH/2, ((wallH+wallW)/2));
      }
    }
  }
  
  laby0[etage].endShape();
  ceiling0[etage].endShape();
  ceiling1[etage].endShape();
  sortie[etage].endShape();
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
  translate(((wallH+wallW)/2)+imX*wallW/8, ((wallH+wallW)/2)+imY*wallH/8, ((wallH+wallW)/2));
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

void setupCam(int SIZE) {
  float wallW = width/SIZE;
  float wallH = height/SIZE;
  if (inLab) {
    perspective(2*PI/3, float(width)/float(height), 1, 10000);
    if (animT) {
      cX = (posX-dirX*anim/20.0)*wallW; cY = (posY-dirY*anim/20.0)*wallH; cZ = -15+2*sin(anim*PI/5.0);
      camera(cX, cY, cZ, 
             (posX-dirX*anim/20.0+dirX)*wallW, (posY-dirY*anim/20.0+dirY)*wallH, -15+2*sin(anim*PI/5.0), 0, 0, -1);
    } else if (animR) {
      camera(posX*wallW, posY*wallH, -15, 
            (posX+(odirX*anim+dirX*(20-anim))/20.0)*wallW, (posY+(odirY*anim+dirY*(20-anim))/20.0)*wallH, -15-5*sin(anim*PI/20.0), 0, 0, -1);
    } else {
      cX = posX*wallW; cY = posY*wallH; cZ = -15;
      camera(cX, cY, cZ, 
             (posX+dirX)*wallW, (posY+dirY)*wallH, -15, 0, 0, -1);
    }
    
    //camera((posX-dirX*anim/20.0)*wallW, (posY-dirY*anim/20.0)*wallH, -15+6*sin(anim*PI/20.0), 
    //  (posX+dirX-dirX*anim/20.0)*wallW, (posY+dirY-dirY*anim/20.0)*wallH, -15+10*sin(anim*PI/20.0), 0, 0, -1);

    if(!sorti) lightFalloff(0.0, 0.01, 0.0001);
    else lightFalloff(1.0, 0.0, 0.0);
    pointLight(255, 255, 255, 
               cX, cY, cZ);
    
  } else{
  perspective(2*PI/3, float(width)/float(height), 1, 10000);
  float rotationAngle = map(mouseX, 0, width, 0, TWO_PI);
  float elevationAngle = map(mouseY, 0, height, 0, PI);

  centerX = cos(rotationAngle) * sin(elevationAngle);
  centerY = sin(rotationAngle) * sin(elevationAngle);
  centerZ = -cos(elevationAngle);
  camera(spectX, spectY, spectZ, 
        centerX + spectX, centerY + spectY, centerZ + spectZ, 
        0, 0, -1);
        
  lightFalloff(1.0, 0.0, 0.0);
  pointLight(255, 255, 255, 
             spectX, spectY, spectZ);
  }
}

void drawMomie() {
  pushMatrix();
  mX = int (imX * wallW);
  mY = int (imY * wallH);
  translate(0, 0, -((wallH+wallW)/2));
  shape(momie, mX, mY);
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
  if (sorti) {
    shape(exterieur);
    pushMatrix();
    resetMatrix();
    pointLight(255, 255, 200, 
               width/2.0, height/2.0, 1500);
    popMatrix();
  }
}

void mouvementMomie() {
  int i;
  if(imY == 0 && imX == 1) {
    dxMomie = 0;
    dyMomie = 1;
    momie.resetMatrix();
  }
  if(imY == (LAB_SIZE - (LAB_SIZE - ((currentFloor)*2+5))) && imX == (LAB_SIZE - (LAB_SIZE - ((currentFloor)*2+5)))) {
    dxMomie = -1;
    dyMomie = 0;
  } else {
    while (labyrinthe[currentFloor][imY + dyMomie][imX + dxMomie]=='#') {
      i = (int) random(0, 4);
      dxMomie = dir[i][0];
      dyMomie = dir[i][1];
      momie.resetMatrix();
      if(dyMomie == -1)momie.rotateZ(PI);
      if(dxMomie == 1)momie.rotateZ(-HALF_PI);
      if(dxMomie == -1)momie.rotateZ(HALF_PI);
    }
  }
  imX += dxMomie;
  imY += dyMomie;
}

void keyPressed() {
  if(inLab) mouvementMomie();
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
  if (anim==0 && keyCode==40  && inLab) {
    if (posX-dirX>=0 && posX-dirX<LAB_SIZE && posY-dirY>=0 && posY-dirY<LAB_SIZE &&
      labyrinthe[currentFloor][posY-dirY][posX-dirX]!='#') {
      posX-=dirX; 
      posY-=dirY;
      anim=-20;
      animT = true;
      animR = false;
    }
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
  if (keyCode==32 && inLab && labyrinthe[currentFloor][posY][posX] =='s') {
    if(currentFloor < 8) {
      posX = 1;
      posY = 0;
      dirX = 0;
      dirY = 1;
      currentFloor++;
    } else sorti = true;
  }   
}
