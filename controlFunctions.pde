Textfield nm1, nm2;
void createInputBoxes(ControlP5 controlP5) {
  
  //create two name input boxes
  nm1 = controlP5.addTextfield("Speler 1 naam", (width - NAME_INPUT_W)/2, (SETS_INPUT_H_M*2)+SETS_INPUT_H, NAME_INPUT_W, SETS_INPUT_H);
  nm2 = controlP5.addTextfield("Speler 2 naam", (width - NAME_INPUT_W)/2, (SETS_INPUT_H_M*3)+(SETS_INPUT_H*2), NAME_INPUT_W, SETS_INPUT_H);
  
  //create the labels
  nm1.getValueLabel().setFont(createFont("arial",12));
  nm2.getValueLabel().setFont(createFont("arial",12));
  
  nm1.getCaptionLabel().setFont(createFont("arial",12));
  nm2.getCaptionLabel().setFont(createFont("arial",12));
}

void hideFields() {
  nm1.hide();
  nm2.hide();
}

//Returns the names

String readP1() {
  return nm1.getText();
}

String readP2() {
  return nm2.getText();
}
