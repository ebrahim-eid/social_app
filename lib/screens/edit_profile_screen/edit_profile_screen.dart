import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/components/widgets.dart';
import 'package:social_app/constants/constants.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';

class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({Key? key}) : super(key: key);

  var nameController= TextEditingController();
  var bioController= TextEditingController();
   var phoneController= TextEditingController();

   @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var model= SocialCubit.get(context).userModel!;
        var profileImage= SocialCubit.get(context).profileImage;
        var coverImage= SocialCubit.get(context).coverImage;
        nameController.text=model.name;
        bioController.text=model.bio;
        phoneController.text= model.phone;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit profile',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'mooli'
            ),),
            actions: [
              TextButton(onPressed: () {
                SocialCubit.get(context).updateUserData(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text
                );
              }, child:   Text('UPDATE',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'mooli',
                color: defaultColor
              ),)),
              const SizedBox(width: 14,)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                 if (state is SocialUpdateUserDataLoadingState)...{
                   const LinearProgressIndicator(),
                   const SizedBox(height: 15,),
                 },
                  Container(
                    height: 250,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            alignment: Alignment.topRight,
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: coverImage != null ? FileImage(coverImage) : NetworkImage(model.cover) as ImageProvider,
                                    fit: BoxFit.cover
                                )
                            ),
                            child: IconButton(
                              onPressed: (){
                                SocialCubit.get(context).getCoverImage();
                              },
                              icon: CircleAvatar(
                                backgroundColor: defaultColor,
                                child: const Icon(Icons.camera_alt),
                              ),
                            ),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 65,
                                  backgroundImage: profileImage != null ? FileImage(profileImage) :
                                  NetworkImage(model.image) as ImageProvider,
                                )
                            ),
                            IconButton(
                              onPressed: (){
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                backgroundColor: defaultColor,
                                child: const Icon(Icons.camera_alt),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                    radius: 5,
                    labelText: 'Name',
                    prefix: Icons.person,
                    validate: (value){
                        if (value!.isEmpty){
                          return 'Name must not be empty';
                        }
                        return null;

                    }
                  ),
                  const SizedBox(height: 16,),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      radius: 5,
                      labelText: 'Bio',
                      prefix: FontAwesomeIcons.circleInfo,
                      validate: (value){
                        if (value!.isEmpty){
                          return 'Bio must not be empty';
                        }
                        return null;

                      }
                  ),
                  const SizedBox(height: 16,),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      radius: 5,
                      labelText: 'phone',
                      prefix: FontAwesomeIcons.phone,
                      validate: (value){
                        if (value!.isEmpty){
                          return 'Phone must not be empty';
                        }
                        return null;

                      }
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}











