PShape head, body, hands, hand, eye1, eye2, eyeball1,eyeball2, mommie, main1, main2;

PShape wallVertical, wallHorizontal, sand, exterior;

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
int todig = 0;
char labyrinthe [][];
boolean deplace [][];
char sides [][][];

//int mx=LAB_SIZE-1;
//int my=LAB_SIZE-2;     //coordonées de la mommie
int mx=1;
int my= 0;
int dx=0;
int dy=1;   


PShape laby0;
PShape laby1;
PShape ceiling0;
PShape ceiling1;

PImage  texture0;
PImage  texture1;
PImage texture3;
PImage texture4;

float wallLen;

void setup() { 
  pixelDensity(2);
  randomSeed(2);
  // creation de ma 
  Mommie();
  
  texture0 = loadImage("stones.jpg");
  texture1 = loadImage ("sol.jpg");
  texture3 = loadImage("outside_wall.png");
  texture4 = loadImage("sand.png");
  //size(1000, 1000, P3D);
  size(600, 600, P3D);
  
  wallLen = ((width+height)/2)/(float)LAB_SIZE;
  Pyramide();
  
  labyrinthe = new char[LAB_SIZE][LAB_SIZE];
  laby();
  sides = new char[LAB_SIZE][LAB_SIZE][4];
  side();
  deplace = new boolean [LAB_SIZE][LAB_SIZE];
  deplacement();
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

  /*labyrinthe[0][1]                   = ' '; // entree
  labyrinthe[LAB_SIZE-2][LAB_SIZE-1] = ' '; // sortie*/


  // un affichage texte pour vous aider a visualiser le labyrinthe en 2D
  /*for (int j=0; j<LAB_SIZE; j++) {
    for (int i=0; i<LAB_SIZE; i++) {
      print(labyrinthe[j][i]);
    }
    println("");
  }*/
  
  float wallW = width/LAB_SIZE;
  float wallH = height/LAB_SIZE;

  ceiling0 = createShape();
  ceiling1 = createShape();
  
  ceiling1.beginShape(QUADS);
  ceiling0.beginShape(QUADS);
  laby1 = createShape();
  laby1.beginShape(QUADS);
  laby0 = createShape();
  laby0.beginShape(QUADS);
  laby1.texture(texture1);
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
        //laby0.fill(192,20,20); // ground
       //laby0.fill(222);
       //laby0.texture(texture1);
       laby1.noStroke();
        laby1.vertex(i*wallW-wallW/2, j*wallH-wallH/2, -50, 0, 0);
        laby1.vertex(i*wallW+wallW/2, j*wallH-wallH/2, -50, 0, texture1.height);
        laby1.vertex(i*wallW+wallW/2, j*wallH+wallH/2, -50, texture1.width, texture1.height);
        laby1.vertex(i*wallW-wallW/2, j*wallH+wallH/2, -50, texture1.width, 0);
        
        
        ceiling0.fill(32); // top of walls
        //ceiling0.texture(texture1);
        ceiling0.vertex(i*wallW-wallW/2, j*wallH-wallH/2, 50);
        ceiling0.vertex(i*wallW+wallW/2, j*wallH-wallH/2, 50);
        ceiling0.vertex(i*wallW+wallW/2, j*wallH+wallH/2, 50);
        ceiling0.vertex(i*wallW-wallW/2, j*wallH+wallH/2, 50);
      }
    }
  }
  
  laby0.endShape();
  laby1.endShape();
  ceiling0.endShape();
  ceiling1.endShape();
}

