import 'package:first_open_project/models/shop_pages_model/user_shops_response_model.dart';
import 'package:flutter/material.dart';
import '../ApiClient.dart';
import '../models/shop_pages_model/create_shop_response_model.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final apiClient = ApiClient();
  final _formKey = GlobalKey<FormState>();
  List shops = [];
  bool isLoading = false;
  bool isCreatingShop = false;
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> response = await apiClient.getShops();
    UserShopsResponse userShopsResponse = UserShopsResponse.fromJson(response);
    setState(() {
      shops = userShopsResponse.data ?? [];
      print('1-+=============++++++++++ $shops');
      isLoading = false;
      dataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF57435C),
        centerTitle: true,
        title: const Text('Shops'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : shops.isEmpty
          ? const Center(child: Text('Empty'))
          : ListView.builder(
          itemCount: shops.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(shops[index].name),
                subtitle: Text(shops[index].address),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF57435C),
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
                builder: (BuildContext context, StateSetter setState) {
                  return SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            nameField(),
                            addressField(),
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
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget nameField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shope Name',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: shopNameController,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Enter your shop name',
              hintStyle: const TextStyle(color: Colors.black54),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter the shop name';
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget addressField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shop Address',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: addressController,
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
                return 'Enter the shop address';
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
              isCreatingShop = true;
            });
            var response = await apiClient.createShop(
                shopNameController.text.trim(), addressController.text.trim());
            CreateSHopResponse createSHopResponse = CreateSHopResponse.fromJson(response);
            print('name11111111  ${createSHopResponse.data!.id}');
            print('id22222222  ${createSHopResponse.data!.owner!.id}');
            print('phoneNumber33333333  ${createSHopResponse.data!.owner!.phoneNumber}');
            print('email44444444  ${createSHopResponse.data!.owner!.email}');
            await fetchData();
            shopNameController.clear();
            addressController.clear();
            Navigator.pop(context);
            setState(() {
              isCreatingShop = false;
            });
            if (dataLoaded && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data Successfully Loaded')));
              setState(() {
                dataLoaded = false;
              });
            }
          } else {
            return;
          }
        },
        child: isCreatingShop
            ? const Center(
            child: CircularProgressIndicator(backgroundColor: Colors.white))
            : const Text(
          'Create Shop',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
