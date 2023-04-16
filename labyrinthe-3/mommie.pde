

void Mommie(){
  
  
  mommie= createShape(GROUP);
  float da=PI/25.0;
  //creer la main droite
  main1= loadShape("hand1.obj");
  main1.scale(5);
  main1.translate(-2,-185,190);
  
  //creer la main gauche
  main2= loadShape("hand2.obj");
  main2.scale(5);
  main2.translate(12,-185,190);
  
  //draw body without the head
  body= createShape();
  body.beginShape(QUAD_STRIP);
  body.noStroke();
  body.rotateX(PI/2);
  for (int i=-200; i<=200; i++){
    float a = i/20.0*2*PI;
    float b = i/30.0*2*PI;
    float re = 3+cos(PI/6);
    float n = 20+192*noise(i/10.);
    body.fill(n,n,50);
    float RBig = 50+8*cos(i*PI/200);
    float R2 = RBig+cos(b);
    body.vertex(R2*cos(a), R2*sin(a),re+i);
    
    RBig = 50+8*cos((i+25)*PI/200);
    R2 = RBig+cos(b);
    body.vertex(R2*cos(a+da), R2*sin(a+da), re+(i+25));

  }
  body.endShape(CLOSE);
  
  
  //draw the head
  head= createShape();
  head.beginShape(QUAD_STRIP);
  head.noStroke();
  head.rotateX(PI/2);
  head.beginShape(QUAD_STRIP);
  //head.translate(0,0,-200);
  for (int i=-95; i<=60; i++){
    float a = i/20.0*2*PI;
    float b = i/30.0*2*PI;
    float n = 20+192*noise(i/10.);
    float re =250+cos(30.0);
    head.fill(n,n,50);
    float RBig = 15+35*cos(i*PI/200);
    float R2 = RBig+cos(b);
    head.vertex(R2*cos(a), R2*sin(a), re+i);
    RBig = 15+35*cos((i+25)*PI/200);
    R2 = RBig+cos(b);
    head.vertex(R2*cos(a+da), R2*sin(a+da),re+i+25);
  }
  head.endShape(CLOSE);
  
   
  //draw the left hand
  hands= createShape();
  hands.scale(0.8);
  hands.beginShape(QUAD_STRIP);
  hands.rotateX(-PI/35.);
  hands.translate(-40,-180,50);
  //hands.rotateZ(PI/2);
  hands.noStroke();
  int  ii=-90;
  int max=0;
  for(int j = 1;j<34;j++){
     for (int i=ii ; i<=50-max; i++){
      float a = i/50.0*2*PI;
      float n = 20+192*noise(i/10.);
      float re = 30+cos(30.0);
      hands.fill(n,n,50);
      float RBig,R2;
      RBig = 10+(max)+15*cos(i*PI/200);
      R2 = RBig*cos(a);
      hands.vertex(R2*cos(a), R2*sin(a), re+i);
      
      RBig = 10+(max)+15*cos((i+25)*PI/200);
      R2 = RBig*cos(a);
      hands.vertex(R2*cos(a), R2*sin(a),re+(i+25));
     }
       ii++;
       max++;
    }
   max=0;
   ii=-90;
  for(int j = 1;j<34;j++){
    for (int i=ii ; i<=50-max; i++){
          float a = i/50.0*2*PI;
          float n = 20+192*noise(i/10.);
          float re = 150+cos(30.0);
          hands.fill(n,n,50);
          float RBig,R2;
          RBig = 10+max+15*cos(i*PI/200);
          R2 = RBig*cos(a);
          hands.vertex(R2*cos(a), R2*sin(a), re+i);
          
          RBig = 10+max+15*cos((i+25)*PI/200);
          R2 = RBig*cos(a);
          hands.vertex(R2*cos(a), R2*sin(a),re+(i+25));
          
         }
           ii++;
           max++;
       }
      hands.endShape(CLOSE);
      
      
      
  //draw the right hand
  hand= createShape();
  hand.scale(0.8);
  hand.beginShape(QUAD_STRIP);
  hand.rotateX(-PI/35.);
  hand.translate(15,-180,55);
  hand.noStroke();
  ii=-90;
  max=0;
  for(int j = 1;j<34;j++){
     for (int i=ii ; i<=50-max; i++){
      float a = i/50.0*2*PI;
      float n = 20+192*noise(i/10.);
      float re = 30+cos(30.0);
      hand.fill(n,n,50);
      float RBig,R2;
      RBig = 10+(max)+15*cos(i*PI/200);
      R2 = RBig*cos(a);
      hand.vertex(R2*cos(a), R2*sin(a), re+i);
      
      RBig = 10+(max)+15*cos((i+25)*PI/200);
      R2 = RBig*cos(a);
      hand.vertex(R2*cos(a), R2*sin(a),re+(i+25));
      
     }
       ii++;
       max++;
    }
   max=0;
   ii=-90;
  for(int j = 1;j<34;j++){
    for (int i=ii ; i<=50-max; i++){
      float a = i/50.0*2*PI;
      float n = 20+192*noise(i/10.);
      float re = 150+cos(30.0);
      hand.fill(n,n,50);
      float RBig,R2;
      RBig = 10+max+15*cos(i*PI/200);
      R2 = RBig*cos(a);
      hand.vertex(R2*cos(a), R2*sin(a), re+i);
      
      RBig = 10+max+15*cos((i+25)*PI/200);
      R2 = RBig*cos(a);
      hand.vertex(R2*cos(a), R2*sin(a),re+(i+25));
      
     }
           ii++;
           max++;
     }

  
    
      hand.endShape(CLOSE);
  
  //l'oeil de droite
  eye1=createShape(SPHERE, 10 );
  eye1.translate(-16,-280,40);  
  eye1.setStroke(false);
  
  eyeball1=createShape(SPHERE, 5 );
  eyeball1.translate(-16,-280,45);
  eyeball1.setFill(color(0));
  
  //l'oeil de gauche
  eye2=createShape(SPHERE, 10 );
  eye2.translate(16,-280,40);
  eye2.setStroke(false);
  
  eyeball2=createShape(SPHERE, 5 );
  eyeball2.translate(16,-280,45);
  eyeball2.setFill(color(0));
 
 //ajouter tout les differents membres de la mommie
  mommie.addChild(body);
  mommie.addChild(head);
  mommie.addChild(hands);
  mommie.addChild(hand);
  mommie.addChild(eye1);
  mommie.addChild(eyeball1);
  mommie.addChild(eye2);
  mommie.addChild(eyeball2);
  mommie.addChild(main1);
  mommie.addChild(main2);
  
}
