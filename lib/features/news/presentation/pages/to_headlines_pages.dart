import 'package:app_test_with_backend/core/utilities/Responsive.dart';
import 'package:app_test_with_backend/features/news/presentation/bloc/news_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ToHeadlinesPages extends StatelessWidget{
  Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    // context.read<NewsBloc>().add(TopHeadlinesEvent(search: "", country: "us", page: 0));
    final location = GoRouterState.of(context).uri.path;

    int currentIndex = 0;

    if (location.startsWith('/headlines')) {
      currentIndex = 0;
    } else if (location.startsWith('/all')) {
      currentIndex = 1;
    } else if (location.startsWith('/sources')) {
      currentIndex = 2;
    }

    return Scaffold(
      bottomNavigationBar: responsive.isMobile(context)
          ? BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.goNamed('headlines');
              break;

            case 1:
              context.goNamed('all-news');
              break;

            case 2:
              context.goNamed('sources');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'TOP NEWS',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox),
            label: 'Tout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.source_rounded),
            label: 'Sources',
          ),
        ],
      )
          : null,
        appBar: AppBar(
          title: const Text('NEWS'),
          actions: [
            IconButton(
              onPressed: () {
          print('CLICK PROFIL');
          print('ROUTE ACTUELLE : ${GoRouterState.of(context).uri.path}');

            context.pushNamed("profil");
          print('APRES PUSH');

              },
              icon: Icon(Icons.person),
            ),
          ],

        ),
       body: BlocConsumer<NewsBloc,NewsState>(

           builder: (context,state){

             if(state is NewsLoadingState){
               return const Center(
                 child: const CircularProgressIndicator(
                 ),
               );
             }
             if(state is LoadedTopHeadLinesState){
               return ListView.builder(
                 itemCount: state.articles.length,
                   itemBuilder: (context,index){
                     final item=state.articles[index];
                     return ListTile(
                       leading: CircleAvatar(backgroundImage: NetworkImage(item.urlToImage),),
                     title:  Text(item.title),
                     subtitle:  Text(item.title),
                   );
                   }
               );
             }
             return  Center(
                 child: ElevatedButton(onPressed: (){
                   context.read<NewsBloc>().add(TopHeadlinesEvent(search: "", country: "us", page: 0));
                 },
                     child: const Text("Charger les donnees")),
             );
           },
           listener: (context,state){
             if(state is ArticlesErrorState){
               // print("ERROR::${state.toString()}");
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.props[0].toString()),)
               );
             }
           }
       ),
     );

  }
  
}