import 'package:app_test_with_backend/core/utilities/Responsive.dart';
import 'package:app_test_with_backend/features/login/presentation/bloc/auth_bloc.dart';
import 'package:app_test_with_backend/features/login/presentation/bloc/auth_event.dart';
import 'package:app_test_with_backend/features/login/presentation/bloc/auth_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passworController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passworController.dispose();

    super.dispose();
  }

  void login() {
    if (!_formKey.currentState!.validate()) return;
    print("VALIDER:${_emailController.text}");
    context.read<AuthBloc>().add(
      LoginRequested(
        email: _emailController.text.trim(),
        password: _passworController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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

      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is AuthAuthenticated) {
            // Navigator.pushNamed(context, '/headlines');
            context.pushReplacementNamed("headlines");
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
                    color: theme.colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.mail_outline,
                    size: 45,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  'Se connecter',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),
              // ------------------------------------------------
              // EMAIL
              // ------------------------------------------------
              Text(
                'Adresse email',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
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
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
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
                      onPressed: login,
                      child: const Text('Se connecter'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()=> {context.pushNamed("register")},
                child: const Text('Creer un compte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
