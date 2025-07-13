import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/features/blog/presentation/view/widgets/article_card.dart';
import 'package:graduationproject/features/blog/presentation/view/widgets/refresh_pump_heart_with_child.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../blog/presentation/view/widgets/dummy_card.dart';
import '../../../../home/presentation/views/NavBar.dart';
import '../../../domain/repo/repo.dart';
import '../../controller/cubit/liked_items_cubit.dart';

class LikedBlog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikedItemsCubit(
        profileRepo: getIt<ProfileRepo>(),
      )..fetchLikedItems(
        type: "blog",
      ),
      child: Scaffold(
        appBar: buildAppBar(
          context,
          title: S.of(context).liked_blogs,
          navigateTo: BottomNavBar.routeName,
          backgroundColor: AppColors.secondaryColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(Dimensions.paddingMedium),
          child: BlocBuilder<LikedItemsCubit, LikedItemsState>(
            builder: (context, state) {
              return CustomRefreshIndicator(
                onRefresh: () async => context.read<LikedItemsCubit>().fetchLikedItems(
                  type: "blog",
                ),
                builder: (context, child, controller) => RefreshPumpHeartWithChild(
                  showPumpHeart: controller.value > 0,
                  offset: controller.value * Dimensions.boxHeight50,
                  controller: controller,
                  child: child,
                ),
                child: state is LikedItemsLoading
                    ? const DummyCard()
                    : state is LikedItemsLoaded
                    ? ListView.builder(
                  itemCount: state.likedItems.data.length,
                  itemBuilder: (context, index) {
                    final item = state.likedItems.data[index];
                    return ArticleCard(
                      id: item.id,
                      summery: item.title,
                      isLoading: false,
                      title: item.title,
                      author: item.author,
                      date: item.createdAt,
                      imageUrl: item.image,
                      likes: item.likes,
                      shares: item.share,
                      views: item.views,
                    );
                  },
                )
                    : state is LikedItemsError
                    ? Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<LikedItemsCubit>().fetchLikedItems(
                        type: "blog",
                      );
                    },
                    label: Text(
                      S.of(context).refresh,
                      style: AppStyles.text16Regular,
                    ),
                    icon: Icon(Icons.refresh, color: AppColors.whiteColor),
                  ),
                )
                    : Center(
                  child: Text(
                    S.of(context).no_data_currently,
                    style: AppStyles.text16Regular,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}