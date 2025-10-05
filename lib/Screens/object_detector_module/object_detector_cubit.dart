import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'object_detector_state.dart';

class ObjectDetectorCubit extends Cubit<ObjectDetectorState> {
  ObjectDetectorCubit() : super(ObjectDetectorInitial());
}
