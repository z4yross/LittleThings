import controlP5.*;
import peasy.*;
import java.util.Arrays;

Accordion accordion;
PeasyCam cam;
ControlP5 cp5;

ArrayList<ArrayList<PVector>> shape1;
final float[][] superShapes = { 
  { 2, 0.7, 0.3, 0.2, 3, 100, 100, 100 }, 
  { 7, 0.2, 1.7, 1.7, 7, 0.2, 1.7, 1.7 }, 
  { 2, 1, 1, 1, 4, 1, 1, 1 }, 
  { 6, 1, 1, 1, 3, 1, 1, 1 }, 
  { 3, 1, 1, 1, 6, 2, 1, 1 }, 
  { 1, 0.3, 0.3, 0.3, 0, 1, 1, 1 }, 
  { 6, 0.249776, 47.8198, -0.8625, 7, -76.8867, 0.521395, -56.73 }, 
  { 6, 1000, 1000, 1000, 6, 250, 100, 100 }, 
  { 6, 60, 55, 1000, 6, 250, 100, 100 }, 
  { 8, 60, 100, 30, 2, 10, 10, 10 }, 
  { 3, 0.5, 1.7, 1.7, 2, 10, 10, 10 }, 
  { 5, 0.1, 1.7, 1.7, 1, 0.3, 0.5, 0.5 }, 
  { 0.2, 0.1, 1.7, 1.7, 2, 0.5, 0.2, 0.2 }, 
  { 2.6, 0.1, 1, 2.5, 3, 3, 0.2, 1 }, 
  { 5.7, 0.5, 1, 2.5, 10, 3, 0.2, 1 }, 
  { 5, 1, 1, 1, 3, 100, 100, 100 }, 
  { 6, 0.709889, 46.8299, -0.802, 7, -31.9083, -0.196521, 97.03 }, 
  { 4, 0.375393, 50.7442, -0.657, 9, -74.1592, -0.68202, -41.40 }, 
  { 2, 0.990241, 97.6722, -0.439, 7, -8.11486, -0.807913, 83.9 }, 
  { 2, 0.437933, 13.1909, 0.6489, 1, -21.8776, 0.637533, 68.803 }, 
  { 0, 1, 1, 1, 1, 77.3876, -0.85962, -87.59 }, 
  { 6, 0.173275, 31.5035, -0.9802, 5, 93.3607, -0.327466, 68.91 }, 
  { 6, 0.765169, 52.2728, -0.202, 5, 37.6514, 0.523097, -18.99 }, 
};


int shape;
float[] speed;
int wait;
boolean[] terminada;
boolean again;
final String[] names = {"m", "n1", "n2", "n3", "m1", "n11", "n21", "n31"};

void setup() {
  fullScreen(P3D);
  //size(500, 500, P3D);
  background(0);

  cam = new PeasyCam(this, 3000);
  lights();

  gui();

  speed = new float[superShapes[0].length];
  terminada = new boolean[superShapes[0].length];
  shape = 0;
  wait = 0;
  again = true;
}

