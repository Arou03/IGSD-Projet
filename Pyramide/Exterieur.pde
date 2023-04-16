PShape murVertical;
PShape murHorizontal;
PShape Sable;

PShape exterieur;

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
         //murHorizontal.fill(i*255/arete, 255-(i*255/arete+arete*1255/LAB_SIZE), arete*255/LAB_SIZE);
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
         //murVertical.fill(i*255/arete, 255-(i*255/arete+arete*1255/LAB_SIZE), arete*255/LAB_SIZE);
         
         murVertical.normal(0, 1, 0);
         murVertical.vertex(wallW * i + decal, 0 + decal, h+0 + decal * 2, 
                           (1)*texture2.width, (0)*texture2.height/2.0);
         murVertical.vertex(wallH * i + decal, 0 + decal, h+((wallH+wallW)/2) + decal * 2, 
                           (1)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(wallH * (i + 1) + decal, 0 + decal, h+((wallH+wallW)/2) + decal * 2, 
                           (0)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(wallW * (i + 1) + decal, 0 + decal, h+0 + decal * 2, 
                           (0)*texture2.width, (0)*texture2.height/2.0);
         
         murVertical.normal(-1, 0, 0);
         murVertical.vertex(0 + decal, wallW * i + decal, h+0 + decal * 2, 
                           (1)*texture2.width, (0)*texture2.height/2.0);
         murVertical.vertex(0 + decal, wallH * i + decal, h+((wallH+wallW)/2) + decal * 2, 
                           (1)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(0 + decal, wallH * (i + 1) + decal, h+((wallH+wallW)/2) + decal * 2, 
                           (0)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(0 + decal, wallW * (i + 1) + decal, h+0 + decal * 2, 
                           (0)*texture2.width, (0)*texture2.height/2.0);
         
         murVertical.normal(0, 1, 0);
         murVertical.vertex(wallW * i + decal, arete * wallW + decal, h+0 + decal * 2, 
                           (1)*texture2.width, (0)*texture2.height/2.0);
         murVertical.vertex(wallH * i + decal, arete * wallW + decal, h+((wallH+wallW)/2) + decal * 2, 
                           (1)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(wallH * (i + 1) + decal, arete * wallW + decal, h+((wallH+wallW)/2) + decal * 2, 
                           (0)*texture2.width, (1)*texture2.height/2.0);
         murVertical.vertex(wallW * (i + 1) + decal, arete * wallW + decal, h+0 + decal * 2, 
                           (0)*texture2.width, (0)*texture2.height/2.0);
         if(!(arete == LAB_SIZE + 2 && i == arete - 3)) {
           murVertical.normal(-1, 0, 0);
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
       v1 = new PVector(1 * wallW, 0, noise(i/5.0, j/5.0) * 10 + noise((i+1)/5.0, j/5.0) * 10);
       v1.normalize();
       v2 = new PVector(0, 1 * wallH, noise(i/5.0, j/5.0) * 10 + noise(i/5.0, (j+1)/5.0) * 10);
       v2.normalize();
       v3 = v1.cross(v2);
       v3.normalize();
       Sable.normal(v3.x, v3.y, -v3.z);
       Sable.vertex(wallH * i, wallW * j, noise(i/5.0, j/5.0) * 10, 
                            (0)*texture3.height, (0)*texture3.width);
       Sable.vertex(wallH * i, wallW * (j + 1), noise(i/5.0, (j+1)/5.0) * 10, 
                            (0)*texture3.height, (1)*texture3.width);
       Sable.vertex(wallH * (i + 1), wallW * (j + 1), noise((i+1)/5.0, (j+1)/5.0) * 10,   
                            (1)*texture3.height, (1)*texture3.width);
       Sable.vertex(wallH * (i + 1), wallW * j, noise((i+1)/5.0, j/5.0) * 10,  
                            (1)*texture3.height, (0)*texture3.width);
     }
   }
   Sable.setVisible(true);
   Sable.endShape();
   
   exterieur.addChild(murVertical);
   exterieur.addChild(murHorizontal);
   exterieur.addChild(Sable);
}
