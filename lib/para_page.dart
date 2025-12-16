import 'package:flutter/material.dart';

class ReadingContentPage extends StatefulWidget {
  const ReadingContentPage({super.key});

  @override
  State<ReadingContentPage> createState() => _ReadingContentPageState();
}

class _ReadingContentPageState extends State<ReadingContentPage> {
  final TextEditingController paragraphController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  String selectedLevel = "Basic Level";
  String? selectedContentType;

  final List<String> levels = [
    "Basic Level",
    "Intermediate Level",
    "Advanced Level",
  ];

  final List<String> contentTypes = [
    "Paragraph",
    "Essay",
    "Article",
    "Story",
    "Summary",
    "Report",
    "Notes",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Creative Form",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

          
                _fieldLabel("Paragraph"),
                _buildCard(
                  child: TextField(
                    controller: paragraphController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: "Paste your paragraph here...",
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                _fieldLabel("Duration"),
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: durationController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Enter duration (in minutes)",
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Maximum time required to read the provided paragraph (in minutes)",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                _fieldLabel("Content Type"),
                _buildCard(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedContentType,
                      hint: const Text(
                        "Select content type...",
                        style: TextStyle(
                          color: Color.fromARGB(255, 76, 76, 76),
                        ),
                      ),
                      isExpanded: true,
                      items: contentTypes.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedContentType = value;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                _fieldLabel("Level"),
                _buildCard(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedLevel,
                      isExpanded: true,
                      items: levels.map((level) {
                        return DropdownMenuItem(
                          value: level,
                          child: Text(level),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLevel = value!;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Form Submitted Successfully"),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 6,
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF764BA2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  /// Card container
  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
