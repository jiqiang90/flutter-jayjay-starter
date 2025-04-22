import 'package:flutter/material.dart';
import 'package:jayjay_starter/services/core/service_factory.dart';
import 'package:jayjay_starter/widgets/cards/app_card.dart';
import 'package:jayjay_starter/l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ServiceFactory.userService.getUsageStats(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final stats = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildUserInfo(context),
              const SizedBox(height: 24),
              _buildStatsCard(
                context,
                l10n.todayRequests,
                '${stats['requestsToday']}',
                Icons.send,
              ),
              const SizedBox(height: 16),
              _buildStatsCard(
                context,
                l10n.storageUsage,
                '${stats['storageUsed']}MB',
                Icons.storage,
              ),
              const SizedBox(height: 16),
              _buildStatsCard(
                context,
                l10n.historyRecords,
                '${stats['historyCount']}',
                Icons.history,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(
            ServiceFactory.userService.getUserData()?.name ?? l10n.notLoggedIn),
        subtitle: Text(ServiceFactory.userService.getUserData()?.email ?? ''),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: 跳转到用户详情页面
        },
      ),
    );
  }

  Widget _buildStatsCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
