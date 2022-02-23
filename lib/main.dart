import 'package:flutter/material.dart';

import 'quiz_brain.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                setState(() {
                  bool correctAnswer = quizBrain.getQuestionAnswer();

                  //カプセルかしないと下のようになる可能性もある
                  //quizBrain.qAndaList[questionNnmber].questionAnswer = true;

                  if (correctAnswer == true) {
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
                setState(() {
                  bool correctAnswer = quizBrain.getQuestionAnswer();
                  if (correctAnswer == false) {
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

                //The user picked false.
              },
            ),
          ),
        ),
        Row(
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
