
import 'dart:typed_data';
abstract class UpdateEvent {}

class UpdateRequest extends UpdateEvent{
  Uint8List data;
  String dest;
  UpdateRequest(this.data,this.dest);
}