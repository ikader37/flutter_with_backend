import 'package:app_test_with_backend/features/login/presentation/bloc/auth_bloc.dart';
import 'package:app_test_with_backend/features/login/presentation/bloc/auth_state.dart';
import 'package:app_test_with_backend/features/register/presentation/bloc/register_bloc.dart';
import 'package:app_test_with_backend/features/register/presentation/bloc/register_event.dart';
import 'package:app_test_with_backend/features/register/presentation/bloc/register_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passworController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passworController.dispose();
    _nameController.dispose();

    super.dispose();
  }



  void register() {
    if (!_formKey.currentState!.validate()) return;
    print("VALIDER:${_emailController.text}");
    context.read<RegisterBloc>().add(
      RegisterRequested(
        email: _emailController.text.trim(),
        password: _passworController.text.trim(),
        name: _nameController.text.trim()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SE CONNECTER'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // context;
            },
          ),
        ),

        body: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("state.message")));
              }


            },
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.mail_outline,
                      size: 45,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: Text(
                    'En registrer',

                  ),
                ),

                const SizedBox(height: 8),
                Text(
                  'Nom',

                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  // initialValue: "monemail@gmail.con.com",
                  decoration: InputDecoration(
                    hintText: 'com',
                    prefixIcon: const Icon(Icons.verified_user),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez entrer votre nom';
                    }
                    return null;
                  },
                ),
                // ------------------------------------------------
                // EMAIL
                // ------------------------------------------------
                Text(
                  'Adresse email',

                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  // initialValue: "monemail@gmail.con.com",
                  decoration: InputDecoration(
                    hintText: 'monemail@gmail.con.com',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez entrer votre email';
                    }

                    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Veuillez entrer une adresse email valide';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Text(
                  'Mot de passe',

                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passworController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  // initialValue: "monemail@gmail.con.com",
                  decoration: InputDecoration(
                    hintText: 'Votre mot de passe',
                    prefixIcon: const Icon(Icons.password_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez entrer un mot de passe';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    // if (state is AuthLoading) {
                    //   return const CircularProgressIndicator();
                    // }

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: register,
                        child: const Text('Enregistrer'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

              ],
            ),
          ),

        )
    );

  }
}
