import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';

import '../../constants/constants.dart';

class AddPostScreen extends StatelessWidget {

   AddPostScreen({Key? key}) : super(key: key);
   var textController = TextEditingController();

   @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              SocialCubit.get(context).getPosts();
              Navigator.pop(context);
            },icon: const Icon(Icons.arrow_back_ios_rounded),),
            title: const Text('Add Post',style: TextStyle(
                fontFamily: 'mooli',
            ),),
            actions: [
              TextButton(onPressed: ()
              {
                if(SocialCubit.get(context).postImage ==null){
                  SocialCubit.get(context).createNewPost(
                      dateTime: DateTime.now().toString(),
                      text: textController.text,
                  );
                }else{
                  SocialCubit.get(context).uploadPostPhoto(
                      dateTime: DateTime.now().toString(),
                      text: textController.text,
                  );
                }

              }, child:   Text('POST',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'mooli',
                  color: defaultColor,

              ),)),
              const SizedBox(width: 14,)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                if (state is SocialCreatePostPhotoLoadingState)
                const LinearProgressIndicator(),
                 Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          right: 15
                      ),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(SocialCubit.get(context).userModel!.image),
                      ),
                    ),
                    Text(SocialCubit.get(context).userModel!.name,style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        fontFamily: 'mooli'
                    ),),
                  ],
                ),
                const SizedBox(height: 15,),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write what you want...'
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage !=null)
                Container(
                  alignment: Alignment.topRight,
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover
                      )
                  ),
                  child: IconButton(
                    onPressed: (){
                      SocialCubit.get(context).removePostImage();
                    },
                    icon: const CircleAvatar(
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                if (state is SocialUploadPostPhotoLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: (){
                          SocialCubit.get(context).getPostImage();
                        },
                        child:  Row(
                          children: [
                             Icon(FontAwesomeIcons.image,color: defaultColor,),
                            const SizedBox(width: 8,),
                             Text('add photo',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'mooli',
                              color: defaultColor,

                            ),)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: TextButton(
                          onPressed: (){},
                          child:   Text('#tags',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'mooli',
                            color: defaultColor,

                          ),),
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
