// An LSystem has a starting sentence
// An a ruleset
// Each generation recursively replaces characteres in the sentence
// Based on the rulset

class LSystem {

  String sentence;     // The sentence (a String)
  Rule[] ruleset;      // The ruleset (an array of Rule objects)
  int generation;      // Keeping track of the generation #

  int[] weight_vector;
  int[] choice_vector = {};
  int totalWeight;

  // Construct an LSystem with a startin sentence and a ruleset
  LSystem(String axiom, Rule[] r, int[] weight_vec) {
    if (r.length != weight_vec.length) {
      print("ERROR!: The lenghts of ruleset and weight vector do not match");
    }
    sentence = axiom;
    ruleset = r;
    generation = 0;
    weight_vector = weight_vec;
    generateRuleWeights();
    for (int eachWeight : weight_vector) {
      totalWeight += eachWeight;
    }
  }

  int ruleNumber() {
    int r;
    int rule_number;
    r = (int)random(0, choice_vector.length);
    rule_number = choice_vector[r];
    return rule_number;
  }

  // Generate the next generation
  void generate(boolean rulechange_withingen) {
    int rule_number = 0;
    // An empty StringBuffer that we will fill
    StringBuffer nextgen = new StringBuffer();
    // For every character in the sentence
    if (rulechange_withingen == false) {
      rule_number = ruleNumber();
    }

    for (int i = 0; i < sentence.length(); i++) {
      // What is the character
      char curr = sentence.charAt(i);

      // We will replace it with itself unless it matches one of our rules
      String replace = "" + curr;

      if (rulechange_withingen == true) {
        rule_number = ruleNumber();
      }      
      char a = ruleset[rule_number].getA();
      
      if (a == curr) {
        replace = ruleset[rule_number].getB();
      }      
      
      nextgen.append(replace);
    }

    // Replace sentence
    sentence = nextgen.toString();

    // Increment generation
    generation++;
  }

  void generateRuleWeights() {
    int i_elements_quantity;
    for (int i=0; i < weight_vector.length; i++) {
      i_elements_quantity = weight_vector[i];
      for (int j=0; j<i_elements_quantity; j++) {
        choice_vector = append(choice_vector, i);
      }
    }
  }

  String getSentence() {
    return sentence;
  }

  int getGeneration() {
    return generation;
  }

  void setWeightVector(int[] vec) {
    weight_vector = vec;
  }

  float getRandomAngle() {
    int rule_number = ruleNumber();
    float angle_now = ruleset[rule_number].getAngle();
    return angle_now;
  }

  float getWeightedAngle() {
    float weightedAngle = 0;
    for (int i=0; i < weight_vector.length; i++) {
      Rule currRule = ruleset[i];
      int currRuleWeight = weight_vector[i];
      weightedAngle += currRule.getAngle()*((float)currRuleWeight/totalWeight);
    }
    return weightedAngle;
  }

  float[] getWeightedColor() {
    float[] finalColorArray = new float[3];
    float redWeighted = 0;
    float greenWeighted = 0;
    float blueWeighted = 0;
    for (int i=0; i < weight_vector.length; i++) {
      Rule currRule = ruleset[i];
      int currRuleWeight = weight_vector[i];
      redWeighted += currRule.getRuleColorR()*((float)currRuleWeight/totalWeight);
      greenWeighted += currRule.getRuleColorG()*((float)currRuleWeight/totalWeight); 
      blueWeighted += currRule.getRuleColorB()*((float)currRuleWeight/totalWeight);
    }
    finalColorArray[0] = redWeighted;
    finalColorArray[1] = greenWeighted;
    finalColorArray[2] = blueWeighted;
    //printArray(finalColorArray);
    return finalColorArray;
  }
}