import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';
import 'package:social_app/screens/auth_screens/register_screen.dart';
import '../../components/widgets.dart';
import '../../shared/shared_prefernce.dart';
import '../home_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialLoginSuccessState){
          CashHelper.setData(key: 'uId', value: state.uId).then((value) {
            if(value) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomeScreen()));
            }
          });
        }
      },
      builder: (context,state){
        var cubit = SocialCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/images/login.png'),
                      color: Colors.black26,
                      width: 200,
                      height: 300,
                    ),
                    const Row(
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Row(
                      children: [
                         Text(
                          'Email',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        prefix: Icons.email,
                        hintText: "Email",
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Email must not be empty';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        prefix: Icons.lock,
                        hintText: "Password",
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Password must not be empty';
                          }
                          return null;
                        },
                        obscureText: cubit.isSecure,
                        suffix: cubit.isSecure == true
                            ? Icons.remove_red_eye
                            : Icons.visibility_off,
                        suffixPressed: () {
                          cubit.changeVisibility();
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                        condition: state is! SocialLoginLoadingState,
                        builder: (context){
                      return defaultButton(
                          text: 'LOGIN',
                          onPressed: () {
                            if (formKey.currentState!.validate()){
                              cubit.userLoginProcess(context,email: emailController.text,
                                  password: passwordController.text
                              );
                               cubit.getUserData();
                               cubit.getAllUsers();
                               cubit.getPosts();
                            }
                          });
                    },
                        fallback: (context)=>const Center(child: CircularProgressIndicator())
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: TextStyle(fontSize: 18),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                            },
                            child: const Text(
                              'REGISTER',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
