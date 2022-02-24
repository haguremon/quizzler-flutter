// ignore_for_file: unnecessary_string_escapes, duplicate_ignore, prefer_final_fields

import 'question.dart';

class QuizBrain {
  // ignore: unused_field
  int _questionNnmber = 0;
  // ignore: duplicate_ignore, unused_field
  //_　をつけることによってプライベートにしてクラス内からしか参照できないようにした
  List<Question> _qAndaList = [
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    // ignore: unnecessary_string_escapes
    Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called \"Backrub\".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
  ];

  // String getquestionText(int questionNnmber) {
  //   return  _qAndaList[questionNnmber].questionText;
  // }
  //questionTextとquestionAnswerを取得するメソッドを作成
  String getQuestionText() => _qAndaList[_questionNnmber].questionText;

  bool getQuestionAnswer() => _qAndaList[_questionNnmber].questionAnswer;

  void nextQuestions() {
    //_questionNnmbeｒの数が_qAndaList.lengthより大きい時だけインクリメントされる

    if (_questionNnmber < _qAndaList.length - 1) {
      _questionNnmber++; //_questionNnmber != 13
    }
  }

  void restartQuestions() {
    _questionNnmber = 0;
  }
}
