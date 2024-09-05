import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_devarchitecture/routes/routes_constants.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/widgets/inputs/dropdown_button.dart';
import '../../core/widgets/inputs/email_input.dart';
import '../../core/widgets/inputs/password_input.dart';
import '../../core/theme/extensions.dart';

import '../../core/bloc/base_state.dart';
import '../../core/constants/messages.dart';
import '../../core/di/core_initializer.dart';
import 'bloc/auth_cubit.dart';
import '../layouts/base_scaffold.dart';
import 'models/auth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return buildBaseScaffold(context, buildLoginForm(context), isDrawer: false);
  }

  Widget buildLoginForm(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, BaseState>(listener: (context, state) {
          if (state is BlocFailed) {
            CoreInitializer()
                .coreContainer
                .screenMessage
                .getErrorMessage(state.message);
          }
          if (state is BlocSuccess<String>) {
            CoreInitializer().coreContainer.screenMessage.getInfoMessage(
                  state.result!,
                );
            Modular.to.navigate(RoutesConstants.appHomePage);
          }
        }, builder: (context, state) {
          if (state is BlocLoading) {
            CoreInitializer()
                .coreContainer
                .screenMessage
                .getInfoMessage(state.message);
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BlocChecking) {
            CoreInitializer()
                .coreContainer
                .screenMessage
                .getInfoMessage(state.message);
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BlocSending) {
            CoreInitializer()
                .coreContainer
                .screenMessage
                .getInfoMessage(state.message);
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: SizedBox(
              height: context.percent70Screen,
              width: context.percent50Screen,
              child: Column(
                children: [
                  const Spacer(),
                  context.isMobile
                      ? Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Spacer(
                                flex: 2,
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomDropdownButton(
                                  icon: Icons.language_rounded,
                                  getFirstValue: (p0) {
                                    print(p0);
                                  },
                                  onChanged: (p0) {
                                    print(p0);
                                  },
                                  options: const ["Tr", "En"],
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Expanded(
                          flex: 2,
                          child: Text(
                            "Giriş Ekranı",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                  Expanded(
                    flex: 5,
                    child: Form(
                        key: _form,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CustomEmailInput(
                                contentPadding: 2,
                                labelText: 'E-mail',
                                controller: _emailController,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: CustomPasswordInput(
                                  passwordController: _passwordController),
                            ),
                            context.isMobile
                                ? const SizedBox()
                                : Expanded(
                                    flex: 2,
                                    child: CustomDropdownButton(
                                      icon: Icons.language_rounded,
                                      getFirstValue: (p0) {
                                        print(p0);
                                      },
                                      onChanged: (p0) {
                                        print(p0);
                                      },
                                      options: const ["Türkçe", "English"],
                                    ),
                                  )
                          ],
                        )),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () async {
                        BlocProvider.of<AuthCubit>(context).emitCheckingState();
                        if (!_form.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).emitFailState(
                              Messages.formValidationErrorMessage);
                          return;
                        }
                        await BlocProvider.of<AuthCubit>(context).login(
                            AuthRequestBasic(
                                email: _emailController.text,
                                password: _passwordController.text));
                      },
                      child: const Text("Giriş Yap"),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
