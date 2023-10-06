import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/models/messages_model.dart';

import '../../constants/constants.dart';
import '../../models/user_model.dart';

class MessagesScreen extends StatelessWidget {
  UserModel model;
   MessagesScreen({Key? key,required this.model}) : super(key: key);
  var messageController =TextEditingController();
  var formKey=GlobalKey<FormState>();
  // final _controller = ScrollController();
  String ? time;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  void timeConverter(){
    time = dateFormat.format(DateTime.now());
    print(time);
  }
  @override
  Widget build(BuildContext context) {
    return Builder(builder:(context){
      timeConverter();
      SocialCubit.get(context).getMessages(receiverId: model.uId);

      return  BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        right: 15
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          model.image
                      ),
                    ),
                  ),
                  Text(model.name,style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'mooli',
                      color: Colors.black
                  ),),

                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ConditionalBuilder(
                      condition: SocialCubit.get(context).messages.isNotEmpty,
                      builder: (context)=>ListView.separated(
                        reverse: true,
                          itemBuilder: (context,index){
                            var message = SocialCubit.get(context).messages[index];
                            if(SocialCubit.get(context).userModel!.uId == message.senderId) {
                              return myMessages(message);
                            }else{
                              return friendMessages(message);
                            }

                          },
                          separatorBuilder: (context,index)=>const SizedBox(height: 10,),
                          itemCount: SocialCubit.get(context).messages.length
                      ),
                      fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: Form(
                            key: formKey,
                            child: TextFormField(
                              controller: messageController,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Write a message';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  hintText: 'Start messaging...'
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),

                          child: IconButton(onPressed: (){
                            if(formKey.currentState!.validate()){
                              timeConverter();
                              SocialCubit.get(context).sendMessages(
                                  receiverId: model.uId,
                                  message: messageController.text,
                                  dateTime:DateTime.now().toString()
                              );
                              messageController.clear();
                            }
                            print(DateTime.now().toString());

                          },
                            icon: const Icon(Icons.send,size: 28,),color: Colors.white,)
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },

      );
    });
  }

  Widget myMessages(MessagesModel model)=>Align(
    alignment: AlignmentDirectional.topEnd,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration:  BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(messageRadius),
              topLeft: Radius.circular(messageRadius),
              bottomLeft: Radius.circular(messageRadius)
          ),
          color: Colors.grey[400]
      ),
      child: Text(model.message,style: TextStyle(
          fontFamily: 'mooli',
          fontSize: 17,
          height: 1.5
      ),),
    ),
  );

  Widget friendMessages(MessagesModel model)=>Align(
    alignment: AlignmentDirectional.topStart,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration:  BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(messageRadius),
              topLeft: Radius.circular(messageRadius),
              bottomRight: Radius.circular(messageRadius)
          ),
          color: Colors.grey[400]
      ),
      child: Text(model.message,style: TextStyle(
          fontFamily: 'mooli',
          fontSize: 17,
          height: 1.5
      ),),
    ),
  );

}



