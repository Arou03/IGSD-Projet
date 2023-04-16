/*float wallw=width/LAB_SIZE;
float wallh=height/LAB_SIZE;
PShape wallVertical;
PShape wallHorizontal;


void pyra(){
  pyramid=createShape(GROUP);
   wallVertical = createShape();
   wallVertical.beginShape(QUAD);
   
   wallHorizontal = createShape();
   wallHorizontal.beginShape(QUAD);
   
   wallVertical.texture(texture0);
   wallHorizontal.texture(texture0);
   
   wallVertical.noStroke();
   wallHorizontal.noStroke();
   float shift = 0;
   for(int j = LAB_SIZE-1; j >=0; j -= 2) {
     
     shift = 2*(LAB_SIZE - j)/2 * wallw;
     
     for(int i = 1; i < j; i++) {
         wallHorizontal.vertex(wallw * i + shift, shift, wallw+ shift, 
                              (0/2.0)*texture0.height, 0 * texture0.width);
         wallHorizontal.vertex(wallw * i + shift, shift + wallh, wallw + shift,  
                              (0/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex(wallw * (i + 1) + shift, shift + wallh, wallw + shift,  
                              (1/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex(wallw * (i + 1) + shift, shift, wallh + shift,  
                              (1/2.0)*texture0.height, 0 * texture0.width);
         
         wallHorizontal.vertex(shift, wallw * i + shift, wallh + shift, 
                              (0/2.0)*texture0.height, 0 * texture0.width);
         wallHorizontal.vertex(shift + wallw, wallh * i + shift, wallh+ shift,  
                              (0/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex(shift + wallw, wallh * (i + 1) + shift, wallw + shift,  
                              (1/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex(shift, wallh* (i + 1) + shift, wallw + shift,  
                              (1/2.0)*texture0.height, 0 * texture0.width);
         
         wallHorizontal.vertex(wallw * i + shift, (j - 1) * wallh+ shift, wallw + shift, 
                              (0/2.0)*texture0.height, 0 * texture0.width);
         wallHorizontal.vertex(wallw * i + shift, j * wallh + shift, wallw + shift,  
                              (0/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex(wallw * (i + 1) + shift, j * wallh + shift, wallw + shift,  
                              (1/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex(wallw * (i + 1) + shift, (j - 1) * wallh + shift, wallw + shift,  
                              (1/2.0)*texture0.height, 0 * texture0.width);
         
         wallHorizontal.vertex((j - 1) * wallw + shift, wallh * i + shift, wallw + shift, 
                              (0/2.0)*texture0.height, 0 * texture0.width);
         wallHorizontal.vertex(j * wallw + shift, wallh * i + shift, wallw + shift,  
                              (0/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex(j * wallw + shift, wallh * (i + 1) + shift, wallw + shift,  
                              (1/2.0)*texture0.height, 1 * texture0.width);
         wallHorizontal.vertex((j - 1) * wallw + shift, wallh * (i + 1) + shift, wallw + shift,  
                              (1/2.0)*texture0.height, 0 * texture0.width);
     }
     for(int i = 0; i < j; i++) {
       wallVertical.vertex(wallw * i + shift, shift, shift, 
                         1*texture0.width, 0 * texture0.height/2.0);
       wallVertical.vertex(wallw * i + shift, shift, wallw + shift, 
                         1*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(wallw * (i + 1) + shift, shift, wallw + shift, 
                         0*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(wallw * (i + 1) + shift, shift, shift, 
                         0*texture0.width, 0 * texture0.height/2.0);
       
       wallVertical.vertex(shift, wallh * i + shift, shift, 
                         1*texture0.width, 0 * texture0.height/2.0);
       wallVertical.vertex(shift, wallh* i + shift, wallh + shift, 
                         1*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(shift, wallh * (i + 1) + shift, wallw + shift, 
                         0*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(shift, wallw * (i + 1) + shift, shift, 
                         0*texture0.width, 0 * texture0.height/2.0);
       
       wallVertical.vertex(wallw * i + shift, j * wallh + shift, shift, 
                         1*texture0.width, 0 * texture0.height/2.0);
       wallVertical.vertex(wallw * i + shift, j * wallh + shift, wallw + shift, 
                         1*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(wallw * (i + 1) + shift, j * wallh + shift, wallw + shift, 
                         0*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(wallw * (i + 1) + shift, j * wallh + shift, shift, 
                         0*texture0.width, 0 * texture0.height/2.0);
       
       wallVertical.vertex(j * wallw + shift, wallh * i + shift, shift, 
                         1*texture0.width, 0 * texture0.height/2.0);;
       wallVertical.vertex(j * wallw + shift, wallh * i + shift, wallw + shift, 
                         1*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(j * wallw + shift, wallh * (i + 1) + shift, wallw + shift, 
                         0*texture0.width, 1 * texture0.height/2.0);
       wallVertical.vertex(j * wallw + shift, wallh * (i + 1) + shift, shift, 
                         0*texture0.width, 0 * texture0.height/2.0);
     }
   }
   wallVertical.endShape();
   wallHorizontal.endShape();
   pyramid.addChild(wallVertical);
   pyramid.addChild(wallHorizontal);
}*/

PShape pyramide,maze[];



void pyramide(){
  
  pyramide= createShape(GROUP);
  maze=new PShape[8];
  //pyramide.beginShape();
  int size = 0;;
  for( int j = 0; j<8; j++){
    size = j * 2 + 5;
    maze[j]= createShape(GROUP);
    //drawLaby(j, i);
    Laby(j, size);
    lightLaby(j, size);
    maze[j].addChild(laby0[j],10);
    maze[j].addChild(laby1[j]);
    maze[j].addChild(ceiling0[j]);
    pyramide.addChild(maze[j]);
  }
  

}
