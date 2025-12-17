import 'package:flutter/material.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final Set<int> completedDays = {};

  void _showTasks(BuildContext context, int day) {
    bool task1Completed = false;
    bool task2Completed = false;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            int completedCount =
                (task1Completed ? 1 : 0) + (task2Completed ? 1 : 0);
            double progress = completedCount / 2;

     
            if (progress == 1 && !completedDays.contains(day)) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  completedDays.add(day);
                });
              });
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  Text(
                    "Day $day Tasks",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.green,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Text(
                    "${(progress * 100).toInt()}% Completed",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 16),

                  _taskTile(
                    title: "Task 1",
                    isCompleted: task1Completed,
                    onComplete: () =>
                        setModalState(() => task1Completed = true),
                    onPending: () =>
                        setModalState(() => task1Completed = false),
                  ),

                  _taskTile(
                    title: "Task 2",
                    isCompleted: task2Completed,
                    onComplete: () =>
                        setModalState(() => task2Completed = true),
                    onPending: () =>
                        setModalState(() => task2Completed = false),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _taskTile({
    required String title,
    required bool isCompleted,
    required VoidCallback onComplete,
    required VoidCallback onPending,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Color(0xFF667EEA)),
          const SizedBox(width: 12),
          Expanded(child: Text(title)),
          GestureDetector(
            onTap: onComplete,
            child: _statusChip("Complete", Colors.green, isCompleted),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onPending,
            child: _statusChip("Pending", Colors.orange, !isCompleted),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String text, Color color, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: active ? color.withOpacity(0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "15 Day Planner",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),

                const Text(
                  "Track your daily progress",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: GridView.builder(
                    itemCount: 15,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.9,
                        ),
                    itemBuilder: (context, index) {
                      final int day = index + 1;

          
                      final bool isUnlocked =
                          day == 1 || completedDays.contains(day - 1);

                      return InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: isUnlocked
                            ? () => _showTasks(context, day)
                            : null,
                        child: Opacity(
                          opacity: isUnlocked ? 1 : 0.45,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: const Color(0xFF667EEA),
                                    child: Text(
                                      "$day",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text("Day $day"),
                                  const SizedBox(height: 8),
                                  _statusChip(
                                    isUnlocked ? "Pending" : "Locked",
                                    isUnlocked ? Colors.orange : Colors.grey,
                                    true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
