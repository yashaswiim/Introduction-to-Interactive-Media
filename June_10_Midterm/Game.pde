//class game for the main game

class Gamee {
  ArrayList<Card> cards=new ArrayList<Card>();
  Player player;  //the user
  Player computer;    // made the second player the computer itself
  Button throwPairs;  
  Button instructions;

  boolean started;  //checks if game is started
  boolean end;  //checks end of game
  boolean pairThrown;  //checks if the the pairs have been thrown by both players initially
  boolean ins;  //checks if the player wants instructions
  boolean myDelay;  //checks if delay is necessary somewhere

  Gamee() {
    player=new Player();
    computer=new Player();
    throwPairs=new Button(1390, 400, 50, "Throw Pairs");
    instructions=new Button(720,400,70,"Instructions");
    for (int i=1; i<=4; i++) {
      for (int j=1; j<=13; j++) {
        cards.add(new Card(i, j));
      }
    }
    started=false;
    end=false;
    pairThrown=false;
    ins=false;
    myDelay=false;
  }

  void start() {     //starts the game
    started=true;
    cards.remove(10);
    IntList shuffledList=shuffleCards(cards);
    divideCards(shuffledList);
  }

  void display() {      //display of the game
    player.displayMyCards("bottom");
    computer.displayMyCards("top");
    throwPairs.display();
  }

  IntList shuffleCards(ArrayList<Card> cards) {    //shuffles the positions of the cards within the ArrayList
    IntList shuffledList=new IntList();
    for (int i=0; i<cards.size(); i++) {
      shuffledList.append(i);
    }
    shuffledList.shuffle();
    return shuffledList;
  }

  void divideCards(IntList shuffledList) {     //divides the cards between the player and the computer according to the shuffledList
    ArrayList<Card> playerCards=new ArrayList<Card>();
    ArrayList<Card> computerCards=new ArrayList<Card>();

    for (int i=0; i<shuffledList.size(); i++) {
      if (i<shuffledList.size()/2) {
        playerCards.add(cards.get(shuffledList.get(i)));
      } else {
        computerCards.add(cards.get(shuffledList.get(i)));
      }
    }
    player.setCards(playerCards);
    computer.setCards(computerCards);
  }

  void throwPairCards() {     //removes matching cards from the player and the compuer's cards
    player.throwMyPairCards();
    computer.throwMyPairCards();
    pairThrown=true;
  }

  boolean checkEnd() {      //checks end of game
    if (player.cards.size()==0 || computer.cards.size()==0) {
      end=true;
    }
    return end;
  }

  String returnWinner() {      //returns the winner
    textSize(20);
    if (player.cards.size()==0) {
      victory.play();
      text("Computer has the jack!",590,300);
      return "YOU";
    } else {
      lose.play();
      text("You have the jack!",600,300);
      return "COMPUTER";
    }
  }
}
