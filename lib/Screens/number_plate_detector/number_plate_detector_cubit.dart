import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:insta_clone/Screens/number_plate_detector/number_plate_detector_state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NumberPlateCubit extends Cubit<NumberPlateState> {
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;

  bool isConnected = false;

  NumberPlateCubit() : super(NumberPlateInitial());

  /// 🔌 Connect WebSocket
  void connect() {
    emit(NumberPlateLoading());

    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://13.233.44.195:8765/'),
      );

      isConnected = true;
      emit(NumberPlateConnected());

      _subscription = _channel!.stream.listen(
        (message) {
          emit(NumberPlateDetected(message.toString()));
        },
        onError: (error) {
          emit(NumberPlateError("Connection error"));
          _reconnect();
        },
        onDone: () {
          emit(NumberPlateDisconnected());
          _reconnect();
        },
      );
    } catch (e) {
      emit(NumberPlateError("Failed to connect"));
      _reconnect();
    }
  }

  /// 🔁 Auto reconnect
  void _reconnect() {
    isConnected = false;

    Future.delayed(const Duration(seconds: 2), () {
      connect();
    });
  }

  /// 📤 Send frame
  void sendFrame(Uint8List bytes) {
    if (!isConnected) return;

    try {
      _channel?.sink.add(base64Encode(bytes));
    } catch (_) {
      emit(NumberPlateError("Failed to send frame"));
    }
  }

  /// 🔌 Disconnect
  void disconnect() {
    _subscription?.cancel();
    _channel?.sink.close();
    isConnected = false;
    emit(NumberPlateDisconnected());
  }

  @override
  Future<void> close() {
    disconnect();
    return super.close();
  }
}