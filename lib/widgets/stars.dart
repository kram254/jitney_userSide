import 'package:flutter/material.dart';

class StarsWidget extends StatelessWidget {
  final int numberOfStars;
 
  const StarsWidget({Key key, this.numberOfStars,}) : super(key: key);

   @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if(numberOfStars == 0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          
        ],
      );

    } else if(numberOfStars == 0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          
        ],
      );
  }else if(numberOfStars == 2){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          
        ],
      );
  } else if(numberOfStars == 3){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          
        ],
      );
  } else if(numberOfStars == 4){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.grey.withOpacity(0.4),
          ),
          
        ],
      );
  } else if(numberOfStars == 3){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          Icon(Icons.star,
           color: Colors.yellow.withOpacity(0.4),
          ),
          
        ],
      );
  }
  }
  }