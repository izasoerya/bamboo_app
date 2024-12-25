import 'package:bamboo_app/src/app/presentation/widgets/organism/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CustomInfoWindow extends StatelessWidget {
  final String uidMarker;
  final String name;
  final String description;
  final int qty;
  final String ownerName;
  final String ownerContact;

  const CustomInfoWindow({
    super.key,
    required this.uidMarker,
    required this.name,
    required this.description,
    required this.qty,
    required this.ownerName,
    required this.ownerContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Data Detail',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),
          Text('Name: $name'),
          Text('Description: $description'),
          Text('Quantity: $qty'),
          Text('Owner Name: $ownerName'),
          Text('Owner Contact: $ownerContact'),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext modalContext) =>
                        ModalBottomSheet(parentContext: context),
                  );
                },
                child: const Text('Update'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
