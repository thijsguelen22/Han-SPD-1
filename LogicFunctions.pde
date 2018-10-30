//create arrays with values higher than the max amount of sets to avoid false triggering in if/else statements
void initArrays() {
  order = new int[sets*2];
  for(int i=0;i<sets*2;i++) {
	//set all the values to 100.
	//this makes it easier to create the order
    order[i] = 100;
  }
}

void endGame() {
  //show the scores of both players and tell who won (or if it's a tie)
  background(0);
  textAlign(CENTER);
  textSize(28);
  String winner = "";
  text("Score van "+playerOne+": "+scores[0], width/2, 20);
  text("Score van "+playerTwo+": "+scores[1], width/2, 50);
  if(scores[0] > scores[1]) {
    winner = "De winnaar is "+playerOne;
  } else if (scores[1] > scores[0]) {
    winner = "De winnaar is "+playerTwo;
  } else if (scores[0] == scores[1]) {
    winner = "Het is een gelijk spel!";
  }
  textSize(32);
  text(winner, width/2, 100);
}

void createOrder() {
	/*this function works reversed as how you would regularly approach generating random numbers.
	instead of cycling through each entry in the value and give it a random number,
	this loop loops N times, matching the amount of sets. then, it creates a random number between 0 and the max amount of sets.
	that number is the array entry that will get the number. the number would be the A position in the for loop.
	so instead of looping through the array from 0 to max, we loop through it random
	*/
  for(int a=0;a<sets;a++) {
	//since A is the value we want to put in the array, we need to put A in two spots of the array
    for(int b=0;b<2;b++) {
	  //generate a random int
      int ord = (int)round(random(0.0f, sets*2-1));
	  //if that spot in the array is not 100 (the initial value), regenerate a random integer until we find an empty one
      while(order[ord] != 100) {
        ord = (int)round(random(0.0f, sets*2-1));
      }
	  //give it the value
      order[ord] = a;
    }
  } 
}

int calculateClickedCard(int l, int lc) {
  //if line equals zero
  int returnValue;
  if(l == 0) {
    returnValue = lc;
  } else {
    returnValue = lc + (CardsPerLine*l);
  }
  return returnValue;
}

void switchPlayer() {
  //simple switch to switch players
  switch(playerTurn) {
    case 0:
	    playerTurn = 1;
	    currentPlayer = playerTwo;
      break;
	  case 1:
	    playerTurn = 0;
	    currentPlayer = playerOne;
      break;
  }
}

boolean checkMatch(int current, int last) {
  if(order[current] == order[last]) {
    println("these matched!");
    return true;
  } else {
    return false;
  }
}

void startNewGame() {
  //calculate the size the cards should be so they dont fall off the screen
  calculateCardSize();
  playerOne = readP1();
  playerTwo = readP2();
  currentPlayer = playerOne;
  //initialise arrays to hold the orders, matched cards etc
  initArrays();
  //create the order
  createOrder();
  //hide the input fields and button
  hideFields();
  background(0);
  //generate and draw the sets
  generateSets();
  newGame = false;
}

void initNewGame() {
  theControl = new ControlP5(this);
  //genereer invoerveld voor het aantal sets
  //functie(control, minimum sets, maximum sets)
  createInputBoxes(theControl);
}
