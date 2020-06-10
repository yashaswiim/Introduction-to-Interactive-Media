//class card for each card in the game

final int CARDWIDTH=100;
final int CARDHEIGHT=150;

class Card {
  int suit;                     //1=club, 2=heart, 3=spade, 4=diamond according to the image I used
  int number;                   //number of the card
  int cardWidth;
  int cardHeight;

  Card(int suit_, int number_) {
    suit=suit_;
    number=number_;
    
    cardWidth=CARDWIDTH;
    cardHeight=CARDHEIGHT;
    
  }

  void displayClosed(float topLeftX, float topLeftY ) {
    fill(0);
    rect(topLeftX, topLeftY, cardWidth, cardHeight);
  }


  void displayOpened(float topLeftX, float topLeftY ) {
    PImage cardImage=cardsImg.get((number-1)*cardWidth, (suit-1)*cardHeight, cardWidth, cardHeight);
    image(cardImage, topLeftX, topLeftY);
  }
}
