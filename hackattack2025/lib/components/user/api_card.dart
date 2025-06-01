import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApiEndpointCard extends StatefulWidget {
  final String title;
  final String description;
  final String requestCode;
  final String responseCode;

  const ApiEndpointCard({
    super.key,
    required this.title,
    required this.description,
    required this.requestCode,
    required this.responseCode,
  });

  @override
  State<ApiEndpointCard> createState() => _ApiEndpointCardState();
}

class _ApiEndpointCardState extends State<ApiEndpointCard> {
  bool _copiedRequest = false;
  bool _copiedResponse = false;

  void _copyCode(String code, bool isRequest) {
    Clipboard.setData(ClipboardData(text: code));
    setState(() {
      if (isRequest) {
        _copiedRequest = true;
      } else {
        _copiedResponse = true;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if (isRequest) {
          _copiedRequest = false;
        } else {
          _copiedResponse = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.description,
            style: const TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 12),
          _buildCodeBlock("Example Request:", widget.requestCode, true, _copiedRequest),
          const SizedBox(height: 16),
          _buildCodeBlock("Example Response:", widget.responseCode, false, _copiedResponse),
        ],
      ),
    );
  }

  Widget _buildCodeBlock(String label, String code, bool isRequest, bool copied) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2E2E2E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Code",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    TextButton.icon(
                      onPressed: () => _copyCode(code, isRequest),
                      icon: Icon(
                        copied ? Icons.check : Icons.copy,
                        size: 16,
                        color: Colors.white,
                      ),
                      label: Text(
                        copied ? "Copied!" : "Copy Code",
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SelectableText(
                    code,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
