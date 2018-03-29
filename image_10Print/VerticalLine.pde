class VerticalLine extends Form implements Shape {

  PVector[] verticalLine;

  VerticalLine(PVector pos) {
    super(VERTICAL_LINE, pos);
    createForm();
  }

  void createForm() {
    verticalLine = new PVector[2];

    verticalLine[0] = new PVector(0, 0);
    verticalLine[1] = new PVector(0, SPACE_Y);

    setForm(verticalLine);
  }
}