import 'package:app_test_with_backend/features/news/presentation/bloc/news_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SourcesPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    context.read<NewsBloc>().add(
      SourcesEvent(country: "us", page: 0),
    );
    return Scaffold(
        appBar: AppBar(title: const Text('ALL NEWS')),
        body: BlocConsumer<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoadingState) {
              return const Center(child: const CircularProgressIndicator());
            }
            if (state is LoadedSourcesState) {
              return ListView.builder(
                itemCount: state.sources.length,
                itemBuilder: (context, index) {
                  final item = state.sources[index];
                  return ListTile(
                    title: Text(item.id),
                    subtitle: Text(item.name),
                  );
                },
              );
            }
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<NewsBloc>().add(

                    SourcesEvent(country: "us", page: 0),
                  );
                },
                child: const Text("Charger les donnees"),
              ),
            );
          },
          listener: (context, state) {
            if (state is ArticlesErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.props[0].toString() + "ERREUR")),
              );
            }
          })



    );
  }

}