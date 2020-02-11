class Turtle {

  String todo;
  float len;
  float theta;
  float[] colorArray;

  Turtle(String s, float l, float t, float[] colorArray_) {
    todo = s;
    len = l; 
    theta = t;
    colorArray = colorArray_;
  } 

  void render() {
    stroke(colorArray[0], colorArray[1], colorArray[2]);
    for (int i = 0; i < todo.length(); i++) {
      char c = todo.charAt(i);
      if (c == 'F' || c == 'G') {
        line(0, 0, len, 0);
        translate(len, 0);
      } else if (c == '+') {
        rotate(theta);
      } else if (c == '|') {
        rotate(PI);
      } else if (c == '-') {
        rotate(-theta);
      } else if (c == '[') {
        pushMatrix();
      } else if (c == ']') {
        popMatrix();
      }
    }
  }

  void setLen(float l) {
    len = l;
  } 

  void changeLen(float percent) {
    len *= percent;
  }

  void setAngle(float theta_) {
    theta = radians(theta_);
  }

  void setToDo(String s) {
    todo = s;
  }
}