import 'package:app_test_with_backend/features/login/data/datasource/interfaces/firebase_login.dart';
import 'package:app_test_with_backend/features/login/domain/entities/UserEntity.dart';
import 'package:app_test_with_backend/features/login/presentation/bloc/auth_bloc.dart';
import 'package:app_test_with_backend/features/login/presentation/bloc/auth_event.dart';
import 'package:app_test_with_backend/features/login/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();

    super.dispose();
  }

  void logout() {
    context.read<AuthBloc>().add(LogoutRequested());
    context.goNamed("login");

  }

  @override
  Widget build(BuildContext context) {
    late final UserEntity user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MON PROFIL'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // context;
          },
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: const CircularProgressIndicator());
          }

          if (state is GetProfilState) {
            // Navigator.pushNamed(context, '/headlines');
            user = state.user;
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Icon(Icons.mail_outline, size: 45),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(child: Text('Mon Profil')),

                  const SizedBox(height: 8),
                  // ------------------------------------------------
                  // EMAIL
                  // ------------------------------------------------
                  Text('Adresse email'),
                  const SizedBox(height: 8),
                  TextFormField(
                    // controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    initialValue: user.email,
                    // initialValue: "monemail@gmail.con.com",
                    decoration: InputDecoration(
                      hintText: 'monemail@gmail.con.com',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text('Mot de passe'),
                  const SizedBox(height: 8),
                  TextFormField(
                    // controller: _nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    initialValue: user.name,
                    // initialValue: "monemail@gmail.con.com",

                  ),

                  const SizedBox(height: 20),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator();
                      }

                      if (state is AuthUnauthenticated) {
                        // return const CircularProgressIndicator();
                      }
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: logout,
                          child: const Text('Se deconnecter'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
          return ElevatedButton(onPressed: (){
            context.read<AuthBloc>().add(GetProfilEvent());
          }, child: Text('Charger mon profil'));

          //context.pushNamed("login");
        },
        listener: (BuildContext context, AuthState state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
      ),
    );
  }
}
