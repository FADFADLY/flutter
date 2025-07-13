import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'dart:io';

import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../generated/assets.dart';
import '../../../../auth/presentation/controller/cubits/logout/logout_cubit.dart';
import '../../../domain/entity/profile_data_entity.dart';
import '../../../domain/repo/repo.dart';
import '../../controller/cubit/profile_cubit.dart';
import 'liked_blog.dart';
import 'liked_book.dart';
import 'liked_podcast.dart';
import 'my_posts.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit(
            profileRepo: getIt<ProfileRepo>(),
          )..getProfile(),
        ),
        BlocProvider(
          create: (context) => LogoutCubit(
            authRepo: getIt<AuthRepo>(),
          ),
        ),
      ],
      child: BlocListener<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginView()),
                  (route) => false,
            );
          } else if (state is LogoutError && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileInitial) {
              return Center(child: Text(S.of(context).loading));
            } else if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return _buildProfileContent(context, state.profile);
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileDataEntity profile) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _bioController = TextEditingController();
    final ImagePicker _picker = ImagePicker();

    return Stack(
      children: [
        Positioned(
          top: Dimensions.profileCardTopOffset,
          left: 0,
          right: 0,
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: Dimensions.profileCardHeight,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius:  BorderRadius.only(
                topLeft: Radius.circular(Dimensions.borderRadiusNormal),
                topRight: Radius.circular(Dimensions.borderRadiusNormal),
              ),
            ),
          ),
        ),
        Positioned(
          top: Dimensions.profileContentTopOffset,
          left: Dimensions.profileContentPadding,
          right: Dimensions.profileContentPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: Dimensions.avatarRadius,
                          backgroundColor: AppColors.backgroundColor,
                          backgroundImage: profile.avatar != null
                              ? NetworkImage(profile.avatar!)
                              : const AssetImage(Assets.homeImg1),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: Dimensions.editIconButtonSize,
                            height: Dimensions.editIconButtonSize,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
                              border: Border.all(
                                color: AppColors.backgroundColor,
                                width: Dimensions.borderWidth,
                              ),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                final source = await showDialog<ImageSource>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(S.of(context).choose_image),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, ImageSource.gallery),
                                        child: Text(S.of(context).gallery),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, ImageSource.camera),
                                        child: Text(S.of(context).camera),
                                      ),
                                    ],
                                  ),
                                );
                                if (source != null) {
                                  final XFile? image = await _picker.pickImage(source: source);
                                  if (image != null) {
                                    context.read<ProfileCubit>().updateAvatar(File(image.path));
                                  }
                                }
                              },
                              icon: Icon(
                                Icons.edit,
                                color: AppColors.primaryColor,
                                size: Dimensions.editIconSize,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                     SizedBox(width: Dimensions.boxHeight8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Dimensions.boxHeight25),
                          SizedBox(
                            height: Dimensions.boxHeight30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    profile.name,
                                    style: AppStyles.text18Bold,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                                 SizedBox(width: Dimensions.boxHeight4),
                                IconButton(
                                  onPressed: () => _showEditNameDialog(context, _nameController),
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                    size: Dimensions.editIconSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                           SizedBox(height:  Dimensions.boxHeight4),
                          SizedBox(
                            height:  Dimensions.boxHeight35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    profile.bio ?? S.of(context).no_data,
                                    style: AppStyles.text12Regular,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                 SizedBox(width: Dimensions.boxHeight4),
                                IconButton(
                                  onPressed: () => _showEditBioDialog(context, _bioController, profile.bio),
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                    size: Dimensions.editIconSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  padding: EdgeInsets.zero,
                  children: [
                    _buildContentItem(S.of(context).your_podcasts, Assets.profileLists, context, onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  LikedPodcast()),
                      );
                    }),
                    _buildContentItem(S.of(context).your_library, Assets.profileLibrary, context, onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  LikedBook()),
                      );
                    }),
                    _buildContentItem(S.of(context).your_posts, Assets.profilePosts, context, onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyPosts()),
                      );
                    }),
                    _buildContentItem(S.of(context).your_favorite_articles, Assets.profileBlogs, context, onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  LikedBlog()),
                      );
                    }),
                  ],
                ),
                BlocBuilder<LogoutCubit, LogoutState>(
                  builder: (context, state) {
                    return TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red[100]!),
                      ),
                      onPressed: () async {
                        final shouldLogout = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: Text(S.of(context).logout),
                              content: Text(S.of(context).logout_confirmation),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(dialogContext, false),
                                  child: Text(S.of(context).cancel),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(dialogContext, true),
                                  child: Text(S.of(context).logout),
                                ),
                              ],
                            );
                          },
                        );

                        if (shouldLogout == true && context.mounted) {
                          context.read<LogoutCubit>().logout();
                        }
                      },
                      child: state is LogoutLoading
                          ?  SizedBox(
                        width: Dimensions.boxHeight20,
                        height: Dimensions.boxWidth20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.red,
                        ),
                      )
                          : Row(
                        children: [
                          const Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                           SizedBox(width: Dimensions.boxWidth8),
                          Text(
                            S.of(context).logout,
                            style: AppStyles.text14Regular.copyWith(color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showEditNameDialog(BuildContext context, TextEditingController controller) {
    String initialName = '';
    controller.text = initialName;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColors.backgroundColor,
          title: Text(
            S.of(context).edit_name,
            style: AppStyles.text18Bold.copyWith(color: AppColors.primaryColor),
          ),
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: S.of(context).enter_name,
                hintStyle: AppStyles.text12Regular.copyWith(color: Colors.grey),
                filled: true,
                fillColor: AppColors.backgroundColor.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.secondaryColor, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.secondaryColor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              style: AppStyles.text14Regular,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
                textStyle: AppStyles.text14Regular,
              ),
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                backgroundColor: AppColors.secondaryColor.withOpacity(0.2),
                textStyle: AppStyles.text14SemiBold,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  context.read<ProfileCubit>().updateName(controller.text.trim());
                  Navigator.pop(dialogContext);
                }
              },
              child: Text(S.of(context).save_changes),
            ),
          ],
        );
      },
    );
  }

  void _showEditBioDialog(BuildContext context, TextEditingController controller, String? initialBio) {
    controller.text = initialBio ?? '';

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColors.backgroundColor,
          title: Text(
            S.of(context).edit_bio,
            style: AppStyles.text18Bold.copyWith(color: AppColors.primaryColor),
          ),
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: controller,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: S.of(context).enter_bio,
                hintStyle: AppStyles.text12Regular.copyWith(color: Colors.grey),
                filled: true,
                fillColor: AppColors.backgroundColor.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.secondaryColor, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.secondaryColor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              style: AppStyles.text14Regular,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
                textStyle: AppStyles.text14Regular,
              ),
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                backgroundColor: AppColors.secondaryColor.withOpacity(0.2),
                textStyle: AppStyles.text14SemiBold,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  context.read<ProfileCubit>().updateBio(controller.text.trim());
                  Navigator.pop(dialogContext);
                }
              },
              child: Text(S.of(context).save_changes),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContentItem(String title, String imagePath, BuildContext context, {VoidCallback? onPressed}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Dimensions.gridItemWidth,
            height: Dimensions.gridItemHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: Dimensions.buttonWidth33Percent,
            height: Dimensions.buttonHeight40,
            child: CustomButton(
              onPressed: onPressed,
              text: title,
              backgroundColor: AppColors.primaryColor,
              style: AppStyles.buttonStyle,
              textStyle: AppStyles.text12SemiBold,
            ),
          ),
        ],
      ),
    );
  }
}