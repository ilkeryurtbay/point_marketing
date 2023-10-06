part of 'package:point_marketing/src/features/admin/presentation/admin_page.dart';

class _ProductTile extends StatelessWidget {
  final Product product;
  const _ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    const double cardCornerRadius = 8.0;
    const double cardElevation = 4.0;

    return Center(
      child: Card(
        elevation: cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              cardCornerRadius), // Rounded corners with a radius of 8
          side: BorderSide(color: context.outlineColor), // Grey border
        ),
        child: ListTile(
          title: _buildOneLineTextWithEllipsisOverFlow(
              product.companyName ?? 'Company name could not be retrieved'),
          subtitle: _buildOneLineTextWithEllipsisOverFlow(
              product.name ?? 'Product name could not be retrieved'),
          trailing: IconButton(
            splashColor: context.mainThemeColor,
            icon: Icon(
              Icons.delete,
              color: context.mainThemeColor,
            ),
            onPressed: () {
              Provider.of<SelectedProductProvider>(context, listen: false)
                  .removeProductFromList(product);
            },
          ),
        ),
      ),
    );
  }

  Text _buildOneLineTextWithEllipsisOverFlow(String name) {
    return Text(name, maxLines: 1, overflow: TextOverflow.ellipsis);
  }
}
