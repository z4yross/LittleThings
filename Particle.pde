class Particle {

  float maxSpeed = 4;

  int i = 0;
  int j = 0;

  PVector pos;
  PVector speed;
  PVector acc;

  PVector prv;

  Particle() {
    this.pos = new PVector((int)random(width), (int)random(height));
    this.speed = new PVector(0,0);
    this.acc = new PVector(0,0);

    this.prv = this.pos.copy();
  }

  void update() {
    speed.add(acc);
    speed.limit(maxSpeed);
    pos.add(speed);
    acc.mult(0);
  }

  void appF(PVector f) {
    acc.add(f);
  }
  
  void updatePrv() {
    prv.x = pos.x;
    prv.y = pos.y;
  }

  void buscarVect() {
    int i = int(pos.x / size);
    int j = int(pos.y / size);

    PVector posVect = vectors[i][j];
    appF(posVect);
  }

  void show() {
    pushMatrix();
    fill(255);
    stroke(255, 15);
    //noStroke();
    line(prv.x, prv.y, pos.x, pos.y);
    popMatrix();
    updatePrv();
  }

  void edges() {
    if (pos.x > width-1) {
      pos.x = 0;
      updatePrv();
    }
    if (pos.x < 0) {
      pos.x = width-1;
      updatePrv();
    }
    if (pos.y > height-1) {
      pos.y = 0;
      updatePrv();
    }
    if (pos.y < 0) {
      pos.y = height-1;
      updatePrv();
    }
  }
}