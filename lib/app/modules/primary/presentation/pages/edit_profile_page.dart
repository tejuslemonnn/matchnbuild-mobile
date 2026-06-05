import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/data/datasource/primary_remote_datasource.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/user_model.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/profile_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/app/widgets/inputs/inputs.dart';
import 'package:mnb_mobile/theme/colors.dart';

/// Edit the current user's profile via `PATCH /user/:id` (§4.3 api.md).
///
/// Receives the [UserModel] to edit as a route argument.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, this.user});

  final UserModel? user;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _cubit = Modular.get<ProfileCubit>();
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController =
      TextEditingController(text: widget.user?.name ?? '');
  late final TextEditingController _emailController =
      TextEditingController(text: widget.user?.email ?? '');
  late final TextEditingController _pictureController =
      TextEditingController(text: widget.user?.profilePicture ?? '');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _pictureController.dispose();
    super.dispose();
  }

  void _save() {
    if (widget.user == null) return;
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final picture = _pictureController.text.trim();

    // Only send fields that actually changed (all are optional on the API).
    _cubit.update(
      widget.user!.id,
      UpdateUserRequest(
        name: name != widget.user!.name ? name : null,
        email: email != widget.user!.email ? email : null,
        profilePicture: picture != (widget.user!.profilePicture ?? '')
            ? (picture.isEmpty ? null : picture)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: const Center(child: Text('Data user tidak tersedia.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      bottomNavigationBar: BlocConsumer<ProfileCubit, ProfileState>(
        bloc: _cubit,
        listenWhen: (prev, curr) => prev.saveStatus != curr.saveStatus,
        listener: (context, state) {
          if (state.saveStatus.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profil berhasil diperbarui.')),
            );
            Modular.to.pop(true);
          } else if (state.saveStatus.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final loading = state.saveStatus.isLoading;
          return SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ChakraColors.black,
                  foregroundColor: ChakraColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ChakraColors.white,
                        ),
                      )
                    : Text(
                        'Simpan Perubahan',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontStyle: GoogleFonts.inter().fontStyle,
                          fontWeight: FontWeight.w700,
                          color: ChakraColors.white,
                        ),
                      ),
              ),
            ),
          );
        },
      ),
      body: BaseBodyPage(
        children: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: _AvatarPreview(controller: _pictureController),
                      ),
                      const SizedBox(height: 24),
                      AppTextField(
                        controller: _nameController,
                        label: 'Name',
                        hint: 'Nama lengkap',
                        isRequired: true,
                        prefixIcon: Icons.person_outline,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          final v = value?.trim() ?? '';
                          if (v.length < 2 || v.length > 100) {
                            return 'Name harus 2–100 karakter';
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
                          final v = value?.trim() ?? '';
                          if (v.isEmpty || !v.contains('@')) {
                            return 'Format email tidak valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: _pictureController,
                        label: 'Profile Picture URL',
                        hint: 'https://...',
                        prefixIcon: Icons.image_outlined,
                        keyboardType: TextInputType.url,
                        onChanged: (_) => setState(() {}),
                        validator: (value) {
                          final v = value?.trim() ?? '';
                          if (v.isNotEmpty && !v.startsWith('http')) {
                            return 'URL harus diawali http(s)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Kosongkan untuk menghapus foto profil.',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontStyle: GoogleFonts.inter().fontStyle,
                          color: ChakraColors.gray500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Circular avatar that live-previews the URL typed into [controller].
class _AvatarPreview extends StatelessWidget {
  const _AvatarPreview({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final url = controller.text.trim();
    final hasUrl = url.isNotEmpty && url.startsWith('http');
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55),
        border: Border.all(color: ChakraColors.gray200, width: 2),
        image: DecorationImage(
          image: hasUrl
              ? NetworkImage(url)
              : const AssetImage('assets/png/sitting-room.png')
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
