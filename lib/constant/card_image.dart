part of 'constant.dart';

class CardImage extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  const CardImage({ Key? key, required this.width, required this.height, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(8)
        ),
      ),
      placeholder: (context, url) => SizedBox(
        height: height,
        width: width,
        child: ConstantCupertino.indicator(),
      ),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/logo.jpg'),
            fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(8)
        ),
      ),
    );
  }
}