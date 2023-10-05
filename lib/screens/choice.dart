import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixelperks/controller/safe_content_controller.dart';
import 'package:pixelperks/model/category_item.dart';
import 'package:pixelperks/screens/categorized.dart';

class Choice extends StatelessWidget {
  const Choice({super.key});

  @override
  Widget build(context) {
    final textTheme = Theme.of(context).textTheme;

    SafeContentController scc = Get.put(SafeContentController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(
          () => GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            scrollDirection: Axis.horizontal,
            children: [
              for (final elm
                  in scc.safeContent.value ? safeCategoryItem : categoryItems)
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Categorized(item: elm),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(4),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/images/thumbs/${elm.title}.jpg',
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Center(
                          child: Text(
                            elm.title,
                            style: textTheme.headlineMedium!.copyWith(
                              color: elm.isSafe
                                  ? Colors.white
                                  : const Color.fromARGB(255, 255, 0, 153),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
