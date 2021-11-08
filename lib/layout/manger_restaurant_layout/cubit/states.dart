abstract class MangerRestaurantStates {}

class MangerRestaurantInitialState extends MangerRestaurantStates {}

// state to Layout Screen
class LayoutChangeBottomNavState extends MangerRestaurantStates {}

//all state to get user
class GetUserLoadingState extends MangerRestaurantStates {}

class GetUserSuccessState extends MangerRestaurantStates {}

class GetUserErrorState extends MangerRestaurantStates {
  final String error;
  GetUserErrorState(this.error);
}

//all state to addPost Screen and Feeds screen
class PostImagePickedSuccessState extends MangerRestaurantStates {}

class PostImagePickedErrorState extends MangerRestaurantStates {}

class RemovePostImageState extends MangerRestaurantStates {}

// create post state
class CreatePostLoadingState extends MangerRestaurantStates {}

class CreatePostSuccessState extends MangerRestaurantStates {}

class CreatePostErrorState extends MangerRestaurantStates {}

// Get post state
class GetPostLoadingState extends MangerRestaurantStates {}

class GetPostSuccessState extends MangerRestaurantStates {}

class GetPostErrorState extends MangerRestaurantStates {
  final String error;
  GetPostErrorState(this.error);
}

//all state to Chat screen
// Get Users state
class GetUsersLoadingState extends MangerRestaurantStates {}

class GetUsersSuccessState extends MangerRestaurantStates {}

class GetUsersErrorState extends MangerRestaurantStates {
  final String error;
  GetUsersErrorState(this.error);
}

// Get Send Message state
class SendMessageLoadingState extends MangerRestaurantStates {}

class SendMessageSuccessState extends MangerRestaurantStates {}

class SendMessageErrorState extends MangerRestaurantStates {
  final String error;
  SendMessageErrorState(this.error);
}

// Get get Messages state
class GetMessagesSuccessState extends MangerRestaurantStates {}

// Get Send image Message state
class CreateMessageImageLoadingState extends MangerRestaurantStates {}

class CreateMessageImageSuccessState extends MangerRestaurantStates {}

class CreateMessageImageErrorState extends MangerRestaurantStates {
  final String error;
  CreateMessageImageErrorState(this.error);
}

// change Icon button send message
class ChangeMessageIconState extends MangerRestaurantStates {}

//all state to Setting screen

//state change image profile
class ChangeProfileImagePickedSuccessState extends MangerRestaurantStates {}

class ChangeProfileImagePickedErrorState extends MangerRestaurantStates {}

//state Create image profile
class UpdateUserSuccessState extends MangerRestaurantStates {}

class UpdateUserErrorState extends MangerRestaurantStates {
  final String error;
  UpdateUserErrorState(this.error);
}

//all state to Workers screen

//state change image profile
class DeleteUserSuccessState extends MangerRestaurantStates {}

class DeleteUserErrorState extends MangerRestaurantStates {
  final String error;
  DeleteUserErrorState(this.error);
}

//all state to WorkShift screen
// Get Work Shift state
class GetWorkShiftLoadingState extends MangerRestaurantStates {}

class GetWorkShiftSuccessState extends MangerRestaurantStates {}

class GetWorkShiftErrorState extends MangerRestaurantStates {
  final String error;
  GetWorkShiftErrorState(this.error);
}
// Add Work Shift states
class AddWorkShiftLoadingState extends MangerRestaurantStates {}

class AddWorkShiftSuccessState extends MangerRestaurantStates {}

class AddWorkShiftErrorState extends MangerRestaurantStates {
  final String error;
  AddWorkShiftErrorState(this.error);
}
class AddWorkShiftChangeIconButtonState extends MangerRestaurantStates {}


//all state to Holiday screen
// Get Holiday  states
class GetHolidayLoadingState extends MangerRestaurantStates {}

class GetHolidaySuccessState extends MangerRestaurantStates {}

class GetHolidayErrorState extends MangerRestaurantStates {
  final String error;

  GetHolidayErrorState(this.error);
}
// Add Holiday  states
class AddHolidayLoadingState extends MangerRestaurantStates {}

class AddHolidaySuccessState extends MangerRestaurantStates {}

class AddHolidayErrorState extends MangerRestaurantStates {
  final String error;

  AddHolidayErrorState(this.error);
}
class AddHolidayChangeIconButtonState extends MangerRestaurantStates {}

class AddUserChangeRadioButton extends MangerRestaurantStates {}