import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../config/cache/secure_cache_helper.dart';
import '../../../domain/repo/repo.dart';
import '../../controller/cubits/store_post_cubit.dart';
import '../community_view.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final TextEditingController _controller = TextEditingController();
  String postType = 'text';
  File? _selectedImage;
  File? _selectedFile;
  File? _selectedAudio;
  List<TextEditingController> pollOptionControllers = [];
  String? userName;

  @override
  void initState() {
    super.initState();
    if (pollOptionControllers.isEmpty) {
      pollOptionControllers.add(TextEditingController());
    }
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final name = await SecureCacheHelper.getString(key: "user_name");
    setState(() {
      userName = name?.trim() ?? S.of(context).name;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controller in pollOptionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _selectedImage = File(result.files.single.path!);
        postType = 'photo';
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AutoSizeText(S.of(context).image_selected)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AutoSizeText(S.of(context).image_selection_canceled)));
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        postType = 'file';
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AutoSizeText(S.of(context).file_selected)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AutoSizeText(S.of(context).file_selection_canceled)));
    }
  }

  Future<void> _pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      setState(() {
        _selectedAudio = File(result.files.single.path!);
        postType = 'audio';
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AutoSizeText(S.of(context).file_selected)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AutoSizeText(S.of(context).file_selection_canceled)));
    }
  }

  void _addPollOption() {
    setState(() {
      pollOptionControllers.add(TextEditingController());
    });
  }

  void _removePollOption(int index) {
    setState(() {
      if (pollOptionControllers.isNotEmpty) {
        pollOptionControllers[index].dispose();
        pollOptionControllers.removeAt(index);
        if (pollOptionControllers.isEmpty) {
          pollOptionControllers.add(TextEditingController());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StorePostCubit(postsRepo: getIt<PostsRepo>()),
      child: BlocListener<StorePostCubit, StorePostState>(
        listener: (context, state) {
          if (state is StorePostSuccess) {
            setState(() {
              _selectedImage = null;
              _selectedFile = null;
              _selectedAudio = null;
              pollOptionControllers = [TextEditingController()];
            });
            Navigator.pop(context);
          } else if (state is StorePostError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: AutoSizeText(state.message)),
            );
          }
        },
        child: Scaffold(
          appBar: buildAppBar(
            context,
            title: S.of(context).create_post,
            navigateTo: CommunityView.routeName,
            backgroundColor: AppColors.secondaryColor,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(Dimensions.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: Dimensions.avatarUserRadius,
                        backgroundColor: AppColors.errorColor,
                        child: Icon(Icons.person, color: AppColors.whiteColor),
                      ),
                      SizedBox(width: Dimensions.boxWidth10),
                      AutoSizeText(
                        userName ?? S.of(context).name,
                        style: AppStyles.text14SemiBold,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(
                              MediaQuery.of(context).size.width,
                              Dimensions.boxHeight170,
                              0,
                              0,
                            ),
                            items: [
                              PopupMenuItem(
                                value: 'photo',
                                onTap: () async {
                                  postType = 'photo';
                                  await _pickImage();
                                },
                                child: SizedBox(
                                  width: Dimensions.boxWidth100, // Reduced width for smaller menu
                                  child: Row(
                                    children: [
                                      Icon(Icons.photo, color: AppColors.secondaryColor),
                                      SizedBox(width: Dimensions.boxWidth8),
                                      Expanded(
                                        child: AutoSizeText(
                                          S.of(context).photo,
                                          style: AppStyles.text14Regular.copyWith(color: AppColors.secondaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 'poll',
                                onTap: () {
                                  postType = 'poll';
                                  setState(() {});
                                },
                                child: SizedBox(
                                  width: Dimensions.boxWidth100,
                                  child: Row(
                                    children: [
                                      Icon(Icons.poll, color: AppColors.secondaryColor),
                                      SizedBox(width: Dimensions.boxWidth8),
                                      Expanded(
                                        child: AutoSizeText(
                                          S.of(context).poll,
                                          style: AppStyles.text14Regular.copyWith(color: AppColors.secondaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 'file',
                                onTap: () async {
                                  postType = 'file';
                                  await _pickFile();
                                },
                                child: SizedBox(
                                  width: Dimensions.boxWidth100,
                                  child: Row(
                                    children: [
                                      Icon(Icons.attach_file, color: AppColors.secondaryColor),
                                      SizedBox(width: Dimensions.boxWidth8),
                                      Expanded(
                                        child: AutoSizeText(
                                          S.of(context).file,
                                          style: AppStyles.text14Regular.copyWith(color: AppColors.secondaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 'audio',
                                onTap: () async {
                                  postType = 'audio';
                                  await _pickAudio();
                                },
                                child: SizedBox(
                                  width: Dimensions.boxWidth100,
                                  child: Row(
                                    children: [
                                      Icon(Icons.audiotrack, color: AppColors.secondaryColor),
                                      SizedBox(width: Dimensions.boxWidth8),
                                      Expanded(
                                        child: AutoSizeText(
                                          S.of(context).audio,
                                          style: AppStyles.text14Regular.copyWith(color: AppColors.secondaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 'location coming soon',
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: AutoSizeText('Location feature coming soon')),
                                  );
                                },
                                child: SizedBox(
                                  width: Dimensions.boxWidth100,
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on, color: AppColors.secondaryColor),
                                      SizedBox(width: Dimensions.boxWidth8),
                                      Expanded(
                                        child: AutoSizeText(
                                          S.of(context).location,
                                          style: AppStyles.text14Regular.copyWith(color: AppColors.secondaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ).then((value) {
                            if (value != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: AutoSizeText('${S.of(context).selected}: $value')),
                              );
                            }
                          });
                        },
                        child: Row(
                          children: [
                            AutoSizeText(
                              S.of(context).attachment,
                              style: AppStyles.text14Regular.copyWith(color: AppColors.secondaryColor),
                            ),
                            Icon(Icons.attach_file_sharp, color: AppColors.secondaryColor),
                          ],
                        ),
                      ),
                    ],
                  ),

                  if (_selectedImage != null || _selectedFile != null || _selectedAudio != null)
                    Padding(
                      padding: EdgeInsets.only(top: Dimensions.boxHeight10),
                      child: Column(
                        children: [
                          if (_selectedImage != null)
                            Container(
                              padding: EdgeInsets.all(Dimensions.paddingSmall),
                              decoration: BoxDecoration(
                                color: AppColors.greyLightColor,
                                borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                                border: Border.all(color: AppColors.secondaryColor),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusExtraSmall),
                                    child: Image.file(
                                      _selectedImage!,
                                      width: Dimensions.boxWidth40,
                                      height: Dimensions.boxHeight40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.boxWidth8),
                                  Expanded(
                                    child: AutoSizeText(
                                      _selectedImage!.path.split('/').last,
                                      style: AppStyles.text14Regular.copyWith(color: AppColors.secondaryColor),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close, color: AppColors.secondaryColor),
                                    onPressed: () {
                                      setState(() {
                                        _selectedImage = null;
                                        postType = 'text';
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          if (_selectedFile != null)
                            Padding(
                              padding: EdgeInsets.only(top: Dimensions.boxHeight10),
                              child: Container(
                                padding: EdgeInsets.all(Dimensions.paddingSmall),
                                decoration: BoxDecoration(
                                  color: AppColors.greyLightColor,
                                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                                  border: Border.all(color: AppColors.secondaryColor),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.insert_drive_file, color: AppColors.secondaryColor, size: Dimensions.socialIconSize),
                                    SizedBox(width: Dimensions.boxWidth8),
                                    Expanded(
                                      child: AutoSizeText(
                                        _selectedFile!.path.split('/').last,
                                        style: AppStyles.text14Regular.copyWith(color: AppColors.secondaryColor),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.close, color: AppColors.secondaryColor),
                                      onPressed: () {
                                        setState(() {
                                          _selectedFile = null;
                                          postType = 'text';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (_selectedAudio != null)
                            Padding(
                              padding: EdgeInsets.only(top: Dimensions.boxHeight10),
                              child: Container(
                                padding: EdgeInsets.all(Dimensions.paddingSmall),
                                decoration: BoxDecoration(
                                  color: AppColors.greyLightColor,
                                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                                  border: Border.all(color: AppColors.secondaryColor),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.audiotrack, color: AppColors.secondaryColor, size: Dimensions.socialIconSize),
                                    SizedBox(width: Dimensions.boxWidth8),
                                    Expanded(
                                      child: AutoSizeText(
                                        _selectedAudio!.path.split('/').last,
                                        style: AppStyles.text14Regular.copyWith(color: AppColors.secondaryColor),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.close, color: AppColors.secondaryColor),
                                      onPressed: () {
                                        setState(() {
                                          _selectedAudio = null;
                                          postType = 'text';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  if (postType == 'poll' && pollOptionControllers.isNotEmpty)
                    Column(
                      children: pollOptionControllers.asMap().entries.map((entry) {
                        int index = entry.key;
                        return Padding(
                          padding: EdgeInsets.only(top: Dimensions.boxHeight10),
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.paddingSmall),
                            decoration: BoxDecoration(
                              color: AppColors.greyLightColor,
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                              border: Border.all(color: AppColors.secondaryColor),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.poll, color: AppColors.secondaryColor, size: Dimensions.socialIconSize),
                                SizedBox(width: Dimensions.boxWidth8),
                                Expanded(
                                  child: TextField(
                                    style: AppStyles.text16Regular,
                                    controller: pollOptionControllers[index],
                                    decoration: InputDecoration(
                                      hintText: S.of(context).enter_option,
                                      hintStyle: AppStyles.text18Regular,
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.close, color: AppColors.secondaryColor),
                                  onPressed: () => _removePollOption(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  if (postType == 'poll')
                    Padding(
                      padding: EdgeInsets.only(top: Dimensions.boxHeight10),
                      child: ElevatedButton(
                        onPressed: _addPollOption,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                          ),
                        ),
                        child: AutoSizeText(
                          S.of(context).add_option,
                          style: AppStyles.text18Button,
                        ),
                      ),
                    ),

                  SizedBox(height: Dimensions.boxHeight20),

                  Container(
                    padding: EdgeInsets.all(Dimensions.paddingMedium),
                    decoration: BoxDecoration(
                      color: AppColors.greyLightColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                    ),
                    width: double.infinity,
                    height: Dimensions.boxHeight390,
                    child: TextFormField(
                      style: AppStyles.text16Regular,
                      controller: _controller,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: S.of(context).what_on_your_mind,
                        hintStyle: AppStyles.text16Regular,
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.boxHeight20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Dimensions.buttonWidth,
                        height: Dimensions.buttonHeight40,
                        child: BlocBuilder<StorePostCubit, StorePostState>(
                          builder: (context, state) {
                            return CustomButton(
                              style: AppStyles.buttonStyle,
                              backgroundColor: AppColors.secondaryColor,
                              text: state is StorePostLoading ? S.of(context).posting : S.of(context).post,
                              onPressed: state is StorePostLoading
                                  ? null
                                  : () {
                                final content = _controller.text.trim();
                                final options = pollOptionControllers.map((controller) => controller.text.trim()).toList();
                                if (content.isNotEmpty) {
                                  if (postType == 'photo' && _selectedImage != null) {
                                    context.read<StorePostCubit>().storePostWithImage(
                                      content: content,
                                      image: _selectedImage!,
                                    );
                                  } else if (postType == 'file' && _selectedFile != null) {
                                    context.read<StorePostCubit>().storePostWithFile(
                                      content: content,
                                      file: _selectedFile!,
                                    );
                                  } else if (postType == 'audio' && _selectedAudio != null) {
                                    context.read<StorePostCubit>().storePostWithAudio(
                                      content: content,
                                      audio: _selectedAudio!,
                                    );
                                  } else if (postType == 'poll' && options.every((option) => option.isNotEmpty)) {
                                    context.read<StorePostCubit>().storePostWithPoll(
                                      content: content,
                                      options: options,
                                    );
                                    print(options);
                                  } else {
                                    context.read<StorePostCubit>().storePost(content: content);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: AutoSizeText(S.of(context).please_enter_content)),
                                  );
                                }
                              },
                              textStyle: AppStyles.text18Button,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}