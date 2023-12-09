import 'package:food_app/model/item.dart';
import 'package:food_app/shared/appbar.dart';
import 'package:food_app/shared/colors.dart';
import 'package:flutter/material.dart';


class Details extends StatefulWidget {
  final Item product;

  const Details({Key? key, required this.product}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  bool isShowMore = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [ProductsAndPrice()],
        backgroundColor: appbarGreen,
        title: const Text("Details screen",style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.product.imgPath),
            const SizedBox(
              height: 11,
            ),
            Text(
              "\  ${widget.product.price} Dt",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 129, 129),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "New",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Row(
                  children: [
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return RotationTransition(
                          turns: _animation,
                          child: Icon(
                            Icons.star,
                            size: 26,
                            color: Color.fromARGB(255, 255, 191, 0),
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return RotationTransition(
                          turns: _animation,
                          child: Icon(
                            Icons.star,
                            size: 26,
                            color: Color.fromARGB(255, 255, 191, 0),
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return RotationTransition(
                          turns: _animation,
                          child: Icon(
                            Icons.star,
                            size: 26,
                            color: Color.fromARGB(255, 255, 191, 0),
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return RotationTransition(
                          turns: _animation,
                          child: Icon(
                            Icons.star,
                            size: 26,
                            color: Color.fromARGB(255, 255, 191, 0),
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return RotationTransition(
                          turns: _animation,
                          child: Icon(
                            Icons.star,
                            size: 26,
                            color: Color.fromARGB(255, 255, 191, 0),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  width: 66,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.edit_location,
                      size: 26,
                      color: Color.fromRGBO(255, 151, 0, 1.0),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.product.location,
                      style: const TextStyle(fontSize: 19),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Details : ",
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
                "A burger, a quintessential American culinary delight, is a delectable handheld creation that has achieved worldwide acclaim for its irresistible combination of flavors and textures. At its core, a burger typically features a succulent ground beef patty, seasoned to perfection and expertly grilled to achieve a flavorful char.",
              style: const TextStyle(
                fontSize: 18,
              ),
              maxLines: isShowMore ? 3 : null,
              overflow: TextOverflow.fade,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isShowMore = !isShowMore;
                  isShowMore ? _controller.reverse() : _controller.forward();
                });
              },
              child: Text(
                isShowMore ? "Show more" : "Show less",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
