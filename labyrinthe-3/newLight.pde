

void lightLaby(int etage, int SIZE){ 
  //println(SIZE);
   wallW = width/SIZE;
   wallH = height/SIZE;
  for (int j=0; j<SIZE; j++) {
    for (int i=0; i<SIZE; i++) {
      pushMatrix();
      translate(i*wallW, j*wallH, 0);
      if (labyrinthe[etage][j][i]=='#') {
        beginShape(QUADS);
        if (sides[etage][j][i][3]==1) {
          pushMatrix();
          translate(0, -wallH/2, 40);
          if (i==posX || j==posY) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            //spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            sphere(15);
          }
          popMatrix();
        }

        if (sides[etage][j][i][0]==1) {
          pushMatrix();
          translate(0, wallH/2, 40);
          if (i==posX || j==posY) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            //spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            sphere(15);
          }
          popMatrix();
        }
         
         if (sides[etage][j][i][1]==1) {
          pushMatrix();
          translate(-wallW/2, 0, 40);
          if (i==posX || j==posY) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            //spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            sphere(15);
          }
          popMatrix();
        }
         
        if (sides[etage][j][i][2]==1) {
          pushMatrix();
          translate(0, wallH/2, 40);
          if (i==posX || j==posY) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            //spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            sphere(15);
          }
          popMatrix();
        }
      } 
      popMatrix();
    }
    
    shape(laby1[etage], 0, 0);
    shape(laby0[etage], 0, 0);
     if (inLab){
        shape(laby1[etage], 0, 0);
        if(SIZE==21) shape(sand,0,0);
        shape(ceiling0[etage], 0, 1);
        if(out){
          pushMatrix();
          translate(0,100,0);
          shape(pyramide,0,0);
          popMatrix();
          shape(sand,0,0);
        }
      /*if (outlab){
        //translate(-50,0,0);
        pushMatrix();
        //rotateX(PI/2);
        scale(8);
        shape(pyramid,0,1);
        popMatrix();
        //shape(wallHorizontal,0,0);
     }*/
      
    }else{
      shape(ceiling1[etage], 0, 0);
    }

  }
}
