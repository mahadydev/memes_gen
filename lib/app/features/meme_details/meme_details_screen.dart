import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:memes_app/app/models/meme.dart';
import 'package:memes_app/app/utils/device.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:saver_gallery/saver_gallery.dart';

class MemeDetailsScreen extends StatelessWidget {
  const MemeDetailsScreen({super.key, required this.meme});

  final MemeModel meme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meme.name),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProImageEditor.network(
                    meme.url,
                    callbacks: ProImageEditorCallbacks(
                      onImageEditingComplete: (Uint8List bytes) async {
                        final gotPermission = await DeviceUtil.getPermission();
                        debugPrint('$gotPermission');

                        if (gotPermission) {
                          final result = await SaverGallery.saveImage(
                            Uint8List.fromList(bytes),
                            quality: 100,
                            name: meme.url.split('/').last,
                            androidExistNotSave: false,
                          );
                          debugPrint(result.toString());
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(result.isSuccess
                                  ? 'Image is saved to gallery'
                                  : 'Something went wrong!'),
                            ),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
                    ),
                    configs: const ProImageEditorConfigs(
                      helperLines: HelperLines(
                        showVerticalLine: true,
                        showHorizontalLine: true,
                        showRotateLine: true,
                        hitVibration: true,
                      ),
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Hero(
              tag: meme.url,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/meme.png',
                image: meme.url,
                width: meme.width.toDouble(),
                height: meme.height.toDouble(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
