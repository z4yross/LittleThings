final float incX = 0.02;
final float incY = 0.02;
final float incZ = 0.02;

final float size = 20;

final int cant = 100;

int rectX;
int rectY;

float offZ;

PVector[][] vectors;

Particle[] particles;

void setup() {
  fullScreen();
  background(0);
  rectX = floor(width/size);
  rectY = floor(height/size);

  offZ = 0;

  vectors = new PVector[rectX][rectY];

  particles = new Particle[cant];
  for (int i = 0; i < cant; i ++) particles[i] = new Particle();
}

void draw() {
  //background(0);

  offZ += incZ;
  float offX = 0;
  for (int i = 0; i < rectX; i++) {
    offX += incX;
    float offY = 0;
    for (int j = 0; j < rectY; j++) {
      offY += incY;  

      float perlin = noise(offX, offY, offZ);
      //float bW = nois*255;
      float angle = perlin*TWO_PI*3;

      PVector a = PVector.fromAngle(angle);
      a.setMag(size);
      vectors[i][j] = a;

      //pushMatrix();
      //{
      //  translate(i * size, j * size);
      //  strokeWeight(1);
      //  stroke(255);
      //  rotate(a.heading());
      //  line(0, 0, a.x, a.y);
      //}
      //popMatrix();
    }
  } 
  for (Particle a : particles) {
    a.buscarVect();
    a.update();
    a.edges();
    a.show();
  }
}