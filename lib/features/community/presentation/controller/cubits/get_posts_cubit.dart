import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../domain/entity/posts_data_entity.dart';
import '../../../domain/entity/attachment_entity.dart';
import '../../../domain/repo/repo.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  GetPostsCubit({
    required this.postsRepo,
  }) : super(GetPostsInitial());

  final PostsRepo postsRepo;

  Future<void> getPosts() async {
    emit(GetPostsLoading());
    final posts = await postsRepo.getPosts();
    posts.fold(
          (failure) {
        print(failure.message);
        emit(GetPostsError(message: failure.message));
      },
          (posts) {
        emit(GetPostsLoaded(posts: posts.data));
      },
    );
  }

  void updatePostReaction(int postId, bool reacted, int reactionsCount) {
    if (state is GetPostsLoaded) {
      final currentState = state as GetPostsLoaded;
      final updatedPosts = currentState.posts.map((post) {
        if (post.id == postId) {
          return PostDataEntity(
            id: post.id,
            userName: post.userName,
            content: post.content,
            createdAt: post.createdAt,
            attachment: post.attachment,
            type: post.type,
            reacted: reacted,
            reactionsCount: reactionsCount,
            commentsCount: post.commentsCount,
          );
        }
        return post;
      }).toList();
      emit(GetPostsLoaded(posts: updatedPosts));
    }
  }

  void updatePollVote({required int postId, required int optionId}) {
    if (state is GetPostsLoaded) {
      final currentState = state as GetPostsLoaded;
      final updatedPosts = currentState.posts.map((post) {
        if (post.id == postId && post.attachment is AttachmentEntity) {
          final attachment = post.attachment as AttachmentEntity;
          if (attachment.options == null || attachment.options!.isEmpty) {
            return post; // لو القايمة null أو فاضية، ارجع البوست بدون تغيير
          }

          // تصفية الخيارات غير null قبل المعالجة
          final nonNullOptions = attachment.options!.where((option) => option != null).cast<OptionsEntity>().toList();

          // تحديد إذا كان فيه خيار متصوَّت عليه قبل كده
          final hasVoted = nonNullOptions.any((option) => option.voted == true);

          // إيجاد الخيار المتصوَّت عليه سابقًا (إن وجد)
          OptionsEntity? previousVotedOption;
          if (hasVoted) {
            for (var option in nonNullOptions) {
              if (option.voted) {
                previousVotedOption = option;
                break;
              }
            }
          }

          // إذا كان الخيار الجديد هو نفس الخيار المتصوَّت عليه، لا تغيّر شيء
          if (previousVotedOption != null && previousVotedOption.id == optionId) {
            return post;
          }

          // حساب إجمالي الأصوات
          int newTotalVotes = attachment.totalVotes ?? 0;
          if (!hasVoted) {
            newTotalVotes += 1; // زيادة إجمالي الأصوات لو أول تصويت
          }

          // تحديث الأصوات والنسب
          final updatedOptions = nonNullOptions.map((option) {
            int votes = option.votes;
            bool voted = option.voted;

            if (option.id == optionId) {
              // الخيار الجديد
              votes += 1;
              voted = true;
            } else if (option.voted) {
              // الخيار القديم المتصوَّت عليه
              votes = votes > 0 ? votes - 1 : 0; // نقّص صوت لو موجود
              voted = false;
            }

            return OptionsEntity(
              id: option.id,
              option: option.option,
              voted: voted,
              votes: votes,
              percentage: newTotalVotes > 0
                  ? (votes / newTotalVotes * 100).toInt()
                  : 0,
            );
          }).toList();

          return PostDataEntity(
            id: post.id,
            userName: post.userName,
            content: post.content,
            createdAt: post.createdAt,
            attachment: AttachmentEntity(
              id: attachment.id,
              options: updatedOptions,
              latitude: attachment.latitude,
              longitude: attachment.longitude,
              label: attachment.label,
              title: attachment.title,
              author: attachment.author,
              image: attachment.image,
              createdAt: attachment.createdAt,
              views: attachment.views,
              likes: attachment.likes,
              share: attachment.share,
              reacted: attachment.reacted,
              totalVotes: newTotalVotes,
            ),
            type: post.type,
            reacted: post.reacted,
            reactionsCount: post.reactionsCount,
            commentsCount: post.commentsCount,
          );
        }
        return post;
      }).toList();
      emit(GetPostsLoaded(posts: updatedPosts));
    }
  }
}