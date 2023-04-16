char[][][] labyrinthe ;
char[][][][] sides ;

PShape laby0[];
PShape ceiling0[];
PShape ceiling1[];
PShape sortie[];

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
  
  laby0[etage].normal(0, 1, 0);
  for (int l=0; l<2; l++) {
    laby0[etage].vertex(0*wallW + wallW/2, -wallH/2.0, (l+1)*((wallH+wallW)/2) - (wallH+wallW)/2, 
                        0*texture0.width, (1+l)/2.0*texture0.height);
    laby0[etage].vertex(1*wallW + wallW/2, -wallH/2.0, (l+1)*((wallH+wallW)/2) - (wallH+wallW)/2, 
                        1*texture0.width, (1+l)/2.0*texture0.height);
    laby0[etage].vertex(1*wallW + wallW/2, -wallH/2.0, (l+0)*((wallH+wallW)/2) - (wallH+wallW)/2, 
                        1*texture0.width, (0+l)/2.0*texture0.height);
    laby0[etage].vertex(0*wallW + wallW/2, -wallH/2.0, (l+0)*((wallH+wallW)/2) - (wallH+wallW)/2, 
                        0*texture0.width, (0+l)/2.0*texture0.height);
  }
  for (int l=0; l<2; l++) {
    laby0[etage].vertex((SIZE-1)*wallW + wallW/2, (SIZE-1)*wallH-wallH/2.0, (l+1)*((wallH+wallW)/2) - (wallH+wallW)/2, 
                        0*texture0.width, (1+l)/2.0*texture0.height);
    laby0[etage].vertex((SIZE)*wallW + wallW/2, (SIZE-1)*wallH-wallH/2.0, (l+1)*((wallH+wallW)/2) - (wallH+wallW)/2, 
                        1*texture0.width, (1+l)/2.0*texture0.height);
    laby0[etage].vertex((SIZE)*wallW + wallW/2, (SIZE-1)*wallH-wallH/2.0, (l+0)*((wallH+wallW)/2) - (wallH+wallW)/2, 
                        1*texture0.width, (0+l)/2.0*texture0.height);
    laby0[etage].vertex((SIZE-1)*wallW + wallW/2, (SIZE-1)*wallH-wallH/2.0, (l+0)*((wallH+wallW)/2) - (wallH+wallW)/2, 
                        0*texture0.width, (0+l)/2.0*texture0.height);
  }
  for (int l=0; l<2; l++) {
    laby0[etage].vertex((SIZE-1)*wallW + wallW/2, (SIZE-2)*wallH-wallH/2.0, (l+1)*((wallH+wallW)/2) - (wallH+wallW)/2, 
                        0*texture0.width, (1+l)/2.0*texture0.height);
    laby0[etage].vertex((SIZE)*wallW + wallW/2, (SIZE-2)*wallH-wallH/2.0, (l+1)*((wallH+wallW)/2) - (wallH+wallW)/2, 
                        1*texture0.width, (1+l)/2.0*texture0.height);
    laby0[etage].vertex((SIZE)*wallW + wallW/2, (SIZE-2)*wallH-wallH/2.0, (l+0)*((wallH+wallW)/2) - (wallH+wallW)/2, 
                        1*texture0.width, (0+l)/2.0*texture0.height);
    laby0[etage].vertex((SIZE-1)*wallW + wallW/2, (SIZE-2)*wallH-wallH/2.0, (l+0)*((wallH+wallW)/2) - (wallH+wallW)/2, 
                        0*texture0.width, (0+l)/2.0*texture0.height);
  }
  
  laby0[etage].endShape();
  ceiling0[etage].endShape();
  ceiling1[etage].endShape();
  sortie[etage].endShape();
}
