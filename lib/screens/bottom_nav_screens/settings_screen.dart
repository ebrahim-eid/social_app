import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/constants/constants.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/screens/edit_profile_screen/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
        builder: (context,state){
        var model= SocialCubit.get(context).userModel!;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 250,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: NetworkImage(model.cover),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage: NetworkImage(model.image),
                      )
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              Text(model.name,style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'mooli'
              ),),
              const SizedBox(height: 13,),
              Text(model.bio,style: Theme.of(context).textTheme.caption!.copyWith(
                  height: 1.5,
                fontWeight: FontWeight.w500
              )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text('100',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,

                        ),),
                        Text('post',style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[800],
                            fontFamily: 'mooli'
                        )),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text('256',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                        Text('Photo',style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[800],
                            fontFamily: 'mooli'
                        )),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text('15K',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                        Text('Followers',style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[800],
                            fontFamily: 'mooli'
                        )),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text('75',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                        Text('Following',style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[800],
                            fontFamily: 'mooli'
                        )),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Container(
                   width: 310,
                   height: 40,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8),
                     color: defaultColor,
                   ),
                   child: MaterialButton(
                     onPressed: (){},child: Text('Add Photos',
                     style: TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                         fontFamily: 'mooli'
                   ),),),
                 ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: defaultColor,
                      ),
                      child: MaterialButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen()));
                        },child: const Center(child: Icon(FontAwesomeIcons.penToSquare,color: Colors.white,)),),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
        },

    );
  }
}
