class Form {

  int type;
  PVector pos;

  PVector[] form;

  Form(int type, PVector pos) {
    this.type = type;
    this.pos = pos;
  }

  void setForm(PVector[] form) {
    this.form = form;
  }

  void show() {
    beginShape();
    for (int i = 0; i < form.length; i++)
      vertex(pos.x + form[i].x, pos.y + form[i].y);
    endShape();
  }

  int type() {
    return this.type;
  }
}