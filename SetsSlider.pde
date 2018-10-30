void drawAditionalInput() {
  fill(255);
  textAlign(CENTER);
  text("Aantal sets: "+sets, width/2, SETS_INPUT_H_M);
  fill(255);
  //create the white bar
  rect(SLIDER_X_MARGE, SETS_INPUT_H_M + 15, width - (SLIDER_X_MARGE*2), SLIDER_HEIGHT);
  fill(0, 0, 255);
  //create the blue block
  rect(sliderXLocation, SETS_INPUT_H_M + 15, SLIDER_BTN_WIDTH, SLIDER_HEIGHT);
  fill(255, 25, 25);
  //create the button
  rect((width - START_BTN_W)/2, START_BTN_H_M, START_BTN_W, START_BTN_H);
  fill(255);
  textAlign(CENTER);
  text("START", width/2, (START_BTN_H_M+5+(START_BTN_H/2)));
}

void calcSetsSliderValue() {
  //calculate the amount of sets, based on the width of the bar and the position of the blue block 
  float factor = (width - (SLIDER_X_MARGE * 2))/20;
  sets = (int)((sliderXLocation - SLIDER_X_MARGE) / factor) + 12;
}
