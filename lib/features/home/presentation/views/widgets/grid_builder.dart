import 'package:flutter/material.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../controller/grid_controller.dart';
import 'grid_item_widget.dart';

class GridBuilder extends StatelessWidget {
  final GridController controller = GridController();

  GridBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final items = controller.getGridItems(context);

    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: Dimensions.paddingMedium,
          mainAxisSpacing: Dimensions.paddingMedium,
          childAspectRatio: 0.8,
        ),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return GridItemWidget(item: items[index]);
        },
      ),
    );
  }
}