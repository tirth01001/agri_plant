import 'package:agriplant/pages/onboarding_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionHistoryScreen extends StatelessWidget {



  final List<Map<String, dynamic>> transactions = [
    {
      "date": "March 28, 2024",
      "orderId": "#12345",
      "amount": "₹1,250",
      "status": "Completed",
      "paymentMethod": "UPI - Google Pay",
      "items": ["Fertilizer - 10kg", "Seeds - Wheat", "Pesticide - 1L"]
    },
    {
      "date": "March 22, 2024",
      "orderId": "#12344",
      "amount": "₹850",
      "status": "Pending",
      "paymentMethod": "Credit Card - HDFC Bank",
      "items": ["Organic Manure - 5kg", "Tomato Seeds"]
    },
    {
      "date": "March 15, 2024",
      "orderId": "#12343",
      "amount": "₹2,050",
      "status": "Failed",
      "paymentMethod": "Net Banking - SBI",
      "items": ["Tractor Spare Parts", "Hybrid Corn Seeds"]
    }
  ];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History"),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("E_Farmer").doc(globalUserAccount.uid).collection("transaction").snapshots(),
        builder: (context, snapshot) {

          if(!snapshot.hasData){

            return Center(child: CircularProgressIndicator());
          }


          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                var transaction = transactions[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.green.shade50],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(4, 4),
                        )
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ExpansionTile(
                      shape: Border(),
                      leading: CircleAvatar(
                        backgroundColor: transaction['status'] == "Completed"
                            ? Colors.green
                            : transaction['status'] == "Pending"
                                ? Colors.orange
                                : Colors.red,
                        child: Icon(
                          transaction['status'] == "Completed"
                              ? Icons.check
                              : transaction['status'] == "Pending"
                                  ? Icons.hourglass_empty
                                  : Icons.cancel,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Order ID: ${transaction['orderId']}",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        "Date: ${transaction['date']}\nStatus: ${transaction['status']}",
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                      ),
                      trailing: Text(
                        transaction['amount'],
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green[800]),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payment Method: ${transaction['paymentMethod']}",
                                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text("Items Purchased:", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                              ...transaction['items'].map((item) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                    child: Text("- $item", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87)),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      ),
    );
  }
}