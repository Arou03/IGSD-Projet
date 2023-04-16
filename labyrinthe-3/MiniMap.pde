void drawMiniMap(int SIZE, int etage) {
  float wallW = width/SIZE;
  float wallH = height/SIZE;
  for (int j=0; j<SIZE; j++) {
    for (int i=0; i<SIZE; i++) {
      //if( posY+dirY>-1 && posX+dirX>-1 && posX+dirX<SIZE-1 &&
     //posY+dirY<SIZE-1 && inLab && !outlab) {deplace[etage][posY+dirY][posX+dirX]=true;}
      if (labyrinthe[etage][j][i]=='#'&& deplace[etage][j][i]) {
        fill(i*25, j*25, 255-i*10+j*10);
        pushMatrix();
        translate(50+i*wallW/8, 50+j*wallH/8, 50);
        box(wallW/10, wallH/10, 5);
        popMatrix();
         if(i>0 && j>0 && j<SIZE-1 && i<SIZE-1){
            deplace[etage][j-1][i-1]=true;
            deplace[etage][j-1][i]=true;
            deplace[etage][j+1][i]=true;
            deplace[etage][j][i-1]= true;
            deplace[etage][j+1][i+1]= true;
            deplace[etage][j+1][i]=true;
            deplace[etage][j][i+1]=true;
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
}
