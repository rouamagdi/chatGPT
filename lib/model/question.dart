class QuestionModel{
  String ?messageText;
  Sender ?sender;
  QuestionModel({this.messageText,this.sender});
}

enum Sender{
me,bot
}