
import 'package:agriplant/main.dart';
import 'package:agriplant/models/order.dart';
import 'package:agriplant/models/user_account.dart';
import 'package:agriplant/pages/onboarding_page.dart';
import 'package:agriplant/service/firebase_service.dart';
import 'package:agriplant/service/loading.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class TempOrderDetailsPage extends StatefulWidget {

  final Order order;
  
  const TempOrderDetailsPage({
    super.key,
    required this.order,
  });

  @override
  State<TempOrderDetailsPage> createState() => _TempOrderDetailsPageState();
}

class _TempOrderDetailsPageState extends State<TempOrderDetailsPage> {

  int activeSteps(){
    String status = widget.order.order["order_status"];
    switch (status.toLowerCase()) {
      case "processing": return 0;
      case "shipped": return 1;
      case "out of delivery": return 2;
      case "delivered": return 3;
    }
    return 0;
  }
  
  late int activeStep;

  @override
  void initState() {
    super.initState();
    activeStep = activeSteps();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final orderTimelines = ['Processing', 'Picking', 'Shipping', 'Delivered'];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          EasyStepper(
            activeStep: activeStep,
            lineStyle: LineStyle(
              lineLength: 70,
              lineSpace: 0,
              defaultLineColor: Colors.grey.shade300,
              finishedLineColor: theme.colorScheme.primary,
              lineThickness: 1.5,
            ),
            activeStepTextColor: Colors.black87,
            finishedStepTextColor: Colors.black87,
            internalPadding: 0,
            showLoadingAnimation: true,
            stepRadius: 8,
            steps: List.generate(orderTimelines.length, (index) {
              return EasyStep(
                customStep: CircleAvatar(
                  radius: 8,
                  backgroundColor: activeStep > index
                      ? theme.colorScheme.primary.withOpacity(0.5)
                      : Colors.grey.shade400,
                  child: CircleAvatar(
                    radius: 2.5,
                    backgroundColor: activeStep > index
                        ? theme.colorScheme.primary
                        : Colors.grey.shade200,
                  ),
                ),
                title: orderTimelines[index],
                topTitle: true,
              );
            }),
            onStepReached: (index) {},
          ),
          const SizedBox(height: 20),
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            elevation: 0.1,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order: ${widget.order.orderId}",
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Chip(
                        shape: const StadiumBorder(),
                        side: BorderSide.none,
                        backgroundColor:
                            theme.colorScheme.primaryContainer.withOpacity(0.4),
                        labelPadding: EdgeInsets.zero,
                        avatar: const Icon(Icons.fire_truck),
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        label: Text(
                          orderTimelines[activeStep],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Delivery estimate"),
                      Text(
                        "15 Min",
                        // DateTime(2002).toString(),
                        // "order.order["order_place_date"].toString()",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    globalUserAccount.profile[Profile.name].toString(),
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Icon(IconlyLight.home, size: 15),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          "6844 Hall Spring Suite 134\n East Annabury, OK 42291",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(IconlyLight.call, size: 15),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          globalUserAccount.profile[Profile.mobile].toString(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment method"),
                      Text(
                        "Paypal",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),
          SizedBox(
            width: maxW-40,
            height: 40,
            child: ElevatedButton(
              onPressed: (){

                Loading(
                  context, 
                  process: FirebaseService.service.cancelOrder(
                    orderID: widget.order.orderId,
                    adminID: widget.order.product["cid"],
                    price: widget.order.product["price"]["new"],
                    qty: widget.order.product["buy_qty"]
                  ),
                ).executeProcess();

              }, 
              child: Center(
                child: Text("Cancle Order"),
              )
            ),
          ),
          const SizedBox(height: 30),
          // TempOrderItem(date: DateTime.now(), order: widget.order),
          // OrderItem(order: order, visibleProducts: 1),
        ],
      ),

    );
  }
}
