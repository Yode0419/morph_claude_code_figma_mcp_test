import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calendar_provider.dart';
import '../providers/task_provider.dart';
import '../providers/user_provider.dart';
import '../utils/date_utils.dart';
import '../utils/colors.dart';
import '../widgets/calendar_header.dart';
import '../widgets/task_card.dart';
import '../widgets/smart_template_banner.dart';
import '../widgets/usage_footer.dart';

class DailySchedulePage extends StatefulWidget {
  const DailySchedulePage({Key? key}) : super(key: key);

  @override
  State<DailySchedulePage> createState() => _DailySchedulePageState();
}

class _DailySchedulePageState extends State<DailySchedulePage> {
  bool _showSmartBanner = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          const CalendarHeader(),
          Expanded(
            child: Consumer2<CalendarProvider, TaskProvider>(
              builder: (context, calendarProvider, taskProvider, child) {
                final selectedTasks = taskProvider.getTasksForDate(calendarProvider.selectedDate);
                
                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    if (_showSmartBanner) ...[
                      SmartTemplateBanner(
                        onDismiss: () {
                          setState(() {
                            _showSmartBanner = false;
                          });
                        },
                      ),
                    ],
                    _buildDateHeader(context, calendarProvider.selectedDate),
                    if (selectedTasks.isEmpty)
                      _buildEmptyState(context)
                    else
                      ...selectedTasks.map((task) => TaskCard(
                        task: task,
                        onActionPressed: () => _handleTaskAction(context, task),
                      )),
                    const SizedBox(height: 80),
                  ],
                );
              },
            ),
          ),
          UsageFooter(
            onUpgrade: () => _handleUpgrade(context),
          ),
        ],
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Morph'),
      actions: [
        IconButton(
          icon: const Icon(Icons.navigation_outlined),
          onPressed: () {},
          color: AppColors.primaryBlue,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primaryBlue,
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateHeader(BuildContext context, DateTime date) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        AppDateUtils.formatDayMonth(date),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.event_note,
              size: 64,
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No tasks scheduled for this day',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _handleAddJob(context),
      icon: const Icon(Icons.add),
      label: const Text('Job'),
    );
  }

  void _handleTaskAction(BuildContext context, task) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Action: ${task.actionButtonText} for ${task.address}'),
      ),
    );
  }

  void _handleAddJob(BuildContext context) {
    final currentTime = TimeOfDay.now();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Add new job at ${currentTime.format(context)}'),
      ),
    );
  }

  void _handleUpgrade(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upgrade to Premium'),
        content: const Text('Unlock unlimited reports and premium features!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<UserProvider>().upgradeToPremium();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Welcome to Premium!'),
                ),
              );
            },
            child: const Text('Upgrade'),
          ),
        ],
      ),
    );
  }
}