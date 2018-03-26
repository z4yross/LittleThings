int[] pi;
float offset;
int alph = 255;
color[] coloresA = {
  color(211, 47, 47, alph), 
  color(230, 74, 25, alph), 
  color(245, 124, 0, alph), 
  color(251, 192, 45, alph), 
  color(104, 159, 56, alph), 
  color(0, 151, 167, alph), 
  color(25, 118, 210, alph), 
  color(81, 45, 168, alph), 
  color(123, 31, 162, alph), 
  color(194, 24, 91, alph)
};

color[] colores = {
  color(211, 47, 47), 
  color(230, 74, 25), 
  color(245, 124, 0), 
  color(251, 192, 45), 
  color(104, 159, 56), 
  color(0, 151, 167), 
  color(25, 118, 210), 
  color(81, 45, 168), 
  color(123, 31, 162), 
  color(194, 24, 91)
};

float radius = 500;
int indc = 1;
int index = 0;
int[] rep;

String[] docs = {
  "10_pi.txt", 
  "100_pi.txt", 
  "10K_pi.txt", 
  "100K_pi.txt", 
  "1M_pi.txt", 
  "1KM_pi.txt"
};

void setup() {
  //size(500, 500);
  fullScreen();
  String doc = loadStrings(docs[indc])[0];
  String[] digits = doc.split("");
  pi = int(digits);
  //  printArray  (pi);
  offset = (TWO_PI /10) / (pi.length/((indc == 0)?3:5+indc));
  rep = new int[10];
  background(0);

  translate(width/2, height/2);

  for (int i = 0; i < 10; i++) {
    rep[i] = 0;

    fill(colores[i]);

    float angle = i * (TWO_PI / 10) - HALF_PI;

    float x = (radius-20) * cos(angle);
    float y = (radius-20) * sin(angle);

    textSize(20);
    text(i, x, y);
  }
}

void draw() {
  translate(width/2, height/2);

  //for (int index = 0; index < pi.length-1; index++) {
  if (index < pi.length-1) {
    //int c = int(map(index, 0, pi.length-2, 0, 255));
    strokeWeight(1);

    int digit1 = pi[index];
    int digit2 = pi[index+1];
    //rep[digit2]++;

    fill(coloresA[digit1]);
    stroke(coloresA[digit1]);

    float angle1 = (digit1 * (TWO_PI / 10))+(offset * rep[digit1]) - HALF_PI;
    float angle2 = (digit2 * (TWO_PI / 10))+(offset * rep[digit2]) - HALF_PI;

    float x1 = (radius-80) * cos(angle1);
    float y1 = (radius-80) * sin(angle1);

    float x2 = (radius-80) * cos(angle2);
    float y2 = (radius-80) * sin(angle2);

    line(x1, y1, x2, y2);

    strokeWeight(8);

    float x3 = (radius-60) * cos(angle1);
    float y3 = (radius-60) * sin(angle1);

    //float x4 = radius * cos(angle1);
    //float y4 = radius * sin(angle1);

    point(x3, y3);
    //line(x3, y3, x4, y4);    

    fill(coloresA[digit2]);
    stroke(coloresA[digit2]);  

    float x5 = (radius-60) * cos(angle2);
    float y5 = (radius-60) * sin(angle2);

    //float x6 = radius * cos(angle2);
    //float y6 = radius * sin(angle2);

    point(x5, y5);
    //line(x5, y5, x6, y6);
   
    rep[digit1]++;
    index++;
    print(index+ " " );
  }
}