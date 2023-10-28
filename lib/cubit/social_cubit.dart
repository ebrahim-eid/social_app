import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/models/messages_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/screens/bottom_nav_screens/chats_screen.dart';
import 'package:social_app/screens/bottom_nav_screens/feed_screen.dart';
import 'package:social_app/screens/bottom_nav_screens/settings_screen.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  bool isSecure = true;
  void changeVisibility() {
    isSecure = !isSecure;
    emit(SocialChangeVisibilityState());
  }
  void userRegisterProcess({
    required String name,
    required String phone,
    required String email,
    required String password,
    String image=
    'https://w7.pngwing.com/pngs/971/990/png-transparent-computer-icons-login-person-user-pessoa-smiley-desktop-wallpaper-address-icon.png',
    String bio= 'Write about yourself.....',
    String cover=
    'https://img.freepik.com/premium-photo/traditional-uzbek-oriental-cuisine-uzbek-family-table-from-different-dishes-new-year-holiday_127425-162.jpg?w=1060',
   bool isEmailVerified = true,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      createUser(name: name, email: email, phone: phone, uId: value.user!.uid);
      emit(SocialRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState());
    });
  }
  void userLoginProcess(context,
      {required String email, required String password}) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.uid);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login successfully')));
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      // if (error.code == 'INVALID_LOGIN_CREDENTIALS') {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ERROR_INVALID_EMAIL')));
      // } else if (error.code == 'ERROR_WRONG_PASSWORD') {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ERROR_WRONG_PASSWORD')));
      // }else if (error.code == 'ERROR_USER_NOT_FOUND') {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ERROR_USER_NOT_FOUND')));
      // }else if (error.code == 'ERROR_USER_DISABLED') {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('EERROR_USER_DISABLED')));
      // }
      print(error.toString());
      emit(SocialLoginErrorState());
    });
  }
  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image:
          'https://w7.pngwing.com/pngs/971/990/png-transparent-computer-icons-login-person-user-pessoa-smiley-desktop-wallpaper-address-icon.png',
      bio: 'Write about yourself.....',
      cover:
          'https://img.freepik.com/premium-photo/traditional-uzbek-oriental-cuisine-uzbek-family-table-from-different-dishes-new-year-holiday_127425-162.jpg?w=1060',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialUserErrorState());
    });
  }
  UserModel? userModel;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(userModel!.name);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState());
    });
  }
  int currentIndex = 0;
  List<Widget> screens = [
    const FeedScreen(),
    const ChatsScreen(),
    const ChatsScreen(),
    const SettingsScreen()
  ];
  void changeIndex(int index) {
    if (index == 4) {
      emit(SocialUserSuccessState());
    }
    if(index==1){
      getAllUsers();
    }
    if (index == 2) {
      emit(SocialAddPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }
  List<String> titles = ['Home', 'Chats', 'Users', 'Settings'];
  File? profileImage;
  File? coverImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialEditProfileSuccessState());
    } else {
      print('No image selected..');
      emit(SocialEditProfileErrorState());
    }
  }
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialEditCoverSuccessState());
    } else {
      print('No image selected..');
      emit(SocialEditCoverErrorState());
    }
  }
  String? profileImageUrl;
  Future uploadProfilePhoto() async {
    await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) async {
      profileImageUrl = await value.ref.getDownloadURL();
      print(profileImageUrl);
      emit(SocialUploadProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileErrorState());
    });
  }
  String? coverImageUrl;
  Future uploadCoverPhoto() async {
    await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) async {
      coverImageUrl = await value.ref.getDownloadURL();
      print(coverImageUrl);
      emit(SocialUploadCoverSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverErrorState());
    });
  }
  void updateUserData({
    required String name,
    required String bio,
    required String phone,
  }) async {
    if (profileImage != null && coverImage != null) {
      emit(SocialUpdateUserDataLoadingState());
      await uploadCoverPhoto();
      emit(SocialUpdateUserDataLoadingState());
      await uploadProfilePhoto();
      UserModel model = UserModel(
          name: name,
          email: userModel!.email,
          phone: phone,
          uId: userModel!.uId,
          image: profileImageUrl!,
          bio: bio,
          cover: coverImageUrl!,
          isEmailVerified: false);
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .update(model.toMap())
          .then((value) {
        getUserData();
        emit(SocialUpdateUserDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUpdateUserDataErrorState());
      });
    } else if (coverImage != null) {
      emit(SocialUpdateUserDataLoadingState());
      await uploadCoverPhoto();
      UserModel model = UserModel(
          name: name,
          email: userModel!.email,
          phone: phone,
          uId: userModel!.uId,
          image: userModel!.image,
          bio: bio,
          cover: coverImageUrl!,
          isEmailVerified: false);
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .update(model.toMap())
          .then((value) {
        getUserData();
        emit(SocialUpdateUserDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUpdateUserDataErrorState());
      });
    } else if (profileImage != null) {
      emit(SocialUpdateUserDataLoadingState());
      await uploadProfilePhoto();
      UserModel model = UserModel(
          name: name,
          email: userModel!.email,
          phone: phone,
          uId: userModel!.uId,
          image: profileImageUrl!,
          bio: bio,
          cover: userModel!.cover,
          isEmailVerified: false);
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .update(model.toMap())
          .then((value) {
        getUserData();
        emit(SocialUpdateUserDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUpdateUserDataErrorState());
      });
    } else {
      emit(SocialUpdateUserDataLoadingState());
      UserModel model = UserModel(
          name: name,
          email: userModel!.email,
          phone: phone,
          uId: userModel!.uId,
          image: userModel!.image,
          bio: bio,
          cover: userModel!.cover,
          isEmailVerified: false);
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .update(model.toMap())
          .then((value) {
        getUserData();
        emit(SocialUpdateUserDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUpdateUserDataErrorState());
      });
    }
  }
  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImageSuccessState());
    } else {
      print('No image selected..');
      emit(SocialPostImageErrorState());
    }
  }
  void uploadPostPhoto({
    required String dateTime,
    required String text,
  }) async {
    emit(SocialUploadPostPhotoLoadingState());
    await FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createNewPost(dateTime: dateTime, text: text, postImage: value);
        print(value);
        emit(SocialUploadPostPhotoSuccessState());
      }).catchError((error) {
        emit(SocialUploadPostPhotoSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadPostPhotoErrorState());
    });
  }
  void createNewPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostPhotoLoadingState());
    PostModel model = PostModel(
        name: userModel!.name,
        uId: userModel!.uId,
        image: userModel!.image,
        dateTime: dateTime,
        text: text,
        postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostPhotoSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostPhotoErrorState());
    });
  }
  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostPhotoState());
  }
  List<PostModel> listOfPosts = [];
  List<String> likeId = [];
  List<int> noOfLikes = [];
  Future getPosts() async {
    await FirebaseFirestore.instance.collection('posts')
        .orderBy('dateTime')
        .get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          noOfLikes.add(value.docs.length);
        }).catchError((error) {
          print(error.toString());
        });
        likeId.add(element.id);
        listOfPosts.add(PostModel.fromJson(element.data()));
      });

      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsErrorState());
    });
  }
  void likePosts(String id) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'likes': true}).then((value) {
      emit(SocialLikeSuccessState());
    }).catchError((error) {
      emit(SocialLikeErrorState());
    });
  }
  List<UserModel> allUsers = [];
  void getAllUsers() {
    if( allUsers.isEmpty){
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel!.uId) {
            allUsers.add(UserModel.fromJson(element.data()));
          }
        }
        print(allUsers);
        emit(GetAllUsersSuccessState());
      });
    }

  }
  void sendMessages({
    required String receiverId,
    required String message,
    required String dateTime,
  }){
    MessagesModel model = MessagesModel(
        senderId: userModel!.uId,
        receiverId: receiverId,
        message: message,
        dateTime: dateTime
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {

          emit(SendMessagesSuccessState());
    })
        .catchError((error){
      emit(SendMessagesErrorState());

    });
    // وده شات الشخص الاخر
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {

      emit(SendMessagesSuccessState());
    })
        .catchError((error){
      emit(SendMessagesErrorState());

    });
  }
  List<MessagesModel>messages=[];
  void getMessages({required String receiverId}){
    FirebaseFirestore.instance
    .collection('users').doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime', descending:true)
        .snapshots()
        .listen((event) {
          messages =[];
          for (var element in event.docs) {
            messages.add(MessagesModel.fromJson(element.data()));
          }
          emit(GetMessagesSuccessState());
    });
  }
}

