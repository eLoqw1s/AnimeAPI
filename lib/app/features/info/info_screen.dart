import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:android_dev/app/app.dart';
import 'package:android_dev/di/di.dart';
import 'package:android_dev/domain/domain.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});
  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final _infoBloc = InfoBloc(getIt<AnimeByIdRepository>());
  final _favouritesBloc = getIt<FavouritesBloc>();
  
  bool _isFavourite = false;

  @override
  void initState() {
    _infoBloc.stream.listen((state) {
      if (state is InfoLoadSuccess) {
        _checkIfFavourite(state.articles.id);
      }
    });
    super.initState();
    _infoBloc.add(const InfoLoad());
  }

  void _toggleFavourite(Article article) {
    if (_isFavourite) {
      _favouritesBloc.add(FavouritesDelete(article.id)); 
    } else {
      _favouritesBloc.add(FavouritesAdd(
        id: article.id,
        title: article.title,
        image: article.image,
        link: article.link,
        synopsis: article.synopsis,
      ));
    }
    setState(() {
      _isFavourite = !_isFavourite;
    });
  }

  Future<void> _checkIfFavourite(String id) async {
    final CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');
      
    try {
      QuerySnapshot snapshot = await favorites
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favourites')
          .get();

      bool isFavourite = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>)
        .toList().any((favorite) => favorite['_id'] == id);

      setState(() {
        _isFavourite = isFavourite;
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Details',
          ),
          actions: [
          BlocBuilder<InfoBloc, InfoState>(
            bloc: _infoBloc,
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  _isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavourite ? Colors.red : null,
                ),
                onPressed: () {
                  if (state is InfoLoadSuccess) {
                    Article articles = state.articles;
                    _toggleFavourite(articles);
                  }
                },
              );
            },
          ),
        ],
        ),
      body: BlocBuilder<InfoBloc, InfoState>(
        bloc: _infoBloc,
        builder: (context, state) {
          if (state is InfoLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is InfoLoadSuccess) {
            Article articles = state.articles;

            //_isFavourite = _favouritesBloc.add(CheckFavoriteEvent(articles.id));
            //_checkIfFavourite(articles.id);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        width: 500,
                        height: 500,
                        articles.image,
                        //fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //20.ph,
                  Text(
                    articles.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  10.ph,
                  Text(
                    articles.synopsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          }
          if (state is InfoLoadFailure) {
            return ErrorCardInfo(
              title: 'Error',
              description: state.exception.toString(),
              onReload: () {
                _infoBloc.add(const InfoLoad());
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class ErrorCardInfo extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onReload;

  const ErrorCardInfo({
    super.key,
    required this.title,
    required this.description,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Column(
          children: [
            Text(title),
            Text(description),
            ElevatedButton(
              onPressed: onReload,
              child: const Text('Reload'),
            ),
          ],
        ),
      )
    );
  }
}