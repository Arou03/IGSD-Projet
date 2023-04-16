PShape boussole;

void drawBoussole() {
  boussole = createShape();
  /**
  boussole.beginShape();
  for(float i = 0; i < PI * 2; i+= 0.5) {
    boussole.vertex(200 * cos(i), 200 * sin(i), 0);
  }
  boussole.endShape(CLOSE);
  boussole.setFill(255);
  
  boussole.resetMatrix();
  boussole.rotateX(-PI/2.0);
  boussole.rotateZ(PI);
  boussole.translate(posX * wallW, posY * wallW + wallW *2, boussole.height/2.0);
  **/
  //boussole.translate(posX * wallW, posY * wallW + wallW *2, 0);
  boussole.beginShape();
  boussole.fill(255);
  boussole.noStroke();
  boussole.texture(texture4);
  int segments = 32; // nombre de segments pour le cercle
  float angleStep = 2 * PI / segments;
  float radius = 1;
  for (int i = 0; i < segments; i+=segments/4.0) {
    float x = cos(i * angleStep) * radius;
    float y = sin(i * angleStep) * radius;
    if(i == 0) boussole.vertex(x, 0, y, (x + 1) * texture4.width/2.0, (y + 1) * texture4.height/2.0);
    if(i == 8) boussole.vertex(x, 0, y, (x + 1) * texture4.width/2.0, (y + 1) * texture4.height/2.0);
    if(i == 16) boussole.vertex(x, 0, y, (x + 1) * texture4.width/2.0, (y + 1) * texture4.height/2.0);
    if(i == 24) boussole.vertex(x, 0, y, (x + 1) * texture4.width/2.0, (y + 1) * texture4.height/2.0);
    //boussole.vertex(x, 0, y);
  }
  boussole.endShape(CLOSE);
  boussole.resetMatrix();
  if(dirX != 0) boussole.rotateZ(dirX * -PI/2.0);
  if(dirY == -1) boussole.rotateY(dirY * PI);
  if(dirX == 1) boussole.rotateX(-dirX * PI/2.0);
  if(dirX == -1) boussole.rotateX(dirX * PI/2.0);
  boussole.translate(cX + dirX * (2) + dirY * 2, 
                     cY + dirY * (2) - dirX * 2, 
                     cZ + boussole.height/2.0 - 1.25);
  shape(boussole);
}
