class HorizontalLine extends Form implements Shape {

  PVector[] horizontalLine;

  HorizontalLine(PVector pos) {
    super(HORIZONTAL_LINE, pos);
    createForm();
  }

  void createForm() {
    horizontalLine = new PVector[2];

    horizontalLine[0] = new PVector(0, 0);
    horizontalLine[1] = new PVector(SPACE_X, 0);

    setForm(horizontalLine);
  }
}