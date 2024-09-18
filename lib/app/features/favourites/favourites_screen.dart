import 'package:android_dev/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:android_dev/di/di.dart';
import 'package:android_dev/domain/domain.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  //final FavouritesBloc _favouritesBloc = FavouritesBloc(getIt<FavouritesService>());
  final _favouritesBloc = getIt<FavouritesBloc>();

  @override
  void initState() {
    _favouritesBloc.add(FavouritesGet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: Container(
        color: Colors.lightBlue[50],
        child: BlocListener<FavouritesBloc, FavouritesState>(
          bloc: _favouritesBloc,
          listener: (context, state) {
            if (state is FavouritesFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<FavouritesBloc, FavouritesState>(
            bloc: _favouritesBloc,
            builder: (context, state) {
              if (state is FavouritesInProgress) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is FavouritesSuccess) {
                final List<Article> favourites = state.favourites;
                if (favourites.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite_border, size: 80, color: Color.fromARGB(255, 241, 78, 78)), // Иконка
                          SizedBox(height: 16),
                          Text(
                            'There is nothing in favorites yet.',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Add articles to your favorites to see them here.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: favourites.length,
                  itemBuilder: (context, index) {
                    return FavouritesCard(article: favourites[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20);
                  },
                );
              }
              if (state is FavouritesFailure) {
              return ErrorCardFav(
                title: 'Ошибка',
                description: state.error,
                onReload: () {
                  //_favouritesBloc.add(FavouritesGet());
                },
              );
            }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

class ErrorCardFav extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onReload;

  const ErrorCardFav({
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 8),
              Text(description),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onReload,
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}