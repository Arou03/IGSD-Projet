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
