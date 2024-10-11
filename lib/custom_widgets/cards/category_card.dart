import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';

class CategoryCard extends StatelessWidget {
  final Color color;
  final String title;
  final int count;
  final int percentage;
  final List<String> images;

  const CategoryCard({super.key, required this.color, required this.title, required this.count, required this.images, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            width: 250,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadiusDirectional.circular(8)
                  ),

                  child: const Icon(
                    Icons.tv,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 8),


                Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
                ),
                const SizedBox(height: 8),

                Text(
                    count.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    )
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 8,
          ),


          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                ImageStack(
                  imageList: images,
                  totalCount: images.length,
                  imageRadius: 43,
                  imageCount: 3,
                  imageBorderWidth: 3,
                ),

                Text(
                    '$percentage%',
                  style: const TextStyle(
                    fontSize: 14
                  ),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 16,
          ),

        ],
      ),
    );
  }
}
