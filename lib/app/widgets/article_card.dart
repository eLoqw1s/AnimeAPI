import 'package:android_dev/data/data.dart';
import 'package:android_dev/domain/repository/model/article.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:android_dev/app/app.dart';
class ArticleCard extends StatelessWidget {

  final Article article;

  const ArticleCard({ super.key, required this.article });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, 
        border: Border.all(color: const Color.fromARGB(255, 248, 205, 205), width: 1), 
        borderRadius: BorderRadius.circular(5),
      ),
      child:InkWell(
        onTap: () {
          Endpoints.animeById = Endpoints.animeById.replaceAll('ID', article.id.toString());
          context.go('/home/article/${article.id}');
        },
        borderRadius: BorderRadius.circular(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                article.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5), 
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical, 
                    child: SelectableText(
                      article.link,
                      maxLines: 4,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}