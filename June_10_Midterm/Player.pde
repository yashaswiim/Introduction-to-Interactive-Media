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
        cards.get(i).displayClosed((w-1)*100+10*w, (h-1)*150+10*h);      //display computer cards closed on top
      } else {
        cards.get(i).displayOpened(width-w*10-w*100, height-h*10-h*150);     //display player cards opened on bottom
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

  void throwMyPairCards() {         //check if match for each card exists and removing the matching cards from respective player's cards
    int i=-1;
    while (i<cards.size()) {
      i++;
      int j=i+1;
      while (j<cards.size()) {
        if (cards.get(i).number==cards.get(j).number) { 
          cards.remove(i);
          cards.remove(j-1);
          matched.play();        //play the sound if match found
          i--;
          break;
        }
        j++;
      }
    }
  }

  void drawCard(Player other, int myKey) {      //current player draws card for other player's cards
    cards.add(other.cards.get(myKey-1));        //card added to this player's cards
    other.cards.remove(myKey-1);                //card removed from other player's cards

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
    text("Drawn Card : "+ cards.get(cards.size()-1).number +" of "+mySuit, 600, 450);   //display which card is drawn 
    myGame.myDelay=true;
    throwMyPairCards();   //remove cards if matched

    IntList shuffled=myGame.shuffleCards(cards);    //shuffle cards
    ArrayList<Card> shuffledCards=new ArrayList<Card>();
    for (int i=0; i<shuffled.size(); i++) {
      shuffledCards.add(cards.get(shuffled.get(i)));
    }
    cards=shuffledCards;
    
    //switch turns
    turn=false;
    other.turn=true;
  }
}
