import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../ReloadPages/reloadContact.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  String dropdownValue = 'monthly';

  List<Contact> contacts = [
    Contact(name: 'Aiana Saris', phoneNumber: 'BCA • 1468 3545 ***', imagePath: 'assets/images/ellipse.png'),
    Contact(name: 'Figma', phoneNumber: 'Subscription', imagePath: 'assets/images/figm.png'),
    Contact(name: 'Aiana Saris', phoneNumber: 'BCA • 3468 3545 ***'),
    Contact(name: 'Diana Saris', phoneNumber: 'BCA • 4468 3545 ***'),
    Contact(name: 'Diana Saris', phoneNumber: 'BCA • 5468 3545 ***'),
    Contact(name: 'Diana Saris', phoneNumber: 'BCA • 6468 3545 ***'),
    Contact(name: 'Hiana Saris', phoneNumber: 'BCA • 7468 3545 ***'),
    Contact(name: 'Hiana Saris', phoneNumber: 'BCA • 8468 3545 ***'),
    Contact(name: 'Hiana Saris', phoneNumber: 'BCA • 9468 3545 ***'),
    Contact(name: 'Liana Saris', phoneNumber: 'BCA • 1268 3545 ***'),
    Contact(name: 'Liana Saris', phoneNumber: 'BCA • 1368 3545 ***'),
    Contact(name: 'Liana Saris', phoneNumber: 'BCA • 1468 3545 ***'),
    Contact(name: 'Oiana Saris', phoneNumber: 'BCA • 1568 3545 ***'),
    Contact(name: 'Oiana Saris', phoneNumber: 'BCA • 1668 3545 ***'),
    Contact(name: 'Oiana Saris', phoneNumber: 'BCA • 1768 3545 ***'),
    Contact(name: 'Riana Saris', phoneNumber: 'BCA • 1868 3545 ***'),
    Contact(name: 'Siana Saris', phoneNumber: 'BCA • 1968 3545 ***'),
    Contact(name: 'Tiana Saris', phoneNumber: 'BCA • 2068 3545 ***'),
    Contact(name: 'Wiana Saris', phoneNumber: 'BCA • 2168 3545 ***'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.black,
                          width: 0.1
                      ),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                ),
              ),
              const Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Reload', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.black,
                        width: 0.1
                    ),
                  ),
                  child: const Icon(Icons.more_horiz),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 236,
            width: 327,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text('February 28 - March 28, 2020 ',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54)),
                    const SizedBox(width: 10),
                    Container(
                      height: 38,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFEBDBF0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          iconSize: 30,
                          underline: Container(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>[
                            'monthly',
                            'weekly',
                            ' daily',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <ColumnSeries<SalesData, String>>[
                      ColumnSeries<SalesData, String>(
                        dataSource: <SalesData>[
                          SalesData(month: 'Jan', sales: 5),
                          SalesData(month: 'Feb', sales: 3),
                          SalesData(month: 'Mar', sales: 2),
                          SalesData(month: 'Apr', sales: 5),
                          SalesData(month: 'May', sales: 8),
                        ],
                        xValueMapper: (SalesData sales, _) => sales.month,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        color: const Color(0xFF9579A0),
                        spacing: 0.3,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                      ),
                      ColumnSeries<SalesData, String>(
                        dataSource: <SalesData>[
                          SalesData(month: 'Jan', sales: 3),
                          SalesData(month: 'Feb', sales: 4),
                          SalesData(month: 'Mar', sales: 7),
                          SalesData(month: 'Apr', sales: 2),
                          SalesData(month: 'May', sales: 6),
                        ],
                        xValueMapper: (SalesData sales, _) => sales.month,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        color: const Color(0xFF4F3D56),
                        spacing: 0.3,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 142,
                width: 156,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.black,
                        width: 0.1
                    )
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12,
                          image: DecorationImage(image: AssetImage('assets/images/income.png'))
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('\$6.564,34', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    const Text('Income', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black38),)
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 142,
                width: 156,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.black,
                        width: 0.1
                    )
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12,
                          image: const DecorationImage(image: AssetImage('assets/images/outcome.png'))
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('\$4.764,35', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    const Text('Outcome', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black38),)
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Container(
                          height: 48,
                          width: 48,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                child: Image.asset(contacts[index].imagePath ?? 'assets/images/ellipse.png'),
                              ),
                            ],
                          ),
                        ),
                        title: Text(contacts[index].name),
                        subtitle: Text(contacts[index].phoneNumber),
                        trailing: const Text('\$433,00', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      ),
                      const Divider(
                        color: Colors.black12,
                        thickness: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                    ],
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData({required this.month, required this.sales});

  final String month;
  final double sales;
}
