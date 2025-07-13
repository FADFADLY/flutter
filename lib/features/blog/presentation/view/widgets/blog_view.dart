import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/features/blog/presentation/view/widgets/article_card.dart';
import 'package:graduationproject/features/blog/presentation/view/widgets/refresh_pump_heart_with_child.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/shared_widgets/empty_no_data.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/full_blog/article_cubit.dart';
import 'dummy_card.dart';

class BlogViewBody extends StatelessWidget {
  const BlogViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ArticleCubit>();

    return BlocBuilder<ArticleCubit, ArticleState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(Dimensions.paddingMedium),
          child: CustomRefreshIndicator(
            onRefresh: () async => cubit.getArticles(),
            builder: (context, child, controller) => RefreshPumpHeartWithChild(
              showPumpHeart: controller.value > 0,
              offset: controller.value * Dimensions.boxHeight50,
              controller: controller,
              child: child,
            ),
            child: state is ArticleLoading
                ? const DummyCard()
                : state is ArticleLoaded
                ? ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) => ArticleCard(
                id: state.articles[index].id,
                summery: state.articles[index].summary,
                isLoading: false,
                title: state.articles[index].title,
                author: state.articles[index].author,
                date: state.articles[index].createdAt,
                imageUrl: state.articles[index].image,
                likes: state.articles[index].likes,
                shares: state.articles[index].share,
                views: state.articles[index].views,
              ),
            )
                : state is ArticleError
                ? Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  cubit.getArticles();
                },
                label: AutoSizeText(
                  minFontSize: 0,
                  S.of(context).refresh,
                  style: AppStyles.text16Regular,
                ),
                icon: Icon(Icons.refresh, color: AppColors.whiteColor),
              ),
            )
                :  EmptyNoData(
              height: Dimensions.boxHeight200,
            ),

          ),
        );
      },
    );
  }
}