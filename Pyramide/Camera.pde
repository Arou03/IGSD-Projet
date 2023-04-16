
void setupCam(int SIZE) {
  float wallW = width/SIZE;
  float wallH = height/SIZE;
  if (inLab) {
    perspective(2*PI/3, float(width)/float(height), 1, 10000);
    if (animT) {
      cX = (posX-dirX*anim/20.0)*wallW; cY = (posY-dirY*anim/20.0)*wallH; cZ = -15+2*sin(anim*PI/5.0);
      camera(cX, cY, cZ, 
             (posX-dirX*anim/20.0+dirX)*wallW, (posY-dirY*anim/20.0+dirY)*wallH, -15+2*sin(anim*PI/5.0), 0, 0, -1);
    } else if (animR) {
      camera(posX*wallW, posY*wallH, -15, 
            (posX+(odirX*anim+dirX*(20-anim))/20.0)*wallW, (posY+(odirY*anim+dirY*(20-anim))/20.0)*wallH, -15-5*sin(anim*PI/20.0), 0, 0, -1);
    } else {
      cX = posX*wallW; cY = posY*wallH; cZ = -15;
      camera(cX, cY, cZ, 
             (posX+dirX)*wallW, (posY+dirY)*wallH, -15, 0, 0, -1);
    }
    
    //camera((posX-dirX*anim/20.0)*wallW, (posY-dirY*anim/20.0)*wallH, -15+6*sin(anim*PI/20.0), 
    //  (posX+dirX-dirX*anim/20.0)*wallW, (posY+dirY-dirY*anim/20.0)*wallH, -15+10*sin(anim*PI/20.0), 0, 0, -1);
    if(posX < LAB_SIZE && posY < LAB_SIZE) ambientLight(54, 48, 26);
    else ambientLight(189, 172, 113);
    lightFalloff(0, 0.01, 0.0001);
    pointLight(255*4/5, 255*7/10, 255*2/5, 
               cX, cY, cZ);
    
  } else{
    perspective(2*PI/3, float(width)/float(height), 1, 10000);
    float rotationAngle = map(mouseX, 0, width, 0, TWO_PI);
    float elevationAngle = map(mouseY, 0, height, 0, PI);
  
    centerX = cos(rotationAngle) * sin(elevationAngle);
    centerY = sin(rotationAngle) * sin(elevationAngle);
    centerZ = -cos(elevationAngle);
    camera(spectX, spectY, spectZ, 
          centerX + spectX, centerY + spectY, centerZ + spectZ, 
          0, 0, -1);
    ambientLight(54, 48, 26);
    lightFalloff(1, 0.001, 0.00001);
    pointLight(255*4/5, 255*7/10, 255*2/5,
               spectX, spectY, spectZ);
  }
}
