final static float SPA_X = 5;
final static float SPA_Y = 5;

float x = 0;
float y = 0;

PVector pos;

boolean finish = false;

void setup() {
  //size(200, 200);
  fullScreen();
  background(0);
}

void draw() {
  if (!finish) {
    stroke(255);

    int r = floor(random(4));

    pos = new PVector(x, y);

    Shape a = selectForm(r);

    a.show();

    x += SPA_X;

    if ( x > width) {
      if ( y > height) finish = true;
      y += SPA_Y;
      x = 0;
    }
  }
}

Shape selectForm(int form) {
  switch(form) {
  case 0:
    return new Slash(pos);
  case 1:
    return new BackSlash(pos);
  case 2: 
    return new VerticalLine(pos);
  case 3:
    return new HorizontalLine(pos);
  default:
    return null;
  }
}