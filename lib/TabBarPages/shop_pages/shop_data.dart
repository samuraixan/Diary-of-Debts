import 'package:first_open_project/ClientPages/create_client.dart';
import 'package:first_open_project/models/seller_pages_model/create_seller_response_model.dart';
import 'package:first_open_project/models/shop_pages_model/delete_shop_response_model.dart';
import 'package:first_open_project/models/shop_pages_model/update_shop_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../ApiClient.dart';
import '../../models/client_pages/create_client_response_model.dart';
import '../../models/shop_pages_model/show_shop_response_model.dart';
import '../../models/shop_pages_model/user_shops_response_model.dart';


class ShopData extends StatefulWidget {
  final UserShop shop;
  final ShowShopResponse showShopResponse;

  const ShopData({super.key, required this.shop, required this.showShopResponse});

  @override
  State<ShopData> createState() => _ShopDataState();
}

class _ShopDataState extends State<ShopData> {
  // Создаем переменную для отслеживания активной кнопки
  String activeButton = '';
  TextEditingController editShopNameController = TextEditingController();
  TextEditingController editShopAddressController = TextEditingController();
  TextEditingController sellerLabelController = TextEditingController();
  TextEditingController sellerCodeController = TextEditingController();

  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientPhoneController = TextEditingController();
  TextEditingController clientAddressController = TextEditingController();


  final apiClient = ApiClient();
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  bool isLoading = false;
  String dropdownValue = 'monthly';
  bool isCreatingShop = false;
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    editShopNameController = TextEditingController(text: widget.shop.name);
    editShopAddressController = TextEditingController(text: widget.shop.address);
  }


  refresh() {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, widget.shop);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF57435C),
          centerTitle: true,
          title: Row(
            children: [
              const Icon(Icons.storefront),
              const SizedBox(width: 20),
              Text(widget.shop.name!)
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete a shop?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                            TextButton(
                                onPressed: () async {
                                  var response = await apiClient
                                      .deleteShop(widget.shop.id.toString());
                                  DeleteShopResponse deleteShopResponse =
                                  DeleteShopResponse.fromJson(response);
                                  if (deleteShopResponse.success == true &&
                                      mounted) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                        Text('Shop Successfully Deleted!'),
                                      ),
                                    );
                                  } else {
                                    print(deleteShopResponse.message);
                                  }
                                },
                                child: const Text('Yes'))
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.delete)),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      editNameField(),
                                      editAddressField(),
                                      const SizedBox(height: 30),
                                      signInButton(context, setState),
                                      const SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit)),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
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
              ),
              Container(
                width: 300,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            activeButton = 'Oldi-Berdi';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF57435C)),
                        child: const Text('Oldi-Berdi')),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            activeButton = 'Sotuvchilar';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF57435C)),
                        child: const Text('Sotuvchilar')),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            activeButton = 'Mijozlar';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF57435C)),
                        child: const Text('Mijozlar')),
                  ],
                ),
              ),
              if (activeButton == 'Sotuvchilar')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 285,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black12,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Sotuvchilar soni:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  onPressed: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return Form(
                                              key: _formKey1,
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(height: 20),
                                                      sellerLabel(),
                                                      const SizedBox(height: 30),
                                                      sellerCreateButton(context, setState),
                                                      const SizedBox(
                                                          height: 30),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(Icons.add,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (activeButton == 'Oldi-Berdi')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 285,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12),
                    child: ListView.builder(
                        itemCount: widget.shop.address!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Card(
                                child: ListTile(
                                  title: Text(widget.shop.address!),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              if (activeButton == 'Mijozlar')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 285,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black12,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Mijozlar soni:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  onPressed: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return Form(
                                              key: _formKey2,
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(height: 20),
                                                      clientName(),
                                                      clientPhone(),
                                                      clientAddress(),
                                                      const SizedBox(height: 10),
                                                      clientCreateButton(context, setState),
                                                      const SizedBox(height: 20),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(Icons.add,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              if (activeButton == '')
                Column(
                  children: [
                    Container(
                      height: 220,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black12),
                      child: const Icon(Icons.photo_camera, size: 150),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text('   Egasi:    ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(widget.showShopResponse.data!.owner!.name!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('   Manzil:  ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(widget.shop.address!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget editNameField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edit Shope Name',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: editShopNameController,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Enter your edit shop name',
              hintStyle: const TextStyle(color: Colors.black54),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter a name';
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget editAddressField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edit Shop Address',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: editShopAddressController,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Enter your shop address',
              hintStyle: const TextStyle(color: Colors.black54),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter a address';
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget signInButton(BuildContext context, setState) {
    return SizedBox(
      width: 250,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(79, 61, 86, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });
            var response = await apiClient.updateShop(
                editShopNameController.text.trim(),
                editShopAddressController.text.trim(),
                widget.shop.id!);
            if (response.statusCode == 200 && mounted) {
              UpdateShopResponse updateShopResponse =
              UpdateShopResponse.fromJson(response.data);
              print('===================${updateShopResponse.message}');
              widget.shop.name = editShopNameController.text.trim();
              widget.shop.address = editShopAddressController.text.trim();
              Navigator.pop(context);
              isLoading = false;
              refresh();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data Successfully Updated!'),
                ),
              );
            }
          }
        },
        child: isLoading
            ? const Center(
            child: CircularProgressIndicator(backgroundColor: Colors.white))
            : const Text(
          'Edit Shop',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }


  Widget sellerLabel() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nomi',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: sellerLabelController,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Nomni kiriting',
              hintStyle: const TextStyle(color: Colors.black54),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Yozilishi shart';
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget sellerCreateButton(BuildContext context, setState) {
    return SizedBox(
      width: 250,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(79, 61, 86, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setInt('id', widget.shop.id ?? 0);
          if (_formKey1.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });
            var response = await apiClient.createSeller(widget.shop.id.toString(), sellerLabelController.text.trim());
            CreateSellerResponse createSellerResponse = CreateSellerResponse.fromJson(response);
            if (createSellerResponse.success == true && mounted) {
              setState(() {
                isLoading = false;
                sellerCodeController.text = createSellerResponse.data!.activationCode.toString();
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    bool isCopied = false;
                    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                      return Dialog(
                        child: Container(
                          width: 250,
                          height: 280,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sotuvchi qo`shiladi',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  SizedBox(height: 20),
                                  Icon(
                                    Icons.check_box,
                                    color: Colors.green,
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Column(
                                children: [
                                  Text('Sotuvchi aktivlashtirish kodini saqlab', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('oling yoki sotuvchiga yuborib qo`ying!', style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Aktivlashtirish kodi',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: sellerCodeController, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              hintStyle: const TextStyle(color: Colors.black54),
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    Clipboard.setData(ClipboardData(text: sellerCodeController.text));
                                                    setState(() {
                                                      isCopied = true;
                                                    });
                                                  },
                                                  icon: Icon(isCopied ? Icons.check : Icons.copy)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                                  child: const Text('Ok', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),))
                            ],
                          ),
                        ),
                      );
                    });
                  });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Seller created successfully!'),
                ),
              );
              sellerLabelController.clear();
            } else {
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incorrect id')));
                setState(() {
                  isLoading = false;
                });
              }
            }
          }
        },
        child: isLoading
            ? const Center(
            child: CircularProgressIndicator(backgroundColor: Colors.white))
            : const Text(
          'Sotuvchi qo`shish',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget clientName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Client Name',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: clientNameController,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Enter your client name',
              hintStyle: const TextStyle(color: Colors.black54),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter a name';
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget clientPhone() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Client phone',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: clientPhoneController,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Enter client phone',
              hintStyle: const TextStyle(color: Colors.black54),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter a phone';
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget clientAddress() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Client Address',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: clientAddressController,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Enter client address',
              hintStyle: const TextStyle(color: Colors.black54),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter a address';
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget clientCreateButton(BuildContext context, setState) {
    return SizedBox(
      width: 250,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(79, 61, 86, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: () async {
          if (_formKey2.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });
            var response = await apiClient.createClient(widget.shop.id.toString(), clientNameController.text.trim(), clientPhoneController.text.trim(), clientAddressController.text.trim());
            CreateClientResponse createClientResponse = CreateClientResponse.fromJson(response);
            if (createClientResponse.success == true && mounted) {
              Navigator.pop(context);
              isLoading = false;
              refresh();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Client created successfully!'),
                ),
              );
            }
          }
        },
        child: isLoading
            ? const Center(
            child: CircularProgressIndicator(backgroundColor: Colors.white))
            : const Text(
          'Mijoz qo`shish',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData({required this.month, required this.sales});

  final String month;
  final double sales;
}
