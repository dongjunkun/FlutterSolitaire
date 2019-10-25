import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solitaire_flutter/card_column.dart';
import 'package:solitaire_flutter/empty_card.dart';
import 'package:solitaire_flutter/playing_card.dart';
import 'package:solitaire_flutter/transformed_card.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Stores the cards on the seven columns
  List<PlayingCard> cardColumn1 = [];
  List<PlayingCard> cardColumn2 = [];
  List<PlayingCard> cardColumn3 = [];
  List<PlayingCard> cardColumn4 = [];
  List<PlayingCard> cardColumn5 = [];
  List<PlayingCard> cardColumn6 = [];
  List<PlayingCard> cardColumn7 = [];

  // Stores the card deck
  List<PlayingCard> cardDeckClosed = [];
  List<PlayingCard> cardDeckOpened = [];

  // Stores the card in the upper boxes
  List<PlayingCard> finalHeartsDeck = [];
  List<PlayingCard> finalDiamondsDeck = [];
  List<PlayingCard> finalSpadesDeck = [];
  List<PlayingCard> finalClubsDeck = [];

  @override
  void initState() {
    super.initState();
    _initialiseGame();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              // color: Colors.green,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                center: Alignment(0.0, 0.0),
                radius: 1.5,
                colors: [
                  Colors.green, 
                  Colors.green[700], 
                  Colors.green, 
                ],
                stops: [0.0, 0.4, 1.0],
              )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Transform.translate(
                  offset: Offset(-100, 100),
                  child: Transform.rotate(
                    angle: pi * 0.1,
                    child: Opacity(
                        opacity: 0.1, child: Image.asset('images/spider.png')),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Transform.translate(
                  child: Transform.rotate(
                    angle: -pi / 4 * 3,
                    child: Opacity(
                        opacity: 0.1,
                        child: Image.asset(
                          'images/spider.png',
                          height: 150,
                          width: 150,
                        )),
                  ),
                  offset: Offset(20, -40),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Transform.translate(
                  child: Transform.rotate(
                    angle: pi / 4 * 3,
                    child: Opacity(
                        opacity: 0.1,
                        child: Image.asset(
                          'images/spider.png',
                          height: 50,
                          width: 50,
                        )),
                  ),
                  offset: Offset(20, -20),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 10,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 4.0, top: 8, bottom: 8),
                        child: Image.asset(
                          'images/logo.png',
                          height: 36,
                          width: 36,
                        )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 2),
                      child: Text(
                        "蜘蛛纸牌",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      ),
                      splashColor: Colors.white,
                      onTap: () {
                        _initialiseGame();
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildCardDeck(),
                    _buildFinalDecks(),
                  ],
                ),
                SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: CardColumn(
                        cards: cardColumn1,
                        onCardsAdded: (cards, index) {
                          setState(() {
                            cardColumn1.addAll(cards);
                            int length = _getListFromIndex(index).length;
                            _getListFromIndex(index)
                                .removeRange(length - cards.length, length);
                            _refreshList(index);
                          });
                        },
                        columnIndex: 1,
                      ),
                    ),
                    Expanded(
                      child: CardColumn(
                        cards: cardColumn2,
                        onCardsAdded: (cards, index) {
                          setState(() {
                            cardColumn2.addAll(cards);
                            int length = _getListFromIndex(index).length;
                            _getListFromIndex(index)
                                .removeRange(length - cards.length, length);
                            _refreshList(index);
                          });
                        },
                        columnIndex: 2,
                      ),
                    ),
                    Expanded(
                      child: CardColumn(
                        cards: cardColumn3,
                        onCardsAdded: (cards, index) {
                          setState(() {
                            cardColumn3.addAll(cards);
                            int length = _getListFromIndex(index).length;
                            _getListFromIndex(index)
                                .removeRange(length - cards.length, length);
                            _refreshList(index);
                          });
                        },
                        columnIndex: 3,
                      ),
                    ),
                    Expanded(
                      child: CardColumn(
                        cards: cardColumn4,
                        onCardsAdded: (cards, index) {
                          setState(() {
                            cardColumn4.addAll(cards);
                            int length = _getListFromIndex(index).length;
                            _getListFromIndex(index)
                                .removeRange(length - cards.length, length);
                            _refreshList(index);
                          });
                        },
                        columnIndex: 4,
                      ),
                    ),
                    Expanded(
                      child: CardColumn(
                        cards: cardColumn5,
                        onCardsAdded: (cards, index) {
                          setState(() {
                            cardColumn5.addAll(cards);
                            int length = _getListFromIndex(index).length;
                            _getListFromIndex(index)
                                .removeRange(length - cards.length, length);
                            _refreshList(index);
                          });
                        },
                        columnIndex: 5,
                      ),
                    ),
                    Expanded(
                      child: CardColumn(
                        cards: cardColumn6,
                        onCardsAdded: (cards, index) {
                          setState(() {
                            cardColumn6.addAll(cards);
                            int length = _getListFromIndex(index).length;
                            _getListFromIndex(index)
                                .removeRange(length - cards.length, length);
                            _refreshList(index);
                          });
                        },
                        columnIndex: 6,
                      ),
                    ),
                    Expanded(
                      child: CardColumn(
                        cards: cardColumn7,
                        onCardsAdded: (cards, index) {
                          setState(() {
                            cardColumn7.addAll(cards);
                            int length = _getListFromIndex(index).length;
                            _getListFromIndex(index)
                                .removeRange(length - cards.length, length);
                            _refreshList(index);
                          });
                        },
                        columnIndex: 7,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build the deck of cards left after building card columns
  Widget _buildCardDeck() {
    return Container(
      child: Row(
        children: <Widget>[
          InkWell(
            child: cardDeckClosed.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TransformedCard(
                      playingCard: cardDeckClosed.last,
                    ),
                  )
                : Opacity(
                    opacity: 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TransformedCard(
                        playingCard: PlayingCard(
                          cardSuit: CardSuit.diamonds,
                          cardType: CardType.five,
                        ),
                      ),
                    ),
                  ),
            onTap: () {
              setState(() {
                if (cardDeckClosed.isEmpty) {
                  cardDeckClosed.addAll(cardDeckOpened.map((card) {
                    return card
                      ..opened = false
                      ..faceUp = false;
                  }));
                  cardDeckOpened.clear();
                } else {
                  cardDeckOpened.add(
                    cardDeckClosed.removeLast()
                      ..faceUp = true
                      ..opened = true,
                  );
                }
              });
            },
          ),
          cardDeckOpened.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TransformedCard(
                    playingCard: cardDeckOpened.last,
                    attachedCards: [
                      cardDeckOpened.last,
                    ],
                    columnIndex: 0,
                  ),
                )
              : Container(
                  width: 40.0,
                ),
        ],
      ),
    );
  }

  // Build the final decks of cards
  Widget _buildFinalDecks() {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: EmptyCardDeck(
              cardSuit: CardSuit.hearts,
              cardsAdded: finalHeartsDeck,
              onCardAdded: (cards, index) {
                finalHeartsDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);
              },
              columnIndex: 8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: EmptyCardDeck(
              cardSuit: CardSuit.diamonds,
              cardsAdded: finalDiamondsDeck,
              onCardAdded: (cards, index) {
                finalDiamondsDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);
              },
              columnIndex: 9,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: EmptyCardDeck(
              cardSuit: CardSuit.spades,
              cardsAdded: finalSpadesDeck,
              onCardAdded: (cards, index) {
                finalSpadesDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);
              },
              columnIndex: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: EmptyCardDeck(
              cardSuit: CardSuit.clubs,
              cardsAdded: finalClubsDeck,
              onCardAdded: (cards, index) {
                finalClubsDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);
              },
              columnIndex: 11,
            ),
          ),
        ],
      ),
    );
  }

  // Initialise a new game
  void _initialiseGame() {
    cardColumn1 = [];
    cardColumn2 = [];
    cardColumn3 = [];
    cardColumn4 = [];
    cardColumn5 = [];
    cardColumn6 = [];
    cardColumn7 = [];

    // Stores the card deck
    cardDeckClosed = [];
    cardDeckOpened = [];

    // Stores the card in the upper boxes
    finalHeartsDeck = [];
    finalDiamondsDeck = [];
    finalSpadesDeck = [];
    finalClubsDeck = [];

    List<PlayingCard> allCards = [];

    // Add all cards to deck
    CardSuit.values.forEach((suit) {
      CardType.values.forEach((type) {
        allCards.add(PlayingCard(
          cardType: type,
          cardSuit: suit,
          faceUp: false,
        ));
      });
    });

    Random random = Random();

    // Add cards to columns and remaining to deck
    for (int i = 0; i < 28; i++) {
      int randomNumber = random.nextInt(allCards.length);

      if (i == 0) {
        PlayingCard card = allCards[randomNumber];
        cardColumn1.add(
          card
            ..opened = true
            ..faceUp = true,
        );
        allCards.removeAt(randomNumber);
      } else if (i > 0 && i < 3) {
        if (i == 2) {
          PlayingCard card = allCards[randomNumber];
          cardColumn2.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn2.add(allCards[randomNumber]);
        }
        allCards.removeAt(randomNumber);
      } else if (i > 2 && i < 6) {
        if (i == 5) {
          PlayingCard card = allCards[randomNumber];
          cardColumn3.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn3.add(allCards[randomNumber]);
        }
        allCards.removeAt(randomNumber);
      } else if (i > 5 && i < 10) {
        if (i == 9) {
          PlayingCard card = allCards[randomNumber];
          cardColumn4.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn4.add(allCards[randomNumber]);
        }
        allCards.removeAt(randomNumber);
      } else if (i > 9 && i < 15) {
        if (i == 14) {
          PlayingCard card = allCards[randomNumber];
          cardColumn5.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn5.add(allCards[randomNumber]);
        }
        allCards.removeAt(randomNumber);
      } else if (i > 14 && i < 21) {
        if (i == 20) {
          PlayingCard card = allCards[randomNumber];
          cardColumn6.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn6.add(allCards[randomNumber]);
        }
        allCards.removeAt(randomNumber);
      } else {
        if (i == 27) {
          PlayingCard card = allCards[randomNumber];
          cardColumn7.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn7.add(allCards[randomNumber]);
        }
        allCards.removeAt(randomNumber);
      }
    }

    cardDeckClosed = allCards;
    cardDeckOpened.add(
      cardDeckClosed.removeLast()
        ..opened = true
        ..faceUp = true,
    );

    setState(() {});
  }

  void _refreshList(int index) {
    if (finalDiamondsDeck.length +
            finalHeartsDeck.length +
            finalClubsDeck.length +
            finalSpadesDeck.length ==
        52) {
      _handleWin();
    }
    setState(() {
      if (_getListFromIndex(index).length != 0) {
        _getListFromIndex(index)[_getListFromIndex(index).length - 1]
          ..opened = true
          ..faceUp = true;
      }
    });
  }

  // Handle a win condition
  void _handleWin() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Congratulations!"),
          content: Text("You Win!"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                _initialiseGame();
                Navigator.pop(context);
              },
              child: Text("Play again"),
            ),
          ],
        );
      },
    );
  }

  List<PlayingCard> _getListFromIndex(int index) {
    switch (index) {
      case 0:
        return cardDeckOpened;
      case 1:
        return cardColumn1;
      case 2:
        return cardColumn2;
      case 3:
        return cardColumn3;
      case 4:
        return cardColumn4;
      case 5:
        return cardColumn5;
      case 6:
        return cardColumn6;
      case 7:
        return cardColumn7;
      case 8:
        return finalHeartsDeck;
      case 9:
        return finalDiamondsDeck;
      case 10:
        return finalSpadesDeck;
      case 11:
        return finalClubsDeck;
      default:
        return null;
    }
  }
}
