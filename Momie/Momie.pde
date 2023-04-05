
int LAB_SIZE = 21;
float wallW = 1000/LAB_SIZE;
float wallH = 1000/LAB_SIZE;
PShape corps;
PShape tete;

void setup() {
  randomSeed(2);
   size(1000,1000, P3D);
   
   
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
}

void draw() {
  background(192);
  perspective(2*PI/3.0, float(width)/float(height), 1, 1000);
  camera(0, 0, -15, 
         0, 1*wallH, -15, 
         0, 0, -1);
  translate(0, (1)*wallH, -50);
  rotateZ(frameCount/20.0);
  shape(corps);
  shape(tete);
}
