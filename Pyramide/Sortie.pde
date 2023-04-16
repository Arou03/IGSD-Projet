PShape teleporteur[];

void initTeleporteur() {
  float r1 = 2;   // rayon du tube
  float r2 = 18;   // rayon du tore
  int segmentsT = 30;  // nombre de segments autour du tube
  int segmentsC = 40;  // nombre de segments autour du cercle central
  teleporteur = new PShape[8];
  for(int etage = 0; etage < 8; etage++) {
    teleporteur[etage] = createShape();
    teleporteur[etage].beginShape(QUAD_STRIP);
    teleporteur[etage].noStroke();
    teleporteur[etage].fill(255);
    for (int i = 0; i <= segmentsT; i++) {
      float tubeAngle = i * TWO_PI / segmentsT;
      float cosTube = cos(tubeAngle);
      float sinTube = sin(tubeAngle);
  
      for (int j = 0; j <= segmentsC; j++) {
        float angle = j * TWO_PI / segmentsC;
        float cosAngle = cos(angle);
        float sinAngle = sin(angle);
  
        float x = (r2 + r1 * cosTube) * cosAngle;
        float y = (r2 + r1 * cosTube) * sinAngle;
        float z = r1 * sinTube;
  
        float nextTubeAngle = (i + 1) * TWO_PI / segmentsT;
        float nextCosTube = cos(nextTubeAngle);
        float nextSinTube = sin(nextTubeAngle);
  
        float nextX = (r2 + r1 * nextCosTube) * cosAngle;
        float nextY = (r2 + r1 * nextCosTube) * sinAngle;
        float nextZ = r1 * nextSinTube;
  
        float angle2 = (j + 1) * TWO_PI / segmentsC;
        float cosAngle2 = cos(angle2);
        float sinAngle2 = sin(angle2);
        float nextNextX = (r2 + r1 * nextCosTube) * cosAngle2;
        float nextNextY = (r2 + r1 * nextCosTube) * sinAngle2;
        float nextNextZ = r1 * nextSinTube;
        
        PVector v1 = new PVector(x - nextX, y - nextY, z - nextZ);
        PVector v2 = new PVector(nextNextX - nextX, nextNextY - nextY, nextNextZ - nextZ);
        PVector normal = v1.cross(v2);
        normal.normalize();
        
        teleporteur[etage].normal(-normal.x, -normal.y, -normal.z);
        teleporteur[etage].vertex(x, y, z);
        teleporteur[etage].vertex(nextX, nextY, nextZ);
      }
    }
    teleporteur[etage].endShape();
    teleporteur[etage].translate((etage*2+5-1)*wallW, (etage*2+5-2)*wallH, -(wallH+wallW)/2);
  }
}
