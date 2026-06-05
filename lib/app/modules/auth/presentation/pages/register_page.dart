import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/auth/presentation/controller/auth_bloc.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/app/widgets/inputs/inputs.dart';
import 'package:mnb_mobile/theme/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _bloc = Modular.get<AuthBloc>();

  String _role = 'client';

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      _bloc.add(
        RegisterEvent(
          name: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          role: _role,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registrasi berhasil. Silakan login.'),
              ),
            );
            Modular.to.pop();
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final loading = state is AuthLoading;
          return BaseBodyPage(
            children: [
              SliverToBoxAdapter(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/png/logo-app.png'),
                          Text(
                            "Design Your Legacy",
                            style: Theme.of(context).textTheme.displayMedium!
                                .copyWith(
                                  fontStyle: GoogleFonts.ptSerif().fontStyle,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Discover curated furniture pieces that transform your house into a dream home",
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  fontStyle: GoogleFonts.ptSerif().fontStyle,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Sign Up",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            controller: _usernameController,
                            label: 'Name',
                            hint: 'Nama lengkap',
                            isRequired: true,
                            prefixIcon: Icons.person_outline,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.trim().length < 2) {
                                return 'Name minimal 2 karakter';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            controller: _emailController,
                            label: 'Email',
                            hint: 'you@example.com',
                            isRequired: true,
                            prefixIcon: Icons.mail_outline,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Format email tidak valid';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            controller: _passwordController,
                            label: 'Password',
                            hint: 'Minimal 8 karakter',
                            isRequired: true,
                            obscureText: true,
                            prefixIcon: Icons.lock_outline,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.length < 8) {
                                return 'Password minimal 8 karakter';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            controller: _confirmPasswordController,
                            label: 'Confirm Password',
                            hint: 'Ulangi password',
                            isRequired: true,
                            obscureText: true,
                            prefixIcon: Icons.lock_outline,
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Password tidak cocok';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppDropdownField<String>(
                            label: 'Daftar sebagai',
                            isRequired: true,
                            value: _role,
                            prefixIcon: Icons.badge_outlined,
                            items: const [
                              AppDropdownItem(
                                value: 'client',
                                label: 'Client',
                                icon: Icons.person_outline,
                              ),
                              AppDropdownItem(
                                value: 'designer',
                                label: 'Designer',
                                icon: Icons.architecture_outlined,
                              ),
                            ],
                            onChanged: (value) =>
                                setState(() => _role = value ?? 'client'),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: loading ? null : _onRegister,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: ChakraColors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: loading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        'Daftar',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              color: ChakraColors.white,
                                            ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
