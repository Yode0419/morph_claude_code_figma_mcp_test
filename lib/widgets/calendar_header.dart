import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calendar_provider.dart';
import '../providers/task_provider.dart';
import '../utils/colors.dart';
import '../utils/date_utils.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CalendarProvider, TaskProvider>(
      builder: (context, calendarProvider, taskProvider, child) {
        final weekDates = calendarProvider.getWeekDates(calendarProvider.selectedDate);
        
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              _buildMonthNavigation(context, calendarProvider),
              const Divider(height: 1),
              _buildWeekView(context, calendarProvider, taskProvider, weekDates),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMonthNavigation(BuildContext context, CalendarProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: provider.previousMonth,
          ),
          Text(
            AppDateUtils.formatMonthYear(provider.currentMonth),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: provider.nextMonth,
          ),
        ],
      ),
    );
  }

  Widget _buildWeekView(
    BuildContext context,
    CalendarProvider calendarProvider,
    TaskProvider taskProvider,
    List<DateTime> weekDates,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: weekDates.map((date) {
          final isSelected = calendarProvider.isSameDay(date, calendarProvider.selectedDate);
          final isToday = calendarProvider.isToday(date);
          final hasTasks = taskProvider.hasTasksOnDate(date);
          
          return GestureDetector(
            onTap: () => calendarProvider.selectDate(date),
            child: SizedBox(
              width: 48,
              child: Column(
                children: [
                  Text(
                    AppDateUtils.formatWeekday(date),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryBlue : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        AppDateUtils.formatDay(date),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (hasTasks)
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : AppColors.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                    )
                  else
                    const SizedBox(height: 4),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}