void calculateCardSize() {
  //calculate how many lines it would take with the regular big sizing
  int lines = (int)ceil(sets*2.0f/CardsPerLine);
  
  while(height < ((CARD_HEIGHT + CARD_H_SPACING)*lines+CARD_H_SPACING)) {
	//as long as the cards are too big, scale them down in their aspect ratio
    CARD_H_SPACING = CARD_H_SPACING - 0.4;  
    CARD_V_SPACING = CARD_V_SPACING- 0.4;
    CARD_WIDTH = CARD_WIDTH - 0.66666;
    CARD_HEIGHT = CARD_HEIGHT -1;
	
	//because resizing cards may free up space on the horizontal axis, recalculate the amount of lines it would take
    float cpl = (width - CARD_H_SPACING) / (CARD_WIDTH + CARD_H_SPACING);
    CardsPerLine = (int)cpl;
    lines = (int)ceil(sets*2.0f/CardsPerLine);
  }
}

void generateSets() {
  //render the back sides of the card
  background(0);
  textAlign(CENTER);
  textSize(24);
  text("Het is de beurt aan "+currentPlayer+".", width/2, 24);
  int line=-1;
  int lineCard = 0;
  int genCard;
  for(int j=0;j<sets*2;j++) {
    fill(255, 40, 40);
    if(j%CardsPerLine == 0) {
      line++;
      lineCard = 0;
    }
	//use the calculateClickedCard function to retrieve the card number
    genCard = calculateClickedCard(line, lineCard);
    
    boolean skipDraw = false;
	//if a player already made a match, skip those
    for(int i=0;i<skipFlipCard.length;i++) {
      if(genCard == skipFlipCard[i]) {
        skipDraw = true;
      }
    }
    if(skipDraw == false) {
	  //if the card hasn't been matched yet, re-render it
      rect(((CARD_H_SPACING+CARD_WIDTH)*lineCard)+CARD_H_SPACING, ((CARD_V_SPACING+CARD_HEIGHT)*line)+CARD_V_SPACING, CARD_WIDTH, CARD_HEIGHT);
    } else if(skipDraw) {
	  //if the card was matched, render the card on it
      PImage img = loadImage(baseImgUrl+order[genCard]+".png", "png");
      image(img, ((CARD_H_SPACING+CARD_WIDTH)*lineCard)+CARD_H_SPACING, ((CARD_V_SPACING+CARD_HEIGHT)*line)+CARD_V_SPACING, CARD_WIDTH, CARD_HEIGHT);
    }
    lineCard++;
  }
  line = 0;
}

void revealCard(int l, int c, int cc) {
  //flip around a card
  clickCounter++;
  //load the corresponding image and render it
  PImage img = loadImage(baseImgUrl+order[cc]+".png", "png");
  image(img, ((CARD_H_SPACING+CARD_WIDTH)*c)+CARD_H_SPACING, ((CARD_V_SPACING+CARD_HEIGHT)*l)+CARD_V_SPACING, CARD_WIDTH, CARD_HEIGHT);
  //play the flip sound
  up.play();
  //if this is the second card that got flipped, check if it matches
  if(clickCounter == 2) {
	//if cards match
    if(checkMatch(cc, lastCard)) {
      ding.play();
	  //play the ding sound
      flippedCards++;
	  //add one to the flipped cards, and add it in the skipflip array
      skipFlipCard = append(skipFlipCard, lastCard);
      skipFlipCard = append(skipFlipCard, cc);
	  
	  //add a point to the corresponding score board
      if(playerTurn == 0) {
        scores[0] = scores[0] + 1;
      } else {
        scores[1] = scores[1] + 1;
      }
	  //if all cards got matched, end the game
      if(flippedCards == (sets)) {
        delay(2000);
        endGame();
      }
    } else {
	  //if cards didn't match, play wrong sound, flip it back and switch player
      wrong.play();
      reset = true;
      switchPlayer();
    }
	//reset the click counter
    clickCounter = 0;
  }
  lastCard = cc;
}
