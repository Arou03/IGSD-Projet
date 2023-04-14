PShape sable;
PShape decor;
PShape murVertical;
PShape murHorizontal;

PImage texture0;
PImage texture1;
PImage texture2;
PImage texture3;

int LAB_SIZE = 21;

int WALLD = 1;

//mode spectateur
float spectX = 0;
float spectY = 0;
float spectZ = 0;

float centerX;
float centerY;
float centerZ;

int wallW;
int wallH;

char[][][] labyrinthe ;
char[][][][] sides ;

PShape laby0[];
PShape ceiling0[];
PShape ceiling1[];
PShape sortie[];

int currentFloor = 8;

boolean inLab;

void setup() {
  
  randomSeed(2);
  size(1000, 1000, P3D);
  
  wallW = width/LAB_SIZE;
  wallH = height/LAB_SIZE;
  
  texture0 = loadImage("stones.jpg");
  texture1 = loadImage("sortie.jpg");
  texture2 = loadImage("stones_exterior.jpg");
  texture3 = loadImage("sable.jpg");
  
  
  decor = createShape(GROUP);
  
  initSable();
  initExterieur();
  
  decor.addChild(murVertical);
  decor.addChild(murHorizontal);
  decor.addChild(sable);
  
  labyrinthe = new char[LAB_SIZE/2-1][LAB_SIZE][LAB_SIZE];
  sides = new char[LAB_SIZE/2-1][LAB_SIZE][LAB_SIZE][4];
  laby0 = new PShape[LAB_SIZE/2-1];
  ceiling0 = new PShape[LAB_SIZE/2-1];
  ceiling1 = new PShape[LAB_SIZE/2-1];
  sortie = new PShape[LAB_SIZE/2-1];
  
  initPyramide(8, 21);
  inLab = false;
  decor.translate(-wallW/2.0, -wallW/2.0, -((wallH+wallW)/2));
  //decor.scale(11.75);
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
  
  //laby0[etage].stroke(0);
  //laby0[etage].strokeWeight(10.0);
  
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

void initSable() {
  sable = createShape();
   sable.beginShape(QUAD);
   sable.fill(200, 200, 90);
   sable.texture(texture3);
   sable.noStroke();
   PVector v1;
   PVector v2; 
   PVector v3;
   sable.resetMatrix();
   for(int i = -21; i < 21 * 2; i++) {
     for(int j = -21; j < 21 * 2; j++) {
       sable.vertex(wallH * i, wallW * j, noise(i, j), 
                            (0)*texture3.height, (0)*texture3.width);
       sable.vertex(wallH * i, wallW * (j + 1), noise(i, j+1), 
                            (0)*texture3.height, (1)*texture3.width);
       sable.vertex(wallH * (i + 1), wallW * (j + 1), noise(i+1, j+1),   
                            (1)*texture3.height, (1)*texture3.width);
       sable.vertex(wallH * (i + 1), wallW * j, noise(i+1, j),  
                            (1)*texture3.height, (0)*texture3.width);
       v1 = new PVector(1, 0, noise(i, j) + noise(i+1, j));
       v2 = new PVector(0, 1, noise(i, j) + noise(i, j+1));
       v3 = v1.cross(v2);
       sable.normal(v3.x, v3.y, v3.z);
     }
   }
   sable.setVisible(true);
   sable.endShape();
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
   
   decor = createShape(GROUP);
   
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
       int h = k * ((wallH+wallW)/2);
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
}

void setupCam(int SIZE) {
  float wallW = width/SIZE;
  float wallH = height/SIZE;
  /**
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

    //lightFalloff(0.0, 0.01, 0.0001);
    
    pointLight(255, 255, 255, 
              posX*wallW, posY*wallH, -15);
    
  } else{**/
  perspective(2*PI/3, float(width)/float(height), 1, 10000);
  float rotationAngle = map(mouseX, 0, width, 0, TWO_PI);
  float elevationAngle = map(mouseY, 0, height, 0, PI);

  centerX = cos(rotationAngle) * sin(elevationAngle);
  centerY = sin(rotationAngle) * sin(elevationAngle);
  centerZ = -cos(elevationAngle);
  camera(spectX, spectY, spectZ, 
        centerX + spectX, centerY + spectY, centerZ + spectZ, 
        0, 0, -1);
        
  spotLight(255, 255, 255, 
            spectX, spectY, spectZ,
            spectX + centerX, spectY + centerY, spectZ + centerZ,
            PI/2.0, 1);
  //}
}


void draw() {
  background(173);
  setupCam(LAB_SIZE);
  shape(decor);
  drawLaby(21, 8);
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
          /**if ((i==posX && j - posY < 4) || (j==posY && j - posX < 4)) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            sphere(15);
          }**/
          popMatrix();
        }

        if (sides[etage][j][i][0]==1) {
          pushMatrix();
          translate(0, wallH/2, 40 + Hauteur);
          /**if ((i==posX && j - posY < 4) || (j==posY && j - posX < 4)) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            sphere(15);
          }**/
          popMatrix();
        }
         
         if (sides[etage][j][i][1]==1) {
          pushMatrix();
          translate(-wallW/2, 0, 40 + Hauteur);
          /**if ((i==posX && j - posY < 4) || (j==posY && j - posX < 4)) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            sphere(15);
          }**/
          popMatrix();
        }
         
        if (sides[etage][j][i][2]==1) {
          pushMatrix();
          translate(0, wallH/2, 40 + Hauteur);
          /**if ((i==posX && j - posY < 4) || (j==posY && j - posX < 4)) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            sphere(15);
          }**/
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

void keyPressed() {
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
