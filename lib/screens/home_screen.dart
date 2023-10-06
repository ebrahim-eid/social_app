import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/message.dart';
import 'package:social_app/screens/add_post_screen/Add_post_screen.dart';

import '../cubit/social_cubit.dart';
import '../cubit/social_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialAddPostState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPostScreen()));
        }
      },
      builder: (context,state){
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:   Text(
              cubit.titles[cubit.currentIndex],
              style: const TextStyle(
                fontFamily: 'mooli'
              ),
            ),
            actions: [
              IconButton(onPressed: () async{
                await FCMessaging().initNotification();
              }, icon: const Icon(FontAwesomeIcons.bell)),
              IconButton(onPressed: (){}, icon: const Icon(FontAwesomeIcons.searchengin)),

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeIndex(index);
            },
            currentIndex: cubit.currentIndex,
            items:  const [
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.houseUser),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.rocketchat),label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.upload),label: 'Post'),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.gear),label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}


