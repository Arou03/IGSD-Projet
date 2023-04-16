float wallLen = 4000/LAB_SIZE;
PShape sand;
PImage texture2;

void sand() {
   
   texture2 = loadImage("sand.png");
   
   sand = createShape();
   sand.beginShape(QUAD);
   sand.texture(texture2);
   sand.noStroke();
   for(int j = -LAB_SIZE; j < LAB_SIZE*2; j++) {
     for(int i = -LAB_SIZE; i < LAB_SIZE*2; i++) {
       sand.vertex(wallLen * i-wallLen/2, wallLen * j-wallLen/2, -60+noise(-30, 30), 
                            0, 0);
       sand.vertex(wallLen * i+wallLen/2, wallLen * j-wallLen/2, -60+noise(-30, 30), 
                            0, 0*texture2.height);
       sand.vertex(wallLen *i + wallLen/2, wallLen * j + wallLen/2,-60+ noise(-30, 30),   
                            texture2.width, texture2.height);
       sand.vertex(wallLen * i - wallLen/2, wallLen * j+wallLen/2, -60+noise(-30, 30),  
                            texture2.width, 0);
        
     }
   }
   sand.endShape();
}
