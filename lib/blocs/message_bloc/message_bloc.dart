import 'package:couple_app_v3/blocs/message_bloc/message_event.dart';
import 'package:couple_app_v3/blocs/message_bloc/message_state.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/services/repository_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../locator.dart';

class MessageBLoc extends Bloc<MessageEvent, MessageState> {
  MessageBLoc() :super(MessageStateLoading());
  Repository _repository = locator<Repository>();

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    // TODO: implement mapEventToState
    if (event is MessageEventStart) {
        String userId = event.message.sendBy;
          var user = await _repository.getUser(userId).then((user) {
          if (user == null) {
            return UserModel(id: '', email: '', displayName: '', imgUrl: '');
          } else {
            return user;
          }
        });
      yield MessageStateLoaded(userModel: user, message: event.message);
    }
  }
}