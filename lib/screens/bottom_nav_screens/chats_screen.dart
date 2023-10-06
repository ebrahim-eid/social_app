import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/models/user_model.dart';

import '../../components/widgets.dart';
import '../messages_screen/messages_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
            condition: SocialCubit.get(context).allUsers.isNotEmpty,
            builder: (context)=>Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>buildChatItems (SocialCubit.get(context).allUsers[index],context),
                  separatorBuilder: (context,index)=>devider(),
                  itemCount:  SocialCubit.get(context).allUsers.length
              ),
            ),
            fallback: (context)=> const Center(child: CircularProgressIndicator())
        );
      },
    );
  }
  Widget buildChatItems (UserModel model,context)=> InkWell(
    onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>MessagesScreen(model: model,)));
    },
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
              right: 15
          ),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                model.image
            ),
          ),
        ),
        Text(model.name,style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            fontFamily: 'mooli'
        ),),

      ],
    ),
  );

}
