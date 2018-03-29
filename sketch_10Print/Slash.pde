class Slash extends Form implements Shape {

  PVector[] slash;

  Slash(PVector pos) {
    super(SLASH, pos);
    createForm();
  }

  void createForm() {
    slash = new PVector[2];

    slash[0] = new PVector(SPACE_X, 0);
    slash[1] = new PVector(0, SPACE_Y);

    setForm(slash);
  }
}