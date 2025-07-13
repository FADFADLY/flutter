import '../../../../../core/constants/imports.dart';
import 'article_card.dart';

class DummyCard extends StatelessWidget {
  const DummyCard({super.key});

  static const _dummyCard = ArticleCard(
    id: 0,
    summery:"lorem Ipsum" ,

    isLoading: true,
    title: "عنوان وهمي",
    author: "كاتب وهمي",
    date: "2025-05-19",
    imageUrl: "https://via.placeholder.com/150",
    likes: 0,
    shares: 0,
    views: 0,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => _dummyCard,
    );
  }
}
