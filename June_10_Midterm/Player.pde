//class player for the players

class Player {
  ArrayList<Card> cards=new ArrayList<Card>();  //cards given to the player in the beginning
  boolean turn;  //checks if it is current player's turn

  Player() {   
    turn=false;
  }

  void setCards(ArrayList<Card> cards_) {
    cards=cards_;
  }

  void displayMyCards(String position) {
    int w=1;
    int h=1;
    int count=0;
    for (int i=0; i<cards.size(); i++) {
      if (position=="top") {
        cards.get(i).displayClosed((w-1)*100+10*w, (h-1)*150+10*h);
      } else {
        cards.get(i).displayOpened(width-w*10-w*100, height-h*10-h*150);
      }      
      count++;
      w++;
      if (count==13) { 
        h++;
        w=1;
        count=0;
      }
    }
  }

  void throwMyPairCards() {
    int i=-1;
    while (i<cards.size()) {
      i++;
      int j=i+1;
      while (j<cards.size()) {
        if (cards.get(i).number==cards.get(j).number) {
          cards.remove(i);
          cards.remove(j-1);
          matched.play();
          i--;
          break;
        }
        j++;
      }
    }
  }

  void drawCard(Player other, int myKey) {
    cards.add(other.cards.get(myKey-1));
    other.cards.remove(myKey-1);

    background(0, 100, 0);
    myGame.display();
    textSize(20);
    String mySuit;
    switch(cards.get(cards.size()-1).suit) {
    case 1:
      mySuit="CLUB";
      break;

    case 2:
      mySuit="HEART";
      break;

    case 3:
      mySuit="SPADE";
      break;

    default:
      mySuit="DIAMOND";
      break;
    }
    text("Drawn Card : "+ cards.get(cards.size()-1).number +" of "+mySuit, 600, 450);    
    myGame.myDelay=true;
    throwMyPairCards();

    IntList shuffled=myGame.shuffleCards(cards);
    ArrayList<Card> shuffledCards=new ArrayList<Card>();
    for (int i=0; i<shuffled.size(); i++) {
      shuffledCards.add(cards.get(shuffled.get(i)));
    }
    cards=shuffledCards;

    turn=false;
    other.turn=true;
  }
}
