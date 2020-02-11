// LSystem Rule class

class Rule {
  char a;
  String b;
  float angle;
  int[] ruleColor;

  Rule(char a_, String b_, float angle_, int[] ruleColor_) {
    a = a_;
    b = b_; 
    angle = angle_;
    ruleColor = ruleColor_;
  }

  char getA() {
    return a;
  }

  String getB() {
    return b;
  }

  float getAngle() {
    return angle;
  }

  int[] getRuleColor() {
    return ruleColor;
  }
  
  int getRuleColorR() {
    return ruleColor[0];
  }
  
  int getRuleColorG() {
    return ruleColor[1];
  }
  
  int getRuleColorB() {
    return ruleColor[2];
  }
}