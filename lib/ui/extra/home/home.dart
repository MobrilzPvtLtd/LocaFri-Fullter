// import 'package:carapp/ui/mobility/search_cars.dart';
// import 'package:carapp/ui/Profile/profile.dart';
// import 'package:carapp/ui/home/carlist.dart';
// import 'package:carapp/ui/pickdate_time/date_time.dart';
// import 'package:carapp/widget/section.dart';
// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List images = [
//     "assets/images/categories/tesla.png",
//     "assets/images/categories/mitsubishi.png",
//     "assets/images/categories/mg.png",
//     "assets/images/categories/ferrari.png",
//     "assets/images/categories/bmw.png"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(05),
//         child: AppBar(
//           backgroundColor: Colors.transparent,
//         ),
//       ),
//       backgroundColor: Colors.grey[100],
//       extendBodyBehindAppBar: true,
//       body: SafeArea(
//         minimum: const EdgeInsets.symmetric(horizontal: 10),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               topAppbar(),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Date_Time_Picker(),
//               const SizedBox(
//                 height: 20,
//               ),
//               SectionWidget(
//                 onpressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => SearchCars()));
//                 },
//                 fontSize: 20,
//                 leadingText: "Avaliable Cars",
//                 buttonText: "More",
//                 fontFamily: "UberMove",
//                 fontWeight: FontWeight.w800,
//               ),
//               const Carlist(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget topAppbar() {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           height: height * 0.08,
//           width: width * 0.25,
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//             image: AssetImage("assets/logo/Final-1.png"),
//             fit: BoxFit.cover,
//           )),
//         ),

//         const SizedBox(
//           height: 0,
//         ),
//         InkWell(
//           onTap: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => const Profile()));
//           },
//           child: const CircleAvatar(
//             backgroundImage: AssetImage("assets/images/person.jpg"),
//             radius: 25,
//           ),
//         )
//       ],
//     );
//   }
// }
