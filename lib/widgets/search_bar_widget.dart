import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;
  final bool enabled;

  const SearchBarWidget({
    super.key,
    required this.onSearch,
    this.enabled = true,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSearch() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSearch(_controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              cursorColor: Colors.deepOrange,
              controller: _controller,
              enabled: widget.enabled,
              decoration: InputDecoration(
                hintText: "Enter city name",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: Colors.deepOrange,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: (_) => _handleSearch(),
              textInputAction: TextInputAction.search,
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: widget.enabled ? _handleSearch : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
