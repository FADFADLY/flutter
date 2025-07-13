import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/constants/imports.dart';

part 'page_view_state.dart';

class PageViewCubit extends Cubit<PageViewState> {
  PageViewCubit() : super(PageViewInitial());
  PageController pageController = PageController(initialPage: 0);

  void updatePageIndex(int index) {
    pageController.jumpToPage(index);
  }

}
