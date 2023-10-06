import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/models/post_model.dart';

import '../../components/widgets.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return  SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
                Container(
                 height: 200,
                 width: double.infinity,
                 child: const Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  elevation: 10,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                       Image(
                        image: NetworkImage('https://img.freepik.com/free-photo/online-shopping-impressed-surprised-black-man-showing-credit-card-staring-smartphone-screen-d_1258-165562.jpg?w=1380&t=st=1694887123~exp=1694887723~hmac=30fb03d00342bc77b2e1cd9c48f679a97942f154394bad4c7914046a1ab78167'),
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: Text('Communicate with friends',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white
                        ),),
                      ),
                    ],
                  ),
              ),
               ),
              const SizedBox(height: 15,),
              ConditionalBuilder(
                  condition: SocialCubit.get(context).listOfPosts.isNotEmpty,
                  builder: (context)=>ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index)=>buildSocialItem (SocialCubit.get(context).listOfPosts[index],context,index),
                      separatorBuilder:  (context,index)=>const SizedBox(height: 10,),
                      itemCount: SocialCubit.get(context).listOfPosts.length
                  ),
                  fallback: (context)=> const Column(
                    children: [
                      Icon(Icons.menu_outlined,color: Colors.grey,
                        size: 200,
                      ),
                      Text('Add posts now',style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: 'mooli'
                      ),),
                    ],
                  ),
              )
            ],
          ),
        );
      },
    );
  }
  Widget buildSocialItem (PostModel model ,context,index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: const EdgeInsets.symmetric(horizontal: 10),
    elevation: 10,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(model.name,style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            fontFamily: 'mooli'
                          ),),
                        ),
                        const SizedBox(width: 10,),
                        const Icon(Icons.check_circle,color: Colors.blue,size: 20
                          ,),
                      ],
                    ),
                    Text(model.dateTime,style: Theme.of(context).textTheme.caption!.copyWith(
                        height: 1.5
                    )),
                  ],
                ),
              ),
              const SizedBox(width: 80,),

              IconButton(onPressed: (){}, icon: const Icon(
                  FontAwesomeIcons.ellipsis
              )),
            ],
          ),
          devider(),
          Padding(
            padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                right: 2

            ),
            child: Text(model.text,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                fontFamily: 'mooli'
              ),),
          ),
          if(model.postImage != '')...{
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        image: NetworkImage(model.postImage),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
          },
          const Padding(
            padding:  EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                       Icon(FontAwesomeIcons.heart,color: Colors.red,size: 15,),
                       SizedBox(width: 5,),
                      Text('0',style:  TextStyle(fontSize: 12,color: Colors.black54),),
                    ],
                  ),
                ),
                Expanded(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(FontAwesomeIcons.commentMedical,color: Colors.yellow,size: 15,),
                      SizedBox(width: 5,),
                      Text('0',style: TextStyle(fontSize: 12,color: Colors.black54),),
                      SizedBox(width: 5,),
                      Text('comments',style: TextStyle(fontSize: 15,color: Colors.black54),)
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                  backgroundImage: NetworkImage(
                      model.image),
                ),
              ),
              Text('Write a comment....',style: Theme.of(context).textTheme.caption!.copyWith(
                  height: 1.5,
                  fontSize: 13
              )),
              const Spacer(),
              SizedBox(
                width: 25,
                child: Wrap(
                    children:[
                      MaterialButton(
                        onPressed: (){
                          SocialCubit.get(context).likePosts(SocialCubit.get(context).likeId[index]);
                        },
                        minWidth: 0,
                        padding: EdgeInsets.zero,
                        child:const Icon(FontAwesomeIcons.heart,color: Colors.red,size: 15,),
                      ),

                    ]
                ),
              ),
              const Text('Like',style: TextStyle(fontSize: 15,color: Colors.black54),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

