import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:android_dev/app/app.dart'; 
import 'package:android_dev/di/di.dart';
import 'package:android_dev/domain/domain.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final AuthBloc _authBloc = AuthBloc(getIt<AuthService>());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/home');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registration was successful!'),
                backgroundColor: Color.fromARGB(255, 5, 160, 82),
              ),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: _authBloc,
          builder: (context, state) {
            if (state is AuthInProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AuthFailure) {
              return ErrorCardReg(
                title: 'Error',
                description: state.error,
                onReload: () {
                  _authBloc.add(ResetAuth());
                },
              );
            }
            return Scaffold (
              backgroundColor: Colors.grey[300],
              body: SafeArea (
                child: Center (
                  child: SingleChildScrollView (
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon (
                          Icons.android,
                          size: 100,
                        ),
                        75.ph,

                        Text (
                          'Hello There!',
                          style: GoogleFonts.bebasNeue (
                            fontSize: 52,
                          ),
                        ),
                        10.ph,
                        const Text (
                          'Register below with your details!',
                          style: TextStyle (
                            fontSize: 18,
                          )
                        ),
                        50.ph,

                        // email textfield
                        Padding (
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField (
                            controller: emailControllerReg,
                            decoration: InputDecoration (
                              enabledBorder: OutlineInputBorder (
                                borderSide: const BorderSide (color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder:OutlineInputBorder (
                                borderSide: const BorderSide (color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Email',
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                        10.ph,

                        // password textfield
                        Padding (
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField (
                            obscureText: true,
                            controller: passwordControllerReg,
                            decoration: InputDecoration (
                              enabledBorder: OutlineInputBorder (
                                borderSide: const BorderSide (color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder:OutlineInputBorder (
                                borderSide: const BorderSide (color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Password',
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                        10.ph,

                        // confirm password
                        Padding (
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField (
                            obscureText: true,
                            controller: confirmPasswordControllerReg,
                            decoration: InputDecoration (
                              enabledBorder: OutlineInputBorder (
                                borderSide: const BorderSide (color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder:OutlineInputBorder (
                                borderSide: const BorderSide (color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Confirm Password',
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                        10.ph,

                        // sign button
                        Padding (
                          padding:  const EdgeInsets.symmetric(horizontal: 25.0),
                          child: GestureDetector(
                            onTap: () {
                              if(passwordControllerReg.text.trim() == confirmPasswordControllerReg.text.trim()){
                                _authBloc.add(SignUpRequested(
                                  email: emailControllerReg.text,
                                  password: passwordControllerReg.text,
                                ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Passwords don\'t match! Please check the input.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: Container (
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration (
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center (
                                child: Text (
                                  'Sign Up',
                                  style: TextStyle (
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )
                                ),
                              ),
                            ),
                          ),
                        ),
                        25.ph,

                        // not a member? register now
                        Row (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text (
                              'I am a member!',
                              style: TextStyle (
                                fontWeight: FontWeight.bold,
                              )
                            ),
                            GestureDetector (
                              onTap: () {
                                context.go('/auth');
                              },
                              child: const Text (
                                ' Login now',
                                style: TextStyle (
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ),
                ),
              )
            );



            // return SingleChildScrollView(
            //   padding: const EdgeInsets.all(20),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       TextField(
            //         controller: emailControllerReg,
            //         decoration: const InputDecoration(labelText: 'Email'),
            //       ),
            //       TextField(
            //         controller: passwordControllerReg,
            //         decoration: const InputDecoration(labelText: 'Password'),
            //         obscureText: true,
            //       ),
            //       const SizedBox(height: 20),
            //       ElevatedButton(
            //         onPressed: () {
            //           _authBloc.add(SignUpRequested(
            //             email: emailControllerReg.text,
            //             password: passwordControllerReg.text,
            //           ));
            //         },
            //         child: const Text('Sign Up'),
            //       ),
            //       ElevatedButton(
            //         onPressed: () {
            //           _authBloc.add(LogInRequested(
            //             email: emailControllerReg.text,
            //             password: passwordControllerReg.text,
            //           ));
            //         },
            //         child: const Text('Log In'),
            //       ),
            //       ElevatedButton(
            //         onPressed: () {
            //           _authBloc.add(LogOutRequested());
            //         },
            //         child: const Text('Log Out'),
            //       ),
            //     ],
            //   ),
            // );
          },
        ),
      ),
    );
  }
}


class ErrorCardReg extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onReload;

  const ErrorCardReg({
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

final TextEditingController emailControllerReg = TextEditingController();
final TextEditingController passwordControllerReg = TextEditingController();
final TextEditingController confirmPasswordControllerReg = TextEditingController();
