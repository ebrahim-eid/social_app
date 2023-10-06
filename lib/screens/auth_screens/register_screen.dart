import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/cubit/social_states.dart';

import '../../components/widgets.dart';

class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialUserSuccessState){
          // transferPage(context);
        }
      },
      builder: (context,state){
        var cubit = SocialCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Register now to communicate with friends',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      defaultFormField(
                        labelText: "Enter your name",
                          controller: nameController,
                          type: TextInputType.text,
                          prefix: Icons.person,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Name must not be empty';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          labelText: "Enter your phone",
                          controller: phoneController,
                          type: TextInputType.phone,
                          prefix: Icons.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Your phone number must not be empty';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          labelText: "Enter your Email",
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          prefix: Icons.email,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Email must not be empty';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          labelText: "Create password",
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock,
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
                    ConditionalBuilder(condition: state is! SocialRegisterLoadingState,
                        builder: (context){
                      return   defaultButton(
                          text: 'SIGN UP',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {

                                cubit.userRegisterProcess(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                            }
                          });
                        },
                        fallback: (context)=>const Center(child: CircularProgressIndicator())),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have one!',
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
