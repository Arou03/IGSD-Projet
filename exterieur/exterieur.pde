
int LAB_SIZE = 21;
float wallW = 1000/LAB_SIZE;
float wallH = 1000/LAB_SIZE;
PShape murVertical;
PShape murHorizontal;

float spectX = 0;
float spectY = 0;
float spectZ = 0;

float centerX;
float centerY;
float centerZ;

PImage  texture0;

void setup() {
   randomSeed(2);
   size(1000, 1000, P3D);
   
   texture0 = loadImage("stones.jpg");
   
   murVertical = createShape();
   murVertical.beginShape(QUAD);
   
   murHorizontal = createShape();
   murHorizontal.beginShape(QUAD);
   
   murVertical.texture(texture0);
   murHorizontal.texture(texture0);
   
   murVertical.noStroke();
   murHorizontal.noStroke();
   float decal = 0;
   for(int arete = LAB_SIZE + 2; arete >0; arete -= 2) {
     
     decal = (2 + LAB_SIZE - arete) * (wallH+wallW)/4;
     
     for(int i = 0; i < arete; i++) {
         murHorizontal.fill(i*255/arete, 255-(i*255/arete+arete*1255/LAB_SIZE), arete*255/LAB_SIZE);
         murHorizontal.rotateZ(PI/2);
         murHorizontal.vertex(wallH * i + decal, 0 + decal, (wallH + wallW) + decal * 2, 
                              ((0)/2.0)*texture0.height, (0)*texture0.width);
         murHorizontal.vertex(wallH * i + decal, 0 + decal + ((wallH + wallW)/2), (wallH + wallW) + decal * 2,  
                              ((0)/2.0)*texture0.height, (1)*texture0.width);
         murHorizontal.vertex(wallH * (i + 1) + decal, 0 + decal + ((wallH + wallW)/2), (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture0.height, (1)*texture0.width);
         murHorizontal.vertex(wallH * (i + 1) + decal, 0 + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture0.height, (0)*texture0.width);
         
         murHorizontal.vertex(0 + decal, wallH * i + decal, (wallH + wallW) + decal * 2, 
                              ((0)/2.0)*texture0.height, (0)*texture0.width);
         murHorizontal.vertex(0 + decal + ((wallH + wallW)/2), wallH * i + decal, (wallH + wallW) + decal * 2,  
                              ((0)/2.0)*texture0.height, (1)*texture0.width);
         murHorizontal.vertex(0 + decal + ((wallH + wallW)/2), wallH * (i + 1) + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture0.height, (1)*texture0.width);
         murHorizontal.vertex(0 + decal, wallH * (i + 1) + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture0.height, (0)*texture0.width);
         
         
         murHorizontal.vertex(wallH * i + decal, (arete - 1) * wallW + decal, (wallH + wallW) + decal * 2, 
                              ((0)/2.0)*texture0.height, (0)*texture0.width);
         murHorizontal.vertex(wallH * i + decal, (arete - 1) * wallW + decal + ((wallH + wallW)/2), (wallH + wallW) + decal * 2,  
                              ((0)/2.0)*texture0.height, (1)*texture0.width);
         murHorizontal.vertex(wallH * (i + 1) + decal, (arete - 1) * wallW + decal + ((wallH + wallW)/2), (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture0.height, (1)*texture0.width);
         murHorizontal.vertex(wallH * (i + 1) + decal, (arete - 1) * wallW + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture0.height, (0)*texture0.width);
         
         murHorizontal.vertex((arete - 1) * wallH + decal, wallH * i + decal, (wallH + wallW) + decal * 2, 
                              ((0)/2.0)*texture0.height, (0)*texture0.width);
         murHorizontal.vertex((arete - 1) * wallH + decal + ((wallH + wallW)/2), wallH * i + decal, (wallH + wallW) + decal * 2,  
                              ((0)/2.0)*texture0.height, (1)*texture0.width);
         murHorizontal.vertex((arete - 1) * wallH + decal + ((wallH + wallW)/2), wallH * (i + 1) + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture0.height, (1)*texture0.width);
         murHorizontal.vertex((arete - 1) * wallH + decal, wallH * (i + 1) + decal, (wallH + wallW) + decal * 2,  
                              ((1)/2.0)*texture0.height, (0)*texture0.width);
     }
     
     
     for(int h = 0; h < (wallH + wallW); h+=((wallH + wallW)/2)) { 
       for(int i = 0; i < arete; i++) {
         murVertical.fill(i*255/arete, 255-(i*255/arete+arete*1255/LAB_SIZE), arete*255/LAB_SIZE);
         
         murVertical.vertex(wallW * i + decal, 0 + decal, h+0 + decal * 2, 
                           (1)*texture0.width, (0)*texture0.height/2.0);
         murVertical.vertex(wallH * i + decal, 0 + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (1)*texture0.width, (1)*texture0.height/2.0);
         murVertical.vertex(wallH * (i + 1) + decal, 0 + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (0)*texture0.width, (1)*texture0.height/2.0);
         murVertical.vertex(wallW * (i + 1) + decal, 0 + decal, h+0 + decal * 2, 
                           (0)*texture0.width, (0)*texture0.height/2.0);
         
         murVertical.vertex(0 + decal, wallW * i + decal, h+0 + decal * 2, 
                           (1)*texture0.width, (0)*texture0.height/2.0);
         murVertical.vertex(0 + decal, wallH * i + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (1)*texture0.width, (1)*texture0.height/2.0);
         murVertical.vertex(0 + decal, wallH * (i + 1) + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (0)*texture0.width, (1)*texture0.height/2.0);
         murVertical.vertex(0 + decal, wallW * (i + 1) + decal, h+0 + decal * 2, 
                           (0)*texture0.width, (0)*texture0.height/2.0);
         
         murVertical.vertex(wallW * i + decal, arete * wallW + decal, h+0 + decal * 2, 
                           (1)*texture0.width, (0)*texture0.height/2.0);
         murVertical.vertex(wallH * i + decal, arete * wallW + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (1)*texture0.width, (1)*texture0.height/2.0);
         murVertical.vertex(wallH * (i + 1) + decal, arete * wallW + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (0)*texture0.width, (1)*texture0.height/2.0);
         murVertical.vertex(wallW * (i + 1) + decal, arete * wallW + decal, h+0 + decal * 2, 
                           (0)*texture0.width, (0)*texture0.height/2.0);
         
         murVertical.vertex(arete * wallH + decal, wallW * i + decal, h+0 + decal * 2, 
                           (1)*texture0.width, (0)*texture0.height/2.0);;
         murVertical.vertex(arete * wallH + decal, wallH * i + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (1)*texture0.width, (1)*texture0.height/2.0);
         murVertical.vertex(arete * wallH + decal, wallH * (i + 1) + decal, h+((wallH + wallW)/2) + decal * 2, 
                           (0)*texture0.width, (1)*texture0.height/2.0);
         murVertical.vertex(arete * wallH + decal, wallW * (i + 1) + decal, h+0 + decal * 2, 
                           (0)*texture0.width, (0)*texture0.height/2.0);
       }
     }
   }
   murVertical.endShape();
   murHorizontal.endShape();
   
}

void draw() {
  background(192);
  perspective(2*PI/3.0, float(width)/float(height), 1, 1500);
  cam();
  translate(0, (1)*wallH, -((wallH + wallW)/2));
  shape(murVertical);
  shape(murHorizontal);
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
