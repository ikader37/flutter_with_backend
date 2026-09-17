import 'package:app_test_with_backend/core/di/dio_client.dart';
import 'package:app_test_with_backend/core/storage/hive_service.dart';
import 'package:app_test_with_backend/features/login/data/datasource/impl/remote_auth_data_source_impl.dart';
import 'package:app_test_with_backend/features/login/data/datasource/interfaces/remote_auth_data_source.dart';
import 'package:app_test_with_backend/features/login/data/repositories/AuthRepositoryImpl.dart';
import 'package:app_test_with_backend/features/login/domain/usecases/Login_use_case.dart';
import 'package:app_test_with_backend/features/login/domain/usecases/profile_use_case.dart';
import 'package:app_test_with_backend/features/login/presentation/bloc/auth_bloc.dart';
import 'package:app_test_with_backend/features/news/data/datasource/impl/local_article_data_source_impl.dart';
import 'package:app_test_with_backend/features/news/data/datasource/impl/remote_article_data_source_impl.dart';
import 'package:app_test_with_backend/features/news/data/models/ArticleLocalModel.dart';
import 'package:app_test_with_backend/features/news/data/repositories/ArticleRepositoryImpl.dart';
import 'package:app_test_with_backend/features/news/domain/usecases/all_news_usecase.dart';
import 'package:app_test_with_backend/features/news/domain/usecases/sources_usecase.dart';
import 'package:app_test_with_backend/features/news/domain/usecases/top_head_lines_usecase.dart';
import 'package:app_test_with_backend/features/news/presentation/bloc/news_bloc.dart';
import 'package:app_test_with_backend/features/register/data/datasource/impl/remote_register_data_source_impl.dart';
import 'package:app_test_with_backend/features/register/data/datasource/interfaces/remote_register_data_source.dart';
import 'package:app_test_with_backend/features/register/data/datasource/register_repository_impl.dart';
import 'package:app_test_with_backend/features/register/domain/repositories/register_repository.dart';
import 'package:app_test_with_backend/features/register/domain/usecases/register_use_case.dart';
import 'package:app_test_with_backend/features/register/presentation/bloc/register_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';

import 'core/routers/go_router.dart';
import 'features/news/data/models/SourceLocalModel.dart';
import 'firebase_options.dart';

void main() async{
  // Indispensable avant toute interaction avec le code natif
  WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
  HiveService.init();


  final articlesBox = await Hive.openBox<ArticleLocalModel>('articles');
  final sourcesBox = await Hive.openBox<SourceLocalModel>('sources');
  final headlinesBox = await Hive.openBox<ArticleLocalModel>('headlines');

  final localDataSource = LocalArticleDataSourceImpl(
    articlesBox: articlesBox,
    sourcesBox: sourcesBox,
    headlinesBox: headlinesBox,
  );
  // Initialisation de Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebaseAuth = FirebaseAuth.instance;

  final dataSource = RemoteAuthDataSourceImpl(firebaseAuth);
final registerDataSource=RemoteRegisterDataSourceImpl(firebaseAuth);
  final repository = Authrepositoryimpl(remoteAuthDataSource: dataSource);
final _registerRepository=RegisterRepositoryImpl(remoteRegister:registerDataSource);
  final loginUseCase = LoginUseCase(repository);
  final getProfilUseCase = GetProfilUseCase(repository);
  final FlutterSecureStorage storage=FlutterSecureStorage();


  final dio=DioClient(storage: storage);
  final _remote_article=RemoteArticleDataSourceImpl(dio:dio);
  final _articleRepository=Articlerepositoryimpl(remoteArticleDataSource:_remote_article,localArticleDataSource: localDataSource);


  final TopHeadLinesUseCase _topHeadLinesUseCase=TopHeadLinesUseCase(_articleRepository);
  final AllNewsUsecase _allNewUseCase=AllNewsUsecase(_articleRepository);
  final SourcesUsecase _sourcesUseCase=SourcesUsecase(_articleRepository);

  // Initialisation de Firebase avec les options de la plateforme courante
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
        providers: [
    BlocProvider<AuthBloc>(
    create: (_) => AuthBloc(
    loginUseCase: loginUseCase,
        getProfilUseCase: getProfilUseCase),

  ),

  BlocProvider<RegisterBloc>(
  create: (_) => RegisterBloc(
  registerUseCase: RegisterUseCase(_registerRepository),
  ),
  ),
  BlocProvider<NewsBloc>(
  create: (_) => NewsBloc(
  _allNewUseCase,
_sourcesUseCase,
  _topHeadLinesUseCase
  )

  )
  ],

      child:const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Backend',

      routerConfig: appRouter,

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context)  {

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('WELCOME'),
            ElevatedButton(onPressed: ()=> {context.pushNamed("login")},
                child: const Text("Se connecter")
            ),
            ElevatedButton(onPressed: ()=> {context.pushNamed("register")},
                child: const Text("Creer un compte")
            )

          ],
        ),
      ),

    );
  }
}
