import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:android_dev/app/app.dart';
import 'package:android_dev/di/di.dart';
import 'package:android_dev/domain/domain.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeBloc = HomeBloc(getIt<TopAnimeRepository>());
  final AuthBloc _authBloc = AuthBloc(getIt<AuthService>());
  @override
  void initState() {
    _homeBloc.add(const HomeLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home Page',
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                context.go('/home/favourites');
              },
              tooltip: 'Favourites',
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                _authBloc.add(LogOutRequested());
              },
              tooltip: 'LogOut',
            ),
          ],
        ),

        body: Container( 
          color: Colors.lightBlue[50], 
          child: BlocListener<AuthBloc, AuthState>(
            bloc: _authBloc,
            listener: (context, state) {
              if (state is AuthSuccess) {
                context.go('/auth');
              }
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Exit error!'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (state is AuthInProgress) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bye Bye!'),
                    backgroundColor: Color.fromARGB(255, 54, 222, 244),
                  ),
                );
              }
            },
            child: BlocBuilder<HomeBloc, HomeState>(
              bloc: _homeBloc,
              builder: (context, state) {
              if (state is HomeLoadInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is HomeLoadSuccess) {
                List<Article> articles = state.articles;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anime',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      20.ph,
                      ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return ArticleCard(
                            article: articles[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return 20.ph;
                        },
                      ),
                    ],
                  ),
                );
              }
              if (state is HomeLoadFailure) {
                return ErrorCard(
                  title: 'Error',
                  description: state.exception.toString(),
                  onReload: () {
                    _homeBloc.add(const HomeLoad());
                  },
                );
              }
              return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onReload;

  const ErrorCard({
    super.key,
    required this.title,
    required this.description,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}