/**
Beroepsproduct SPD course
Author: Thijs-Jan Guelen
Date: 30-10-2018
Version: 3.0
*/

//imports
import controlP5.*;
import processing.sound.*;

//initialising the variables that come with the imported code
ControlP5 theControl;
SoundFile ding, wrong, up, down;

//initialising finals
//settings for the input boxes
final int SETS_INPUT_H = 40;
//set the input marge
final int SETS_INPUT_H_M = 50;
//give the name input text field a width. Height is the same as numer boxes
final int NAME_INPUT_W = 150;
final int START_BTN_W = 150;
final int START_BTN_H = 50;
final int START_BTN_H_M = 400;

final int SLIDER_X_MARGE = 260;
final int SLIDER_HEIGHT = 20;
final int SLIDER_BTN_WIDTH = 11;

//the marges for the rectangles
float CARD_H_SPACING = 48;
float CARD_V_SPACING = 48;
float CARD_WIDTH = 90;
float CARD_HEIGHT = 120;

int CardsPerLine;
int sets = 12;
int line=-1;
int lineCard = 0;
int clickedCard = 400;
int clickCounter;
int flippedCards = 0;
int currentClick = 400;
int playerTurn = 0;
int sliderXLocation = SLIDER_X_MARGE;
int lastCard;

boolean newGame = true;
boolean reset;
boolean clickLock = false;

String baseImgUrl = "/img/";
String currentPlayer, playerOne, playerTwo = "";

int[] order;
int[] scores = new int[2];
int[] skipFlipCard = {100};

void setup() {
  size(1152, 720);
  //initialise sound effects
  up = new SoundFile(this, "up.mp3");
  down = new SoundFile(this, "down.mp3");
  wrong = new SoundFile(this, "wrong.mp3");
  ding = new SoundFile(this, "ding.mp3");
  //set size for the window
  //set the amounts of cards per line based on width
  float cpl = (width - CARD_H_SPACING) / (CARD_WIDTH + CARD_H_SPACING);
  CardsPerLine = (int)cpl;
  //give it a background
  background(0);
  //initialise the new game
  if(newGame) {
	  initNewGame();
  }
}

void draw() {
  if(newGame) {
	//if new game, draw the slider and name boxes
    background(0);
    drawAditionalInput();
  }
  if(reset) {
  	clickLock = true;
  	//when the two clicked cards don't  match
    delay(2000);
    generateSets();
    down.play();
  	clickLock = false;
    reset = false;
  }
} 

void mouseClicked() {
  if(newGame) {
	//input handling for the start button
    if(mouseX > ((width - START_BTN_W)/2) && mouseX < ((width/2) + (START_BTN_W/2)) && mouseY > START_BTN_H_M && mouseY < (START_BTN_H_M + START_BTN_H)) {
      startNewGame();
    }
    if(mouseX > SLIDER_X_MARGE && mouseX < width - SLIDER_X_MARGE && mouseY > SETS_INPUT_H_M + 15 && mouseY < SETS_INPUT_H_M + 15 + SLIDER_HEIGHT) {
      sliderXLocation = mouseX;
      calcSetsSliderValue();
    }
  } else if(clickLock == false)  {
	//if a card is clicked
    int line=-1;
    int lineCard = 0;
	//calculate the line number
    for(int k=0;k<sets*2;k++) {
      if(k%CardsPerLine == 0) {
        line++;
        lineCard = 0;
      }
      if(mouseX > ((CARD_H_SPACING+CARD_WIDTH)*lineCard)+CARD_H_SPACING && mouseX < ((CARD_H_SPACING+CARD_WIDTH)*lineCard)+CARD_H_SPACING+CARD_WIDTH && mouseY > ((CARD_V_SPACING+CARD_HEIGHT)*line)+CARD_V_SPACING && mouseY < ((CARD_V_SPACING+CARD_HEIGHT)*line)+CARD_V_SPACING + CARD_HEIGHT) {
        currentClick = calculateClickedCard(line, lineCard);
		//prevent double clicking the same card
        if(clickedCard == currentClick) {
			println("already clicked");
        } else {
          clickedCard = currentClick;
          revealCard(line, lineCard, clickedCard);
        }
      }
      lineCard++;
    }
  }
}
