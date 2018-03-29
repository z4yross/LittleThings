interface Shape {

  final static float SPACE_X = SPA_X;
  final static float SPACE_Y = SPA_Y;

  final static int SLASH = 0;
  final static int BACKSLASH = 1;
  final static int VERTICAL_LINE = 2;
  final static int HORIZONTAL_LINE = 3;

  void show();
  void createForm();

  int type();
}