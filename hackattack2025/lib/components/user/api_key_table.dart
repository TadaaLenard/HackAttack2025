import 'package:flutter/material.dart';

class ApiKeyTable extends StatefulWidget {
  final List<Map<String, String>> apiKeys;
  final void Function(int index)? onDelete;

  const ApiKeyTable({
    super.key,
    required this.apiKeys,
    this.onDelete,
  });

  @override
  State<ApiKeyTable> createState() => _ApiKeyTableState();
}

class _ApiKeyTableState extends State<ApiKeyTable> {
  late List<bool> isKeyVisible;

  @override
  void initState() {
    super.initState();
    isKeyVisible = List.filled(widget.apiKeys.length, false);
  }

  @override
  void didUpdateWidget(ApiKeyTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.apiKeys.length != widget.apiKeys.length) {
      isKeyVisible = List.filled(widget.apiKeys.length, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE1F2D3), // Background of table
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(color: Colors.grey),
          columnWidths: const {
            0: FixedColumnWidth(30),
            1: FixedColumnWidth(140),
            2: FixedColumnWidth(108),
            3: FixedColumnWidth(100),
            4: FixedColumnWidth(40),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFE1F2D3)),
              children: [
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('#',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Key',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Description',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Expires',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                Padding(padding: EdgeInsets.all(8.0), child: SizedBox()),
              ],
            ),
            ...widget.apiKeys.asMap().entries.map((entry) {
              int index = entry.key;
              var key = entry.value;

              return TableRow(
                decoration: const BoxDecoration(
                  color: Color(0xFFF5FFED), // Row background color
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      (index + 1).toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isKeyVisible[index] = !isKeyVisible[index];
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            isKeyVisible[index]
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              isKeyVisible[index]
                                  ? key['key']!
                                  : 'Show key',
                              softWrap: true,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      key['description'] ?? '',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      key['expires'] ?? '',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'delete' && widget.onDelete != null) {
                          widget.onDelete!(index);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                            value: 'delete', child: Text('Delete')),
                      ],
                      icon: const Icon(Icons.more_vert),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
