import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final FirebaseAuth auth = FirebaseAuth.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    emit(ChatListLoading());
    try {
      final currentUserUid = FirebaseAuth.instance.currentUser?.uid;
      final usersStream = FirebaseFirestore.instance
          .collection('users')
          .where('uid', isNotEqualTo: currentUserUid)
          .snapshots();
      emit(ChatListLoaded());
      return usersStream;
    } catch (e) {
      emit(UserloadedError(message: e.toString()));
      rethrow;
    }
  }
}
