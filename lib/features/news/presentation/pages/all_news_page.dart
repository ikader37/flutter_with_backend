import 'package:app_test_with_backend/features/news/presentation/bloc/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<NewsBloc>().add(
      AllNewsEvent(search: "", country: "us", page: 0),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('ALL NEWS')),
      body: BlocConsumer<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadingState) {
            return const Center(child: const CircularProgressIndicator());
          }
          if (state is LoadedNewsState) {
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final item = state.articles[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(item.urlToImage),
                  ),
                  title: Text(item.title),
                  subtitle: Text(item.title),
                );
              },
            );
          }
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<NewsBloc>().add(
                  AllNewsEvent(search: "", country: "us", page: 0),
                );
              },
              child: const Text("Charger les donnees"),
            ),
          );
        },
        listener: (context, state) {
          if (state is ArticlesErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.props[0].toString() )),
            );
          }
        },
      ),
    );
  }
}
