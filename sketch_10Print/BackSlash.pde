class BackSlash extends Form implements Shape {

  PVector[] backSlash;

  BackSlash(PVector pos) {
    super(BACKSLASH, pos);
    createForm();
  }

  void createForm() {
    backSlash = new PVector[2];

    backSlash[0] = new PVector(0, 0);
    backSlash[1] = new PVector(SPACE_X, SPACE_Y);

    setForm(backSlash);
  }
}