// import 'package:flutter/material.dart';

// class MaintenanceScreen extends StatefulWidget {
//   const MaintenanceScreen({super.key});

//   @override
//   _MaintenanceScreenState createState() => _MaintenanceScreenState();
// }

// class _MaintenanceScreenState extends State<MaintenanceScreen> {
//   final TextEditingController _descriptionController = TextEditingController();

//   // List to store maintenance requests
//   List<Map<String, dynamic>> maintenanceRequests = [];

//   void _submitRequest() {
//     if (_descriptionController.text.isNotEmpty) {
//       setState(() {
//         maintenanceRequests.add({
//           "description": _descriptionController.text,
//           "status": "Open", // Default status when submitting
//         });
//         _descriptionController.clear(); // Clear input after submitting
//       });
//     }
//   }

//   void _deleteRequest(int index) {
//     setState(() {
//       maintenanceRequests.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Maintenance Requests")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Describe the issue:",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _descriptionController,
//               maxLines: 3,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "E.g., Leaking pipe in the kitchen",
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _submitRequest,
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
//                 textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//               ),
//               child: const Text("Submit Request"),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Submitted Requests:",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: maintenanceRequests.isEmpty
//                   ? const Center(child: Text("No maintenance requests yet."))
//                   : ListView.builder(
//                 itemCount: maintenanceRequests.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     elevation: 3,
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       title: Text(maintenanceRequests[index]["description"]),
//                       subtitle: Text("Status: ${maintenanceRequests[index]["status"]}"),
//                       trailing: maintenanceRequests[index]["status"] == "Open"
//                           ? IconButton(
//                         icon: const Icon(Icons.delete, color: Colors.red),
//                         onPressed: () => _deleteRequest(index),
//                       )
//                           : null,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MaintenanceScreen extends StatefulWidget {
  final VoidCallback? onRefresh; // Add callback parameter


  const MaintenanceScreen({super.key, this.onRefresh});

  @override
  _MaintenanceScreenState createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  List<Map<String, dynamic>> maintenanceRequests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMaintenanceRequests();
  }

  Future<void> _fetchMaintenanceRequests() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user != null) {
      try {
        final response = await supabase
            .from('maintenance_requests')
            .select('*')
            .eq('tenant_id', user.id)
            .order('request_date', ascending: false);

        setState(() {
          maintenanceRequests = List<Map<String, dynamic>>.from(response);
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching requests: $e")),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
    }
  }

  Future<void> _submitRequest() async {
    if (_descriptionController.text.isNotEmpty) {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      if (user != null) {
        try {
          await supabase.from('maintenance_requests').insert({
            'tenant_id': user.id,
            'request_description': _descriptionController.text,
            'status': 'Open',
          });
          _descriptionController.clear();
          _fetchMaintenanceRequests(); // Refresh the list
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error submitting request: $e")),
          );
        }
      }
    }
  }

  // Future<void> _deleteRequest(String requestId) async {
  //   final supabase = Supabase.instance.client;
  //   try {
  //     await supabase.from('maintenance_requests').delete().eq('id', requestId);
  //     _fetchMaintenanceRequests(); // Refresh the list
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error deleting request: $e")),
  //     );
  //   }
  // }


  Future<void> _deleteRequest(String requestId) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.from('maintenance_requests').delete().eq('id', requestId);
      _fetchMaintenanceRequests(); // Refresh local list
      if (widget.onRefresh != null) {
        widget.onRefresh!(); // Call the callback to refresh HomeScreen
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting request: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Maintenance Requests")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Describe the issue:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "E.g., Leaking pipe in the kitchen",
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitRequest,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              child: const Text("Submit Request"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Submitted Requests:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : maintenanceRequests.isEmpty
                      ? const Center(child: Text("No maintenance requests yet."))
                      : ListView.builder(
                          itemCount: maintenanceRequests.length,
                          itemBuilder: (context, index) {
                            final request = maintenanceRequests[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(request["request_description"]),
                                subtitle: Text("Status: ${request["status"]}"),
                                trailing: request["status"] == "Open"
                                    ? IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _deleteRequest(request['id']),
                                      )
                                    : null,
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}