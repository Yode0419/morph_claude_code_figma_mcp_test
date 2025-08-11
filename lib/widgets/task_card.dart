import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/task.dart';
import '../utils/colors.dart';
import '../utils/date_utils.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onActionPressed;

  const TaskCard({
    super.key,
    required this.task,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 12),
            _buildAddress(context),
            const SizedBox(height: 12),
            _buildAssignee(context),
            const SizedBox(height: 12),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppDateUtils.formatTimeRange(task.startTime, task.endTime),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.getStatusColor(task.statusText).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            task.statusText,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.getStatusColor(task.statusText),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task.address,
          style: Theme.of(context).textTheme.bodyLarge,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          '${task.city}                     ${task.state}   ${task.zipCode}',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }

  Widget _buildAssignee(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.person_outline,
          size: 20,
          color: AppColors.primaryBlue,
        ),
        const SizedBox(width: 8),
        Text(
          task.assignedTo,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.primaryBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildIconButton(
              Icons.navigation_outlined,
              () => _launchMaps(),
            ),
            const SizedBox(width: 8),
            _buildIconButton(
              Icons.phone_outlined,
              () => _makePhoneCall(),
            ),
          ],
        ),
        if (task.status == TaskStatus.completed)
          OutlinedButton.icon(
            onPressed: onActionPressed,
            icon: const Icon(Icons.description_outlined, size: 18),
            label: Text(task.actionButtonText),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textSecondary,
              side: const BorderSide(color: AppColors.divider),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          )
        else
          ElevatedButton(
            onPressed: onActionPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(task.actionButtonText),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 18),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.divider),
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: AppColors.textSecondary,
        iconSize: 20,
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
      ),
    );
  }

  void _launchMaps() async {
    final query = Uri.encodeComponent('${task.address}, ${task.city}, ${task.state} ${task.zipCode}');
    final url = Uri.parse('https://maps.google.com/maps?q=$query');
    
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _makePhoneCall() async {
    if (task.phoneNumber != null) {
      final url = Uri.parse('tel:${task.phoneNumber}');
      
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    }
  }
}