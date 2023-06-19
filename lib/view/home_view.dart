import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vote_detection_app/providers/tflite_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TFliteController controller = context.watch();

    String output = controller.outputs.isEmpty
        ? ""
        : controller.outputs.first["label"].substring(2) + " %" + (controller.outputs.first["confidence"] * 100).toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Vote Detection App"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 380,
              width: MediaQuery.of(context).size.width,
              child: controller.pickedFile == null
                  ? Image.asset(
                      "assets/images/app_image.jpeg",
                      fit: BoxFit.fitWidth,
                    )
                  : Image.file(
                      controller.pickedFile!,
                      fit: BoxFit.fitWidth,
                    ),
            ),
            const SizedBox(height: 30),
            Text(
              "Outputs: $output ",
              style: textTheme.headlineMedium,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () => controller.handlePhoto(ImageSource.camera),
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Take a photo",
                    style: textTheme.labelLarge?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 30),
                MaterialButton(
                  onPressed: () => controller.handlePhoto(ImageSource.gallery),
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Pick from gallery",
                    style: textTheme.labelLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
