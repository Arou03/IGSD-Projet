void keyPressed() {
  if(inLab && anim==0) mouvementMomie();
  if (key=='l') {
    inLab = !inLab;
    println("you are " + inLab + " inLab");
  }

  if (anim==0 && keyCode==38 && inLab) {
    if (posX+dirX>=0 && posX+dirX<currentFloor * 2 + 5 && posY+dirY>=0 && posY+dirY<currentFloor * 2 + 5) {
      if(labyrinthe[currentFloor][posY+dirY][posX+dirX]!='#') {
        posX+=dirX; 
        posY+=dirY;
        anim=20;
        animT = true;
        animR = false;
      }
    } else {
      if(currentFloor == 8) {
        posX+=dirX; 
        posY+=dirY;
        anim=20;
        animT = true;
        animR = false;
      }
    }
  }
  if (anim==0 && keyCode==40  && inLab) {
    if (posX-dirX>=0 && posX-dirX<currentFloor * 2 + 5 && posY-dirY>=0 && posY-dirY<currentFloor * 2 + 5 &&
      labyrinthe[currentFloor][posY-dirY][posX-dirX]!='#') {
      posX-=dirX; 
      posY-=dirY;
      anim=-20;
      animT = true;
      animR = false;
    }
  }
  if (anim==0 && keyCode==37 && inLab) {
    odirX = dirX;
    odirY = dirY;
    anim = 20;
    int tmp = dirX; 
    dirX=dirY; 
    dirY=-tmp;
    animT = false;
    animR = true;
  }
  if (anim==0 && keyCode==39 && inLab) {
    odirX = dirX;
    odirY = dirY;
    anim = 20;
    animT = false;
    animR = true;
    int tmp = dirX; 
    dirX=-dirY; 
    dirY=tmp;
  }
  
  if (keyCode==38 && !inLab) {
    spectX += centerX * 15;
    spectY += centerY * 15;
    spectZ += centerZ * 15;
  }
  if (keyCode==40 && !inLab) {
    spectX -= centerX * 15;
    spectY -= centerY * 15;
    spectZ -= centerZ * 15;
  }
  if (keyCode==37 && !inLab) {
    spectX += centerY * 15;
    spectY -= centerX * 15;
  }
  if (keyCode==39 && !inLab) {
    spectX -= centerY * 15;
    spectY += centerX * 15;
  }
  if (keyCode==32 && inLab && labyrinthe[currentFloor][posY][posX] =='s') {
    if(currentFloor < 8) {
      posX = iposX;
      posY = iposY;
      dirX = 0;
      dirY = 1;
      currentFloor++;
      mX = imX;
      mY = imY;
    }
  }   
}
