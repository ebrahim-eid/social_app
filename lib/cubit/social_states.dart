abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialChangeVisibilityState extends SocialStates{}

class SocialRegisterLoadingState extends SocialStates{}

class SocialRegisterSuccessState extends SocialStates{}

class SocialRegisterErrorState extends SocialStates{}

class SocialLoginLoadingState extends SocialStates{}

class SocialLoginSuccessState extends SocialStates{
  final String uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialStates{}

class SocialUserLoadingState extends SocialStates{}

class SocialUserSuccessState extends SocialStates{}

class SocialUserErrorState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{}

class SocialChangeBottomNavState extends SocialStates{}

class SocialAddPostState extends SocialStates{}

class SocialEditProfileSuccessState extends SocialStates{}

class SocialEditProfileErrorState extends SocialStates{}

class SocialEditCoverSuccessState extends SocialStates{}

class SocialEditCoverErrorState extends SocialStates{}


class SocialUploadProfileSuccessState extends SocialStates{}

class SocialUploadProfileErrorState extends SocialStates{}

class SocialUploadCoverSuccessState extends SocialStates{}

class SocialUploadCoverErrorState extends SocialStates{}


class SocialUpdateUserDataLoadingState extends SocialStates{}

class SocialUpdateUserDataSuccessState extends SocialStates{}

class SocialUpdateUserDataErrorState extends SocialStates{}


class SocialUploadPostPhotoLoadingState extends SocialStates{}

class SocialUploadPostPhotoSuccessState extends SocialStates{}

class SocialUploadPostPhotoErrorState extends SocialStates{}


class SocialPostImageSuccessState extends SocialStates{}

class SocialPostImageErrorState extends SocialStates{}

class SocialCreatePostPhotoLoadingState extends SocialStates{}

class SocialCreatePostPhotoSuccessState extends SocialStates{}

class SocialCreatePostPhotoErrorState extends SocialStates{}

class SocialRemovePostPhotoState extends SocialStates{}


class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates{}

class SocialLikeSuccessState extends SocialStates{}

class SocialLikeErrorState extends SocialStates{}

class GetAllUsersSuccessState extends SocialStates{}

class GetAllUsersErrorState extends SocialStates{}

class SendMessagesSuccessState extends SocialStates{}
class SendMessagesErrorState extends SocialStates{}

class GetMessagesSuccessState extends SocialStates{}

class GetTimeState extends SocialStates{}

