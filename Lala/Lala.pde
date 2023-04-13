
int LAB_SIZE = 21;
float wallLen = 1000/LAB_SIZE;
PShape wallVertical;
PShape wallHorizontal;
PShape sand;
//TO_REMOVE
float spectX = 0;
float spectY = 0;
float spectZ = 0;

float centerX;
float centerY;
float centerZ;
//JUSQU'ICI
PImage texture0;
PImage texture1;

void setup() {
   randomSeed(2);
   size(1000, 1000, P3D);
   
   texture0 = loadImage("stones.jpg");
   texture1 = loadImage("sand.png");
   
   sand = createShape();
   sand.beginShape(QUAD);
   sand.texture(texture1);
   sand.noStroke();
   for(int i = -21; i < 21 * 2; i++) {
     for(int j = -21; j < 21 * 2; j++) {
       sand.vertex(wallLen * i, wallLen * j, noise(i/10.0, j/10.0), 
                            0*texture1.height, 0*texture1.width);
       sand.vertex(wallLen * i, wallLen * (j + 1), noise(i/10.0, j/10.0), 
                            0*texture1.height, 1*texture1.width);
       sand.vertex(wallLen * (i + 1), wallLen * (j + 1), noise(i/10.0, j/10.0),   
                            1*texture1.height, 1*texture1.width);
       sand.vertex(wallLen * (i + 1), wallLen * j, noise(i/10.0, j/10.0),  
                            1*texture1.height, 0*texture1.width);
     }
   }
   sand.endShape();
   
   wallVertical = createShape();
   wallVertical.beginShape(QUAD);
   
   wallHorizontal = createShape();
   wallHorizontal.beginShape(QUAD);
   
   wallVertical.texture(texture0);
   wallHorizontal.texture(texture0);
   
   wallVertical.noStroke();
   wallHorizontal.noStroke();
   float shift = 0;
   for(int j = LAB_SIZE + 2; j >0; j -= 2) {
     
     shift = (2 + LAB_SIZE - j)/2 * wallLen;
     
     for(int i = 0; i < j; i++) {
         wallHorizontal.vertex(wallLen * i + shift, shift, wallLen + shift, 
                              (0/2.0)*texture0.height, 0 * texture0.width);
         wallHorizontal.vertex(wallLen * i + shift, shift + wallLen, wallLen + shift,  
                              (0/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex(wallLen * (i + 1) + shift, shift + wallLen, wallLen + shift,  
                              (1/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex(wallLen * (i + 1) + shift, shift, wallLen + shift,  
                              (1/2.0)*texture0.height, 0 * texture0.width);
         
         wallHorizontal.vertex(shift, wallLen * i + shift, wallLen + shift, 
                              (0/2.0)*texture0.height, 0 * texture0.width);
         wallHorizontal.vertex(shift + wallLen, wallLen * i + shift, wallLen + shift,  
                              (0/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex(shift + wallLen, wallLen * (i + 1) + shift, wallLen + shift,  
                              (1/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex(shift, wallLen * (i + 1) + shift, wallLen + shift,  
                              (1/2.0)*texture0.height, 0 * texture0.width);
         
         wallHorizontal.vertex(wallLen * i + shift, (j - 1) * wallLen + shift, wallLen + shift, 
                              (0/2.0)*texture0.height, 0 * texture0.width);
         wallHorizontal.vertex(wallLen * i + shift, j * wallLen + shift, wallLen + shift,  
                              (0/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex(wallLen * (i + 1) + shift, j * wallLen + shift, wallLen + shift,  
                              (1/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex(wallLen * (i + 1) + shift, (j - 1) * wallLen + shift, wallLen + shift,  
                              (1/2.0)*texture0.height, 0 * texture0.width);
         
         wallHorizontal.vertex((j - 1) * wallLen + shift, wallLen * i + shift, wallLen + shift, 
                              (0/2.0)*texture0.height, 0 * texture0.width);
         wallHorizontal.vertex(j * wallLen + shift, wallLen * i + shift, wallLen + shift,  
                              (0/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex(j * wallLen + shift, wallLen * (i + 1) + shift, wallLen + shift,  
                              (1/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex((j - 1) * wallLen + shift, wallLen * (i + 1) + shift, wallLen + shift,  
                              (1/2.0)*texture0.height, 0 * texture0.width);
     }
     for(int i = 0; i < j; i++) {
       wallVertical.vertex(wallLen * i + shift, shift, shift, 
                         1*texture0.width, 0 * texture0.height/2.0);
       wallVertical.vertex(wallLen * i + shift, shift, wallLen + shift, 
                         1*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(wallLen * (i + 1) + shift, shift, wallLen + shift, 
                         0*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(wallLen * (i + 1) + shift, shift, shift, 
                         0*texture0.width, 0 * texture0.height/2.0);
       
       wallVertical.vertex(shift, wallLen * i + shift, shift, 
                         1*texture0.width, 0 * texture0.height/2.0);
       wallVertical.vertex(shift, wallLen * i + shift, wallLen + shift, 
                         1*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(shift, wallLen * (i + 1) + shift, wallLen + shift, 
                         0*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(shift, wallLen * (i + 1) + shift, shift, 
                         0*texture0.width, 0 * texture0.height/2.0);
       
       wallVertical.vertex(wallLen * i + shift, j * wallLen + shift, shift, 
                         1*texture0.width, 0 * texture0.height/2.0);
       wallVertical.vertex(wallLen * i + shift, j * wallLen + shift, wallLen + shift, 
                         1*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(wallLen * (i + 1) + shift, j * wallLen + shift, wallLen + shift, 
                         0*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(wallLen * (i + 1) + shift, j * wallLen + shift, shift, 
                         0*texture0.width, 0 * texture0.height/2.0);
       
       wallVertical.vertex(j * wallLen + shift, wallLen * i + shift, shift, 
                         1*texture0.width, 0 * texture0.height/2.0);;
       wallVertical.vertex(j * wallLen + shift, wallLen * i + shift, wallLen + shift, 
                         1*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(j * wallLen + shift, wallLen * (i + 1) + shift, wallLen + shift, 
                         0*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(j * wallLen + shift, wallLen * (i + 1) + shift, shift, 
                         0*texture0.width, 0 * texture0.height/2.0);
     }
   }
   wallVertical.endShape();
   wallHorizontal.endShape();
}

void draw() {
  background(120, 170, 220);
  perspective();
  cam(); //TO_REMOVE
  translate(wallLen, wallLen, -wallLen);
  shape(wallVertical);
  shape(wallHorizontal);
  shape(sand);
}

//TO_REMOVE
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
//JUSQU'ICI