void draw() {
  background(110, 177, 255);
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
    if( posY+dirY>-1) {deplace[posY+dirY][posX+dirX]=true;}
      //deplace[py][posX]=true;
      if (labyrinthe[j][i]=='#' && deplace[j][i]) {
        fill(i*25, j*25, 255-i*10+j*10);
        pushMatrix();
        translate(50+i*wallW/8, 50+j*wallH/8, 50);
        box(wallW/10, wallH/10, 5);
        popMatrix(); 
        if(i>0 && j>0 && j<LAB_SIZE-1 && i<LAB_SIZE-1){
          deplace[j-1][i-1]=true;
          deplace[j-1][i]=true;
          deplace[j+1][i]=true;
          deplace[j][i-1]= true;
          deplace[j+1][i+1]= true;
          deplace[j+1][i]=true;
          deplace[j][i+1]=true;
        }
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
  fill(255, 255,0);
  noStroke();
  translate(50+mx*wallW/8, 50+my*wallH/8, 50);
  sphere(3);
  popMatrix();

  stroke(0);
  if (inLab) {
    perspective(2*PI/3, float(width)/float(height), 1, 1000);
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
    //ambientLight(15,15,15);
    pointLight(255, 255, 255, posX*wallW, posY*wallH, 15);
  } else{
    lightFalloff(0.0, 0.05, 0.0001);
    pointLight(255, 255, 255, posX*wallW, posY*wallH, 15);
    camera(posX*wallW, posY*wallH, -15, 
             (posX+dirX)*wallW, (posY+dirY)*wallH, -15, 0, 0, -1);
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
  shape(laby1, 0, 0);
  shape(laby0, 0, 0);
  if (inLab){
    shape(laby1, 0, 0);
    shape(ceiling0, 0, 1);
  }else{
    shape(ceiling1, 0, 0);
  }
  
  if(dx==0 && dy==1){
    pushMatrix();
      translate(mx*wallW,my*wallW, -35);
      rotateX(-PI/2);
      //rotateY(PI);
      scale(0.1);
      shape(mommie);
      popMatrix();
  }else if (dx==-1 && dy==0){
    pushMatrix();
    translate(mx*wallW,my*wallW, -35);
    rotateX(-PI/2);
    rotateY(-PI/2);
    scale(0.1);
    shape(mommie);
    popMatrix(); 
  }else if(dx==1 && dy==0){
    pushMatrix();
    translate(mx*wallW,my*wallW, -35);
    rotateX(-PI/2);
    rotateY(PI/2);
    scale(0.1);
    shape(mommie);
    popMatrix(); 
  }else if (dx==0 && dy==-1){
      pushMatrix();
      translate(mx*wallW,my*wallW, -35);
      rotateX(-PI/2);
      rotateY(PI/2);
      scale(0.1);
      shape(mommie);
      popMatrix();
  }
  if(my+dy>=0 && my+dy<LAB_SIZE && mx+dx>=0 && mx+dx<LAB_SIZE &&
    labyrinthe[my+dy][mx+dx]!='#' && dx==0 && dy==1){
       my=((frameCount/50)-(mx))%(LAB_SIZE-1);
    }
    else if(my+dy>=0 && my+dy<LAB_SIZE && mx+dx>=0 && mx+dx<LAB_SIZE &&
    labyrinthe[my+dy][mx-dx]!='#' && dx==-1 && dy==0){
        mx=((frameCount/50)-(my))%(LAB_SIZE-1);
    }
    
    else if(my+dy>=0 && my+dy<LAB_SIZE && mx+dx>=0 && mx+dx<LAB_SIZE &&
    labyrinthe[my+dy][mx-dx]!='#' && dx==0 && dy==-1){
        my=((frameCount/50)-(mx))%(LAB_SIZE-1)-1;
    }
   /*if(my+dy>=0 && my+dy<LAB_SIZE && mx+dx>=0 && mx+dx<LAB_SIZE && labyrinthe[my+dy][mx+dx]=='#' || (dy==0 && dx==0) || (dy==1 && dx==1) || (dy==-1 && dx==-1)){
     // println("enter and dx= "+ dx + "dy "+ dy);
      dy=int(random(-2,2));
      dx=int(random(-2,2));
      println("enter and dx= "+ dx + " dy "+ dy);
      // println("boucle 2 my = "+ my+ ", mx= "+mx);
    }
    println((frameCount/50));
    
    
  
   /*if (my+dy>=0 && my+dy<LAB_SIZE && mx+dx>=0 && mx+dx<LAB_SIZE &&
      labyrinthe[my+dy][mx+dx]!='#' && dx==0 && dy==1) {
      println("boucle 1 my = "+ my+ ", mx= "+mx);
       translate(mx*wallW,my*wallW, -35);
       momieBehind(); 
      my=((frameCount/50)-(mx))%(LAB_SIZE-1);
      
      
    }
   
    else if(my+dy>=0 && my+dy<LAB_SIZE && mx+dx>=0 && mx+dx<LAB_SIZE &&
      labyrinthe[my+dy][mx+dx]!='#' && dx==1 && dy==0 ) {
        //println(frameCount/50);
        println("boucle 2 my = "+ my+ ", mx= "+mx);
        pushMatrix();
        translate(mx*wallW,my*wallW, -35);
        rotateX(-PI/2);
        rotateY(PI/2);
        scale(0.1);
        shape(mommie);
  
        popMatrix(); 
       
        mx=((frameCount/50)-(my))%(LAB_SIZE-1);
        //mx=((frameCount/50))%(LAB_SIZE-1);
        /*if(labyrinthe[my+dy][mx+dx]=='#'){
          println("enter and dx= "+ dx + "dy "+ dy);
          dy=floor(random(-1,1));
          dx=floor(random(-1,1));
        }      
      }
      else if(my+dy>=0 && my+dy<LAB_SIZE && mx+dx>=0 && mx+dx<LAB_SIZE &&
      labyrinthe[my-dy][mx-dx]!='#' && dx==0 && dy==-1 ) {
        //println(frameCount/50);
        println("boucle 3 my = "+ my+ ", mx= "+mx);
        pushMatrix();
    //mommie.rotateZ(-PI/4);
        translate(mx*wallW,my*wallW, -35);
        rotateX(-PI/2);
        rotateY(PI/2);
        scale(0.1);
        shape(mommie);
  
        popMatrix(); 
        rotateY(-PI/2);
        my=((frameCount/50)-(mx-dy))%(LAB_SIZE-1);
        //mx=((frameCount/50))%(LAB_SIZE-1);
        /*if(labyrinthe[my+dy][mx+dx]=='#'){
            println("enter and dx= "+ dx + "dy "+ dy);
            dy=floor(random(-1,1));
            dx=floor(random(-1,1));
        }       
      }
      else if(my+dy>=0 && my+dy<LAB_SIZE && mx+dx>=0 && mx+dx<LAB_SIZE &&
      labyrinthe[my-dy][mx-dx]!='#' && dx==-1 && dy==0 ) {
        //println(frameCount/50);
        println("boucle 4 my = "+ my+ ", mx= "+mx);
        pushMatrix();
    //mommie.rotateZ(-PI/4);
        translate(mx*wallW,my*wallW, -35);
        rotateX(PI/2);
        //rotateY(PI/2);
        scale(0.1);
        shape(mommie);
  
        popMatrix(); 
        //rotateY(-PI/2);
        mx=((frameCount/50)-(my-dx))%(LAB_SIZE-1);
        //mx=((frameCount/50))%(LAB_SIZE-1);
        /*if(labyrinthe[my+dy][mx+dx]=='#'){
            println("enter and dx= "+ dx + "dy "+ dy);
            dy=floor(random(-1,1));
            dx=floor(random(-1,1));
        }      
      }
      if(my+dy>=0 && my+dy<LAB_SIZE && mx+dx>=0 && mx+dx<LAB_SIZE && labyrinthe[my+dy][mx+dx]=='#' || (dy==0 && dx==0) || (dy==1 && dx==1) || (dy==-1 && dx==-1)){
       // println("enter and dx= "+ dx + "dy "+ dy);
        dy=int(random(-2,2));
        dx=int(random(-2,2));
        println("enter and dx= "+ dx + " dy "+ dy);
         println("boucle 2 my = "+ my+ ", mx= "+mx);
      }
     

    /*if(labyrinthe[my+dy][mx-dx]=='#'){
      println("enter");
      int temp=dx;
      dx=-dy;
      dy=temp;
    }*/
  
  
  shape(exterior);
}

void keyPressed() {

  if (key=='l') inLab = !inLab;

  if (anim==0 && keyCode==38) {
    if(posX+dirX>=0 && posX+dirX<LAB_SIZE && posY+dirY>=0 && posY+dirY<LAB_SIZE) {
      if (labyrinthe[posY+dirY][posX+dirX]!='#') {
        posX+=dirX; 
        posY+=dirY;
        anim=20;
        animT = true;
        animR = false;
        //deplace[posY+dirY][posX+dirX]
        //mx=posX;
        //my=posY;
        
      }
    } else {
        posX+=dirX; 
        posY+=dirY;
        anim=20;
        animT = true;
        animR = false;
    }
  }
  //println("position après une touche up : coordonée en X " +posX +" ,coordonée en Y " + posY);
  if (anim==0 && keyCode==40 && labyrinthe[posY-dirY][posX-dirX]!='#') {
    posX-=dirX; 
    posY-=dirY;
    //mx=posX;
    //my=posY;
    
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
  //println("Position après une touche droit : coordonée en X " +posX +" ,coordonée en Y " + posY);
}


void laby(){
  todig = 0;
  for (int j=0; j<LAB_SIZE; j++) {
    for (int i=0; i<LAB_SIZE; i++) {
      if (j%2==1 && i%2==1) {
        labyrinthe[j][i] = '.';
        todig ++;
      } else  labyrinthe[j][i] = '#';
    }
  }


 labyrinthe[0][1] = ' '; // entree
 labyrinthe[LAB_SIZE-2][LAB_SIZE-1] = ' '; // sortie
}

void deplacement(){
  
  for (int j=0; j<LAB_SIZE; j++) {
    for (int i=0; i<LAB_SIZE; i++) {
      if(i==0 && labyrinthe[j][i]=='#') deplace[j][i]=true;
      else if(j==0 && labyrinthe[j][i]=='#') deplace [j][i]=true;
      else if(j==LAB_SIZE-1 && labyrinthe[j][i]=='#') deplace[j][i]=true;
      else if(i==LAB_SIZE-1 && labyrinthe[j][i]=='#') deplace[j][i]=true;
      else deplace[j][i]=false;
    }
  }
}


void side(){
  for (int j=0; j<LAB_SIZE; j++) {
    for (int i=0; i<LAB_SIZE; i++) {
      sides[j][i][0] = 0;
      sides[j][i][1] = 0;
      sides[j][i][2] = 0;
      sides[j][i][3] = 0;
    }
  }
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
}




void Mommie(){
  mommie= createShape(GROUP);
  float da=PI/25.0;
  //creer la main droite
  main1= loadShape("hand1.obj");
  main1.scale(5);
  main1.translate(-2,-185,190);
  
  //creer la main gauche
  main2= loadShape("hand2.obj");
  main2.scale(5);
  main2.translate(12,-185,190);
  
  //draw body without the head
  body= createShape();
  body.beginShape(QUAD_STRIP);
  body.noStroke();
  body.rotateX(PI/2);
  for (int i=-200; i<=200; i++){
    float a = i/20.0*2*PI;
    float b = i/30.0*2*PI;
    float re = 3+cos(PI/6);
    float n = 20+192*noise(i/10.);
    body.fill(n,n,50);
    float RBig = 50+8*cos(i*PI/200);
    float R2 = RBig+cos(b);
    body.vertex(R2*cos(a), R2*sin(a),re+i);
    
    RBig = 50+8*cos((i+25)*PI/200);
    R2 = RBig+cos(b);
    body.vertex(R2*cos(a+da), R2*sin(a+da), re+(i+25));

  }
  body.endShape(CLOSE);
  
  
  //draw the head
  head= createShape();
  head.beginShape(QUAD_STRIP);
  head.noStroke();
  head.rotateX(PI/2);
  head.beginShape(QUAD_STRIP);
  //head.translate(0,0,-200);
  for (int i=-95; i<=60; i++){
    float a = i/20.0*2*PI;
    float b = i/30.0*2*PI;
    float n = 20+192*noise(i/10.);
    float re =250+cos(30.0);
    head.fill(n,n,50);
    float RBig = 15+35*cos(i*PI/200);
    float R2 = RBig+cos(b);
    head.vertex(R2*cos(a), R2*sin(a), re+i);
    RBig = 15+35*cos((i+25)*PI/200);
    R2 = RBig+cos(b);
    head.vertex(R2*cos(a+da), R2*sin(a+da),re+i+25);
  }
  head.endShape(CLOSE);
  
   
  //draw the left hand
  hands= createShape();
  hands.scale(0.8);
  hands.beginShape(QUAD_STRIP);
  hands.rotateX(-PI/35.);
  hands.translate(-40,-180,50);
  //hands.rotateZ(PI/2);
  hands.noStroke();
  int  ii=-90;
  int max=0;
  for(int j = 1;j<34;j++){
     for (int i=ii ; i<=50-max; i++){
      float a = i/50.0*2*PI;
      float n = 20+192*noise(i/10.);
      float re = 30+cos(30.0);
      hands.fill(n,n,50);
      float RBig,R2;
      RBig = 10+(max)+15*cos(i*PI/200);
      R2 = RBig*cos(a);
      hands.vertex(R2*cos(a), R2*sin(a), re+i);
      
      RBig = 10+(max)+15*cos((i+25)*PI/200);
      R2 = RBig*cos(a);
      hands.vertex(R2*cos(a), R2*sin(a),re+(i+25));
     }
       ii++;
       max++;
    }
   max=0;
   ii=-90;
  for(int j = 1;j<34;j++){
    for (int i=ii ; i<=50-max; i++){
          float a = i/50.0*2*PI;
          float n = 20+192*noise(i/10.);
          float re = 150+cos(30.0);
          hands.fill(n,n,50);
          float RBig,R2;
          RBig = 10+max+15*cos(i*PI/200);
          R2 = RBig*cos(a);
          hands.vertex(R2*cos(a), R2*sin(a), re+i);
          
          RBig = 10+max+15*cos((i+25)*PI/200);
          R2 = RBig*cos(a);
          hands.vertex(R2*cos(a), R2*sin(a),re+(i+25));
          
         }
           ii++;
           max++;
       }
      hands.endShape(CLOSE);
      
      
      
  //draw the right hand
  hand= createShape();
  hand.scale(0.8);
  hand.beginShape(QUAD_STRIP);
  hand.rotateX(-PI/35.);
  hand.translate(15,-180,55);
  hand.noStroke();
  ii=-90;
  max=0;
  for(int j = 1;j<34;j++){
     for (int i=ii ; i<=50-max; i++){
      float a = i/50.0*2*PI;
      float n = 20+192*noise(i/10.);
      float re = 30+cos(30.0);
      hand.fill(n,n,50);
      float RBig,R2;
      RBig = 10+(max)+15*cos(i*PI/200);
      R2 = RBig*cos(a);
      hand.vertex(R2*cos(a), R2*sin(a), re+i);
      
      RBig = 10+(max)+15*cos((i+25)*PI/200);
      R2 = RBig*cos(a);
      hand.vertex(R2*cos(a), R2*sin(a),re+(i+25));
      
     }
       ii++;
       max++;
    }
   max=0;
   ii=-90;
  for(int j = 1;j<34;j++){
    for (int i=ii ; i<=50-max; i++){
      float a = i/50.0*2*PI;
      float n = 20+192*noise(i/10.);
      float re = 150+cos(30.0);
      hand.fill(n,n,50);
      float RBig,R2;
      RBig = 10+max+15*cos(i*PI/200);
      R2 = RBig*cos(a);
      hand.vertex(R2*cos(a), R2*sin(a), re+i);
      
      RBig = 10+max+15*cos((i+25)*PI/200);
      R2 = RBig*cos(a);
      hand.vertex(R2*cos(a), R2*sin(a),re+(i+25));
      
     }
           ii++;
           max++;
     }

  
    
      hand.endShape(CLOSE);
  
  //l'oeil de droite
  eye1=createShape(SPHERE, 10 );
  eye1.translate(-16,-280,40);  
  eye1.setStroke(false);
  
  eyeball1=createShape(SPHERE, 5 );
  eyeball1.translate(-16,-280,45);
  eyeball1.setFill(color(0));
  
  //l'oeil de gauche
  eye2=createShape(SPHERE, 10 );
  eye2.translate(16,-280,40);
  eye2.setStroke(false);
  
  eyeball2=createShape(SPHERE, 5 );
  eyeball2.translate(16,-280,45);
  eyeball2.setFill(color(0));
 
 //ajouter tout les differents membres de la mommie
  mommie.addChild(body);
  mommie.addChild(head);
  mommie.addChild(hands);
  mommie.addChild(hand);
  mommie.addChild(eye1);
  mommie.addChild(eyeball1);
  mommie.addChild(eye2);
  mommie.addChild(eyeball2);
  mommie.addChild(main1);
  mommie.addChild(main2);
  
}

void Pyramide() {
  sand = createShape();
  sand.beginShape(QUAD);
  sand.texture(texture4);
  sand.noStroke();
  for(int i = -21; i < 21 * 2; i++) {
     for(int j = -21; j < 21 * 2; j++) {
      sand.vertex(wallLen * i, wallLen * j, 0, 
                           0*texture4.height, 0*texture4.width);
      sand.vertex(wallLen * i, wallLen * (j + 1), 0, 
                           0*texture4.height, 1*texture4.width);
      sand.vertex(wallLen * (i + 1), wallLen * (j + 1), 0,   
                           1*texture4.height, 1*texture4.width);
      sand.vertex(wallLen * (i + 1), wallLen * j, 0,  
                           1*texture4.height, 0*texture4.width);
    }
  }
  sand.endShape();
  
  wallVertical = createShape();
  wallVertical.beginShape(QUAD);
  wallVertical.texture(texture3);
  wallVertical.noStroke();
  
  wallHorizontal = createShape();
  wallHorizontal.beginShape(QUAD);
  wallHorizontal.texture(texture3);  
  wallHorizontal.noStroke();
  
  float shift = 0;
  textureWrap(REPEAT);
  for(int j = LAB_SIZE + 2; j >0; j -= 2) {
    
    shift = (2 + LAB_SIZE - j)/2.0 * wallLen;
    
    for(int i = 0; i < j; i++) {
      wallVertical.vertex(wallLen * i + shift, shift, shift, 
                        1*texture3.width, 0 * texture3.height*2);
      wallVertical.vertex(wallLen * i + shift, shift, wallLen + shift, 
                        1*texture3.width, 1 * texture3.height*2);
      wallVertical.vertex(wallLen * (i + 1) + shift, shift, wallLen + shift, 
                        0*texture3.width, 1 * texture3.height*2);
      wallVertical.vertex(wallLen * (i + 1) + shift, shift, shift, 
                        0*texture3.width, 0 * texture3.height*2);
      
      wallVertical.vertex(shift, wallLen * i + shift, shift, 
                        1*texture3.width, 0 * texture3.height*2);
      wallVertical.vertex(shift, wallLen * i + shift, wallLen + shift, 
                        1*texture3.width, 1 * texture3.height*2);
      wallVertical.vertex(shift, wallLen * (i + 1) + shift, wallLen + shift, 
                        0*texture3.width, 1 * texture3.height*2);
      wallVertical.vertex(shift, wallLen * (i + 1) + shift, shift, 
                        0*texture3.width, 0 * texture3.height*2);
      
      wallVertical.vertex(wallLen * i + shift, j * wallLen + shift, shift, 
                        1*texture3.width, 0 * texture3.height*2);
      wallVertical.vertex(wallLen * i + shift, j * wallLen + shift, wallLen + shift, 
                        1*texture3.width, 1 * texture3.height*2);
      wallVertical.vertex(wallLen * (i + 1) + shift, j * wallLen + shift, wallLen + shift, 
                        0*texture3.width, 1 * texture3.height*2);
      wallVertical.vertex(wallLen * (i + 1) + shift, j * wallLen + shift, shift, 
                        0*texture3.width, 0 * texture3.height*2);
      
      wallVertical.vertex(j * wallLen + shift, wallLen * i + shift, shift, 
                       1*texture3.width, 0 * texture3.height*2);;
      wallVertical.vertex(j * wallLen + shift, wallLen * i + shift, wallLen + shift, 
                       1*texture3.width, 1 * texture3.height*2);
      wallVertical.vertex(j * wallLen + shift, wallLen * (i + 1) + shift, wallLen + shift, 
                          0*texture3.width, 1 * texture3.height*2);
      wallVertical.vertex(j * wallLen + shift, wallLen * (i + 1) + shift, shift, 
                          0*texture3.width, 0 * texture3.height*2);
    }
    
    for(int i = 0; i < j; i++) {
        wallHorizontal.normal(0, 0, 1);
        wallHorizontal.vertex(wallLen * i + shift, shift, wallLen + shift, 
                             0*texture3.height, 0 * texture3.width);
        wallHorizontal.vertex(wallLen * i + shift, shift + wallLen, wallLen + shift,  
                             0*texture3.height, 1 * texture3.width);
        wallHorizontal.vertex(wallLen * (i + 1) + shift, shift + wallLen, wallLen + shift,  
                             1*texture3.height, 1 * texture3.width);
        wallHorizontal.vertex(wallLen * (i + 1) + shift, shift, wallLen + shift,  
                             1*texture3.height, 0 * texture3.width);
        
        wallHorizontal.normal(0, 0, 1);
        wallHorizontal.vertex(shift, wallLen * i + shift, wallLen + shift, 
                             0*texture3.height, 0 * texture3.width);
        wallHorizontal.vertex(shift + wallLen, wallLen * i + shift, wallLen + shift,  
                             0*texture3.height, 1 * texture3.width);
        wallHorizontal.vertex(shift + wallLen, wallLen * (i + 1) + shift, wallLen + shift,  
                             1*texture3.height, 1 * texture3.width);
        wallHorizontal.vertex(shift, wallLen * (i + 1) + shift, wallLen + shift,  
                             1*texture3.height, 0 * texture3.width);
        
        wallHorizontal.normal(0, 0, 1);
        wallHorizontal.vertex(wallLen * i + shift, (j - 1) * wallLen + shift, wallLen + shift, 
                             0*texture3.height, 0 * texture3.width);
        wallHorizontal.vertex(wallLen * i + shift, j * wallLen + shift, wallLen + shift,  
                             0*texture3.height, 1 * texture3.width);
        wallHorizontal.vertex(wallLen * (i + 1) + shift, j * wallLen + shift, wallLen + shift,  
                             1*texture3.height, 1 * texture3.width);
        wallHorizontal.vertex(wallLen * (i + 1) + shift, (j - 1) * wallLen + shift, wallLen + shift,  
                             1*texture3.height, 0 * texture3.width);
         
        wallHorizontal.normal(0, 0, 1);
        wallHorizontal.vertex((j - 1) * wallLen + shift, wallLen * i + shift, wallLen + shift, 
                             0*texture3.height, 0 * texture3.width);
         wallHorizontal.vertex(j * wallLen + shift, wallLen * i + shift, wallLen + shift,  
                            0*texture3.height, 1 * texture3.width);
        wallHorizontal.vertex(j * wallLen + shift, wallLen * (i + 1) + shift, wallLen + shift,  
                             1*texture3.height, 1 * texture3.width);
        wallHorizontal.vertex((j - 1) * wallLen + shift, wallLen * (i + 1) + shift, wallLen + shift,  
                             1*texture3.height, 0 * texture3.width);
    }
  }
  wallVertical.endShape();
  wallHorizontal.endShape();
  
  exterior = createShape(GROUP);
  exterior.addChild(wallVertical);
  exterior.addChild(wallHorizontal);
  exterior.addChild(sand);
  exterior.translate(-wallLen*1.5, -wallLen*1.5, -wallLen);
  exterior.scale(1, 1, 2);
}
