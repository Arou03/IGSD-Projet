
int LAB_SIZE = 21;
float wallW = 1000/LAB_SIZE;
float wallH = 1000/LAB_SIZE;
PShape murVertical;
PShape murHorizontal;
PShape Sable;
PShape soleil;

float spectX = 0;
float spectY = 0;
float spectZ = 0;

float centerX;
float centerY;
float centerZ;

PImage texture2;
PImage texture3;

PShape exterieur;

void setup() {
   pixelDensity(2);
   randomSeed(2);
   size(1000, 1000, P3D);
   
   texture2 = loadImage("stones_exterior.jpg");
   texture3 = loadImage("sable.jpg");
   
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
         murHorizontal.normal(0, 0, 1);
         murHorizontal.fill(i*255/arete, 255-(i*255/arete+arete*1255/LAB_SIZE), arete*255/LAB_SIZE);
         murHorizontal.rotateZ(PI/2);
         murHorizontal.vertex(wallH * i + decal, 0 + decal, (wallH + wallW) + decal * 2, 
                              ((0)/2.0)*texture2.height, (0)*texture2.width);
         murHorizontal.vertex(wallH * i + decal, 0 + decal + ((wallH + wallW)/2), (wallH + wallW) + decal * 2,  
                              ((0)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex(wallH * (i + 1) + decal, 0 + decal + ((wallH + wallW)/2), (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex(wallH * (i + 1) + decal, 0 + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (0)*texture2.width);
         
         murHorizontal.vertex(0 + decal, wallH * i + decal, (wallH + wallW) + decal * 2, 
                              ((0)/2.0)*texture2.height, (0)*texture2.width);
         murHorizontal.vertex(0 + decal + ((wallH + wallW)/2), wallH * i + decal, (wallH + wallW) + decal * 2,  
                              ((0)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex(0 + decal + ((wallH + wallW)/2), wallH * (i + 1) + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex(0 + decal, wallH * (i + 1) + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (0)*texture2.width);
         
         
         murHorizontal.vertex(wallH * i + decal, (arete - 1) * wallW + decal, (wallH + wallW) + decal * 2, 
                              ((0)/2.0)*texture2.height, (0)*texture2.width);
         murHorizontal.vertex(wallH * i + decal, (arete - 1) * wallW + decal + ((wallH + wallW)/2), (wallH + wallW) + decal * 2,  
                              ((0)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex(wallH * (i + 1) + decal, (arete - 1) * wallW + decal + ((wallH + wallW)/2), (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex(wallH * (i + 1) + decal, (arete - 1) * wallW + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (0)*texture2.width);
         
         murHorizontal.vertex((arete - 1) * wallH + decal, wallH * i + decal, (wallH + wallW) + decal * 2, 
                              ((0)/2.0)*texture2.height, (0)*texture2.width);
         murHorizontal.vertex((arete - 1) * wallH + decal + ((wallH + wallW)/2), wallH * i + decal, (wallH + wallW) + decal * 2,  
                              ((0)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex((arete - 1) * wallH + decal + ((wallH + wallW)/2), wallH * (i + 1) + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (1)*texture2.width);
         murHorizontal.vertex((arete - 1) * wallH + decal, wallH * (i + 1) + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture2.height, (0)*texture2.width);
     }
     
     
     for(int h = 0; h < (wallH + wallW); h+=((wallH + wallW)/2)) { 
       for(int i = 0; i < arete; i++) {
         murVertical.fill(i*255/arete, 255-(i*255/arete+arete*1255/LAB_SIZE), arete*255/LAB_SIZE);
         murVertical.normal(-1, 0, 0);
         murVertical.vertex(wallW * i + decal, 0 + decal, h+0 + decal * 2, 
                           (1)*texture2.width, (0)*texture2.height/2.0);
         murVertical.vertex(wallH * i + decal, 0 + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (1)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(wallH * (i + 1) + decal, 0 + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (0)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(wallW * (i + 1) + decal, 0 + decal, h+0 + decal * 2, 
                           (0)*texture2.width, (0)*texture2.height/2.0);
         murVertical.normal(0, -1, 0);
         murVertical.vertex(0 + decal, wallW * i + decal, h+0 + decal * 2, 
                           (1)*texture2.width, (0)*texture2.height/2.0);
         murVertical.vertex(0 + decal, wallH * i + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (1)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(0 + decal, wallH * (i + 1) + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (0)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(0 + decal, wallW * (i + 1) + decal, h+0 + decal * 2, 
                           (0)*texture2.width, (0)*texture2.height/2.0);
         murVertical.normal(1, 0, 0);
         murVertical.vertex(wallW * i + decal, arete * wallW + decal, h+0 + decal * 2, 
                           (1)*texture2.width, (0)*texture2.height/2.0);
         murVertical.vertex(wallH * i + decal, arete * wallW + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (1)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(wallH * (i + 1) + decal, arete * wallW + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (0)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(wallW * (i + 1) + decal, arete * wallW + decal, h+0 + decal * 2, 
                           (0)*texture2.width, (0)*texture2.height/2.0);
         murVertical.normal(0, 1, 0);
         murVertical.vertex(arete * wallH + decal, wallW * i + decal, h+0 + decal * 2, 
                           (1)*texture2.width, (0)*texture2.height/2.0);;
         murVertical.vertex(arete * wallH + decal, wallH * i + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (1)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(arete * wallH + decal, wallH * (i + 1) + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (0)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(arete * wallH + decal, wallW * (i + 1) + decal, h+0 + decal * 2, 
                           (0)*texture2.width, (0)*texture2.height/2.0);
       }
     }
   }
   murVertical.endShape();
   murHorizontal.endShape();
   
   Sable = createShape();
   Sable.beginShape(QUAD);
   Sable.texture(texture3);
   Sable.noStroke();
   PVector v1;
   PVector v2; 
   PVector v3;
   for(int i = -21; i < 21 * 2; i++) {
     for(int j = -21; j < 21 * 2; j++) {
       Sable.vertex(wallH * i, wallW * j, noise(i, j) * 10, 
                            (0)*texture3.height, (0)*texture3.width);
       Sable.vertex(wallH * i, wallW * (j + 1), noise(i, j+1) * 10, 
                            (0)*texture3.height, (1)*texture3.width);
       Sable.vertex(wallH * (i + 1), wallW * (j + 1), noise(i+1, j+1) * 10,   
                            (1)*texture3.height, (1)*texture3.width);
       Sable.vertex(wallH * (i + 1), wallW * j, noise(i+1, j) * 10,  
                            (1)*texture3.height, (0)*texture3.width);
       v1 = new PVector(1, 0, noise(i, j) + noise(i+1, j));
       v2 = new PVector(0, 1, noise(i, j) + noise(i, j+1));
       v3 = v1.cross(v2);
       Sable.normal(v3.x, v3.y, v3.z);
     }
   }
   Sable.endShape();
   
   soleil = createShape(SPHERE, 100);
   soleil.setStroke(0);
   soleil.setFill(color(255, 255, 200));
   soleil.translate(200, 200, 1000);
   
   exterieur.addChild(murVertical);
   exterieur.addChild(murHorizontal);
   exterieur.addChild(soleil);
   exterieur.addChild(Sable);
}

void draw() {
  background(135, 206, 235);
  sphereDetail(6);
  perspective(2*PI/3.0, float(width)/float(height), 1, 1500);
  noLights();
  lightFalloff(0.0, 0.01, 0.0001);
  translate(0, (1)*wallH, -((wallH + wallW)/2));
  shape(exterieur);
  pointLight(255, 255, 200, 
             200, 200, 1000);
  cam();
}

void cam() {
  float rotationAngle = map(mouseX, 0, width, 0, TWO_PI);
  float elevationAngle = map(mouseY, 0, height, 0, PI);

  centerX = cos(rotationAngle) * sin(elevationAngle);
  centerY = sin(rotationAngle) * sin(elevationAngle);
  centerZ = -cos(elevationAngle);
  camera(spectX, spectY, spectZ, 
        centerX + spectX, centerY + spectY, centerZ + spectZ, 
        0, 0, -1);
}

void keyPressed() {
  if (keyCode==38) {
    spectX += centerX * 15;
    spectY += centerY * 15;
    spectZ += centerZ * 15;
  }
  if (keyCode==40) {
    spectX -= centerX * 15;
    spectY -= centerY * 15;
    spectZ -= centerZ * 15;
  }
  if (keyCode==37) {
    spectX += centerY * 15;
    spectY -= centerX * 15;
  }
  if (keyCode==39) {
    spectX -= centerY * 15;
    spectY += centerX * 15;
  }
}
