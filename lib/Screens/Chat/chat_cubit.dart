import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }
  
}
