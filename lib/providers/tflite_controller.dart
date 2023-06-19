import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class TFliteController extends ChangeNotifier {
  static final TFliteController _instance = TFliteController._init();

  static TFliteController get instance => _instance;
  TFliteController._init();

  final String _labelPath = "assets/labels.txt";
  final String _modelPath = "assets/model_unquant.tflite";

  File? pickedFile;
  List outputs = [];

  static initModel() async {
    String? response = await Tflite.loadModel(
      model: instance._modelPath,
      labels: instance._labelPath,
    );

    log(response.toString());
  }

  Future<void> handlePhoto(ImageSource imageSource) async {
    final PickedFile? image = await ImagePicker.platform.pickImage(source: imageSource);
    if (image == null) return;

    final File file = File(image.path);
    pickedFile = file;
    classifyImage(file);
  }

  Future<void> classifyImage(File file) async {
    List<dynamic>? output = await Tflite.runModelOnImage(
      path: file.path,
      imageMean: 127.5,
      imageStd: 127.5,
      threshold: .5,
      numResults: 2,
    );
    if (output == null) return;
    outputs = output;
    notifyListeners();
  }
}
