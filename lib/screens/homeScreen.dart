
import 'package:chatgpt/Api/apiService.dart';
import 'package:chatgpt/model/question.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);@override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController question=TextEditingController();
  final List<QuestionModel> questionList=[];
  String message='';
  var scrollController=ScrollController();
  scroll(){
    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.bounceOut);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Content Wrinting"),
      ),
      body:Container(child: Column(children: [ Center(child: Container( decoration:
       BoxDecoration(color:Colors.grey,
       borderRadius:
       BorderRadius.all(Radius.circular(20))),child:
      TextField(
        controller: question,
        decoration:InputDecoration(
          suffixIcon: IconButton(icon: Icon(Icons.send),onPressed:()async{
            print(question.text);
            setState(() {
                questionList.add(QuestionModel(messageText: question.text,sender: Sender.me));
          question.clear();
          
            });
            var post =await ApiService().sendQuestion(question.text);
            setState(() {
              questionList.add(QuestionModel(messageText:post,sender: Sender.bot));
            });
             }),
border:InputBorder.none,

hintText:'Enter Your topic you want to search about'
),)),),Expanded(child: Container(color: Colors.white,child:
 ListView.builder(
  physics:const BouncingScrollPhysics(),
  controller: scrollController,
  shrinkWrap: true,
  itemCount: questionList.length,
  itemBuilder: ((context, index) {
    var chat =questionList[index];
  
    return bubble(textmessage:chat.messageText,sender:chat.sender);} )),),),]),));
  }
  Widget bubble({required textmessage,required sender}){
return Row(children: [
  CircleAvatar(backgroundColor: Colors.greenAccent,child: Icon(Icons.person),),SizedBox(width: 40,),
  Expanded(
    child: Container(
    padding:  EdgeInsets.only(left: 40),
    margin: EdgeInsets.all( 8),
    decoration: BoxDecoration(color:sender==Sender.bot? Colors.greenAccent:Colors.grey,borderRadius:sender==Sender.bot? BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)):BorderRadius.only(topLeft: Radius.circular(12),bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12))),
  child: Text(textmessage,style: TextStyle(color: Colors.white,fontSize: 14),),
  ),
  )],);

  }

  
}
  