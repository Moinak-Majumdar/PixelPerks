import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pixelperks/screens/detailed.dart';
import 'package:pixelperks/utils/screen_operation.dart';
import 'package:pixelperks/widget/center_error.dart';
import 'package:pixelperks/widget/center_loader.dart';

final screenOperation = ScreenOperation();
Future<List<FileSystemEntity>> alreadyDownloaded() async {
  final permission = await screenOperation.handlePermission();

  if (permission) {
    final exists =
        Directory('/storage/emulated/0/Pictures/PixelPerks').existsSync();

    if (exists) {
      return Directory('/storage/emulated/0/Pictures/PixelPerks').listSync();
    }
  }

  return [];
}

class Downloaded extends StatelessWidget {
  const Downloaded({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Downloaded',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: alreadyDownloaded(),
            builder: (ctx, snap) {
              if (snap.hasError) {
                return const CenterError();
              }

              if (snap.hasData) {
                final data = snap.data;

                if (data!.isEmpty) {
                  return const CenterError.custom(
                    error: 'Nothing found at app directory.',
                  );
                }

                return GridView.custom(
                  gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount: 4,
                    pattern: const [
                      QuiltedGridTile(4, 2),
                      QuiltedGridTile(3, 2),
                      QuiltedGridTile(4, 2),
                      QuiltedGridTile(4, 2),
                    ],
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    repeatPattern: QuiltedGridRepeatPattern.inverted,
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final file = File(data[index].path);
                      final fileName = file.path.split('/').last;
                      final imgId = fileName.split('.').first;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Detailed(
                                imageId: int.parse(imgId),
                                isSafe: false,
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            file,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    childCount: data.length,
                  ),
                );
              }

              return const CenterLoader(msg: 'Reading directory ...');
            },
          ),
        ),
      ),
    );
  }
}
