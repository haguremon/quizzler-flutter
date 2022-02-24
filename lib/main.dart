import 'package:flutter/material.dart';

import 'quiz_brain.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();


void main() => runApp(Quizzler());

// ignore: use_key_in_widget_constructors
class Quizzler extends StatelessWidget {
  //QuizzlerはStatelessWidgetを継承して
  //StatelessWidgetのbuild関数をオーバライドする
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors, must_be_immutable
class QuizPage extends StatefulWidget {
  //QuizPageは状態変化するのもの的な認識のStatefulWidgetを継承して
  @override // State createState();
  _QuizPageState createState() => _QuizPageState(); //変更可能な状態を作成
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> socreKeeper = [];

var alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15,
    ),
  descTextAlign: TextAlign.start,
  animationDuration: const Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),
    side: const BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 25,
  ),
  alertAlignment: Alignment.topCenter,
);

  // List<Expanded> createSocreKeeper() {
  //   List<Expanded> expandedsocreKeeper = [];
  //   socreKeeper.forEach((element) {
  //     expandedsocreKeeper.add(Expanded(
  //       child: element,
  //     ));
  //   });
  //   return expandedsocreKeeper;
  // }
  // ignore: unused_field
  int _scorecount = 0;
  void checkAnswer(bool userPickedAnswer) {
    if (socreKeeper.length == 13) {
      Alert(
        context: context,
        title: 'Score\n$_scorecount/13',
        style: alertStyle,
        desc: "最後の問題が終わりました。どちらかを選択してください",
        buttons: <DialogButton>[
          DialogButton(
            child: const Center(
              child: Text(
                "リスタート",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            onPressed: () {
              setState(() {
                socreKeeper = [];
                _scorecount = 0;
                quizBrain.restartQuestions();
              });
              Navigator.pop(context);
            },
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
          ),
          DialogButton(
            child: const Text(
              "キャンセル",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () => Navigator.pop(context),
            color: Colors.red,
          )
        ],
      ).show();
      return;
    }
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() {
      if (correctAnswer == userPickedAnswer) {
        _scorecount++;
        socreKeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        socreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
      quizBrain.nextQuestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      color: Colors.white,
                    ),
                  )),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      color: Colors.white,
                    ),
                  )),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
                //The user picked false.
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: socreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