void draw() {
  background(0);

  float r = cp5.getController("radius").getValue();
  float pre = cp5.getController("detail").getValue();

  float a = cp5.getController("a").getValue();
  float b = cp5.getController("b").getValue();
  float m = cp5.getController("m").getValue();
  float n1 = cp5.getController("n1").getValue(); 
  float n2 = cp5.getController("n2").getValue();
  float n3 = cp5.getController("n3").getValue(); 

  float a1 = cp5.getController("a1").getValue();
  float b1 = cp5.getController("b").getValue();
  float m1 = cp5.getController("m1").getValue();
  float n11 = cp5.getController("n11").getValue(); 
  float n21 = cp5.getController("n21").getValue();
  float n31 = cp5.getController("n31").getValue();


  if (cp5.getController("ANIMATE").getValue() != 0) {
    float[] f = superShapes[shape];
    float[] act = {m, n1, n2, n3, m1, n11, n21, n31};
    float dis[] = new float[f.length];
    for (int i = 0; i < f.length; i++) dis[i] = abs(f[i]-act[i]);
    if (terminada[0] && terminada[1] && terminada[2] && terminada[3] && terminada[4] && terminada[5] && terminada[6] && terminada[7]) {
      if ( wait > 50) {
        shape = (shape < superShapes.length-1)? shape + 1 : 0;
        wait = 0;
        for (int i = 0; i < terminada.length; i++) terminada[i] = false;
        again = true;
      }
      wait++;
    } else {
      if (again) {
        for (int i = 0; i < dis.length; i++) {
          speed[i] = dis[i]/50;
          again = false;
        }
      } else 
      for (int i = 0; i < names.length; i++)
        if (!terminada[i]) {
          if (dis[i] < speed[i] || dis[i] == 0 || speed[i] == 0 || dis[i] < 0.01) {
            terminada[i] = true;
            cp5.getController(names[i]).setValue(f[i]);
          } else 
          cp5.getController(names[i]).setValue(act[i]+((act[i] < f[i])? speed[i] : -speed[i]));
        }
      printArray(speed);
      printArray(dis);
    }
  } else again = true;


  int type;
  if (cp5.getController("lines").getValue() != 0) type = 2;
  else if (cp5.getController("points").getValue() != 0) type = 1;
  else if (cp5.getController("b&w").getValue() != 0) type = 4;
  else type = 3;

  shape1 = formShape(m, n1, n2, n3, m1, n11, n21, n31, a, b, a1, b1, pre, r);

  {
    pushMatrix();
    setMatrix(getMatrix());
    stroke(255);
    strokeWeight(2);
    drawShape(shape1, type);
    popMatrix();
  }

  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void drawShape(ArrayList<ArrayList<PVector>> shapeDraw, int type) {
  if (type == 1)
    for (ArrayList<PVector> a : shapeDraw) for (PVector p : a)  point(p.x, p.y, p.z);
  else if (type == 2)
    for (int i = 0; i < shapeDraw.size(); i++) {
      ArrayList<PVector> y = shapeDraw.get(i);
      for (int j = 1; j < y.size(); j++) {
        PVector a = y.get(j-1);
        PVector b = y.get(j);
        line(a.x, a.y, a.z, b.x, b.y, b.z);
      }
    } else if (type == 4) {
    pushMatrix();
    pushStyle();
    noStroke();
    beginShape(TRIANGLE_STRIP);
    float z = 0;

    for (int i = 1; i < shapeDraw.size(); i++) {
      ArrayList<PVector> y = shapeDraw.get(i-1);
      ArrayList<PVector> x = shapeDraw.get(i);
      for (int j = 1; j < y.size(); j++) {
        fill(z);
        if (j%2 == 0) z = (z == 0)?255:0; 
        PVector b = x.get(j-1);
        PVector c = y.get(j);
        vertex(b.x, b.y, b.z);
        vertex(c.x, c.y, c.z);
      }
    }
    endShape();
    popStyle();
    popMatrix();
  } else {
    pushMatrix();
    pushStyle();
    noStroke();
    beginShape(TRIANGLE_STRIP);
    for (int i = 1; i < shapeDraw.size(); i++) {
      ArrayList<PVector> y = shapeDraw.get(i-1);
      ArrayList<PVector> x = shapeDraw.get(i);
      for (int j = 1; j < y.size(); j++) {
        fill(cp5.getController("color1").getValue(), 
          map(j, 1, y.size(), cp5.getController("color2").getArrayValue(0), cp5.getController("color2").getArrayValue(1)), 
          map(i, 1, shapeDraw.size(), cp5.getController("color2").getArrayValue(0), cp5.getController("color3").getArrayValue(1)));
        PVector b = x.get(j-1);
        PVector c = y.get(j);
        vertex(b.x, b.y, b.z);
        vertex(c.x, c.y, c.z);
      }
    }
    endShape();
    popStyle();
    popMatrix();
  }
}


ArrayList<ArrayList<PVector>> formShape(float m, float n1, float n2, float n3, float m1, float n11, float n21, float n31, float a, float b, float a1, float b1, float pre, float r) {
  ArrayList<ArrayList<PVector>> shape = new ArrayList();

  for (float i = -PI; i <= PI+PI/pre; i+= PI/pre) {
    float ri = shape(i, m, n1, n2, n3, a, b);
    ArrayList<PVector> s = new ArrayList();
    for (float j = -HALF_PI; j <= HALF_PI; j += PI/pre) {
      float rj = shape(j, m1, n11, n21, n31, a1, b1);
      float x = ri * cos(i) * rj * cos(j);
      float y = ri * sin(i) * rj * cos(j);
      float z = rj * sin(j);
      PVector coor = new PVector(x*r, y*r, z*r);
      s.add(coor);
    }
    shape.add(s);
  }

  return shape;
}

float shape(float i, float m, float n1, float n2, float n3, float a, float b) {
  return pow(pow(abs((1/a)*cos(m*i/4)), n2) + pow(abs((1/b)*sin(m*i/4)), n3), -1/n1);
}

void gui() {

  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);

  Group g1 = cp5.addGroup("SuperShape1")
    .setBackgroundColor(0)
    .setBackgroundHeight(210);

  cp5.addSlider("m")
    .setPosition(20, 20)
    .setSize(400, 20)
    .setRange(0, 20)
    .setValue(0)
    .moveTo(g1);

  cp5.addSlider("n1")
    .setPosition(20, 50)
    .setSize(400, 20)
    .setRange(-100, 1000)
    .setValue(200)
    .moveTo(g1);

  cp5.addSlider("n2")
    .setPosition(20, 80)
    .setSize(400, 20)
    .setRange(-100, 1000)
    .setValue(100)
    .moveTo(g1);

  cp5.addSlider("n3")
    .setPosition(20, 110)
    .setSize(400, 20)
    .setRange(-100, 1000)
    .setValue(200)
    .moveTo(g1);

  cp5.addSlider("a")
    .setPosition(20, 140)
    .setSize(400, 20)
    .setRange(0.45, 1)
    .setValue(1)
    .moveTo(g1);

  cp5.addSlider("b")
    .setPosition(20, 170)
    .setSize(400, 20)
    .setRange(0.45, 1)
    .setValue(1)
    .moveTo(g1);

  Group g2 = cp5.addGroup("SuperShape2")
    .setBackgroundColor(0)
    .setBackgroundHeight(210);

  cp5.addSlider("m1")
    .setPosition(20, 20)
    .setSize(400, 20)
    .setRange(0, 20)
    .setValue(0)
    .moveTo(g2);

  cp5.addSlider("n11")
    .setPosition(20, 50)
    .setSize(400, 20)
    .setRange(-100, 1000)
    .setValue(200)
    .moveTo(g2);

  cp5.addSlider("n21")
    .setPosition(20, 80)
    .setSize(400, 20)
    .setRange(-100, 1000)
    .setValue(100)
    .moveTo(g2);

  cp5.addSlider("n31")
    .setPosition(20, 110)
    .setSize(400, 20)
    .setRange(-100, 1000)
    .setValue(200)
    .moveTo(g2);

  cp5.addSlider("a1")
    .setPosition(20, 140)
    .setSize(400, 20)
    .setRange(0.45, 1)
    .setValue(1)
    .moveTo(g2);

  cp5.addSlider("b1")
    .setPosition(20, 170)
    .setSize(400, 20)
    .setRange(0.45, 1)
    .setValue(1)
    .moveTo(g2);

  Group g3 = cp5.addGroup("general")
    .setBackgroundColor(0)
    .setBackgroundHeight(300);

  cp5.addRadioButton("fill")
    .setPosition(20, 20)
    .setSize(50, 50)
    .setItemsPerRow(5)
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setSpacingColumn(50)
    .addItem("points", 1)
    .addItem("lines", 2)
    .addItem("solid", 3)
    .addItem("b&w", 4)
    .moveTo(g3);

  cp5.addSlider("radius")
    .setPosition(20, 80)
    .setSize(400, 20)
    .setRange(0, 1000)
    .setValue(500)
    .moveTo(g3);

  cp5.addSlider("detail")
    .setPosition(20, 110)
    .setSize(400, 20)
    .setRange(1, 200)
    .setNumberOfTickMarks(200)
    .setValue(82)
    .moveTo(g3);

  cp5.addSlider("color1")
    .setPosition(20, 150)
    .setSize(400, 20)
    .setRange(0, 255)
    .setValue(88)
    .moveTo(g3);

  cp5.addRange("color2")
    .setBroadcast(false) 
    .setPosition(20, 180)
    .setSize(400, 20)
    .setHandleSize(10)
    .setRange(0, 255)
    .setRangeValues(110, 196)
    .setBroadcast(true)
    .moveTo(g3);

  cp5.addRange("color3")
    .setBroadcast(false) 
    .setPosition(20, 210)
    .setSize(400, 20)
    .setHandleSize(10)
    .setRange(0, 255)
    .setRangeValues(171, 177)
    .setBroadcast(true)
    .moveTo(g3);

  cp5.addRadioButton("ANIMATION")
    .setPosition(20, 240)
    .setSize(50, 50)
    .setItemsPerRow(5)
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setSpacingColumn(50)
    .addItem("ANIMATE", 1)
    .moveTo(g3);

  accordion = cp5.addAccordion("contoles")
    .setPosition(10, 10)
    .setWidth(460)
    .addItem(g1)
    .addItem(g2)
    .addItem(g3);

  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.open(0, 1, 2);
    }
  }
  , 'o');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.close(0, 1, 2);
    }
  }
  , 'c');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setWidth(300);
    }
  }
  , '1');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setPosition(0, 0);
      accordion.setItemHeight(190);
    }
  }
  , '2'); 
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setCollapseMode(ControlP5.ALL);
    }
  }
  , '3');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setCollapseMode(ControlP5.SINGLE);
    }
  }
  , '4');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      cp5.remove("myGroup1");
    }
  }
  , '0');

  accordion.open(0, 1, 2);
  accordion.setCollapseMode(Accordion.MULTI);
}