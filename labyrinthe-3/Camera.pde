void setCamera(int SIZE){
  float wallW = width/SIZE;
  float wallH = height/SIZE;
  if (inLab) {
    perspective(2*PI/3, float(width)/float(height), 1, 10000);
    if (animT)
      camera((posX-dirX*anim/20.0)*wallW,      (posY-dirY*anim/20.0)*wallH,      -15+2*sin(anim*PI/5.0), 
             (posX-dirX*anim/20.0+dirX)*wallW, (posY-dirY*anim/20.0+dirY)*wallH, -15+4*sin(anim*PI/5.0), 0, 0, -1);
    else if (animR)
      camera(posX*wallW, posY*wallH, -15, 
            (posX+(odirX*anim+dirX*(20-anim))/20.0)*wallW, (posY+(odirY*anim+dirY*(20-anim))/20.0)*wallH, -15-5*sin(anim*PI/20.0), 0, 0, -1);
    else {
      camera(posX*wallW, posY*wallH, -15, 
             (posX+dirX)*wallW, (posY+dirY)*wallH, -15, 0, 0, -1);
    }
    //camera((posX-dirX*anim/20.0)*wallW, (posY-dirY*anim/20.0)*wallH, -15+6*sin(anim*PI/20.0), 
    //  (posX+dirX-dirX*anim/20.0)*wallW, (posY+dirY-dirY*anim/20.0)*wallH, -15+10*sin(anim*PI/20.0), 0, 0, -1);

    //lightFalloff(0.0, 0.01, 0.0001);
    //spotLight(255, 255, 255, 
              ///posX*wallW, posY*wallH, -15,
              //dirX, dirY, -1,
              //PI/2.0, 1);
      if(outlab){
           ambientLight(50,50,50);
           pointLight(255, 255, 255, posX*wallW, posY*wallH, 15);
      }else{
          lightFalloff(0.0, 0.01, 0.0001);
          //ambientLight(15,15,15);
          pointLight(255, 255, 255, posX*wallW, posY*wallH, 15);
        }
  } else{
    lightFalloff(0.0, 0.05, 0.0001);
    pointLight(255, 255, 255, posX*wallW, posY*wallH, 15);
    camera(posX*wallW, posY*wallH, -15, 
             (posX+dirX)*wallW, (posY+dirY)*wallH, -15, 0, 0, -1);
  }

}
