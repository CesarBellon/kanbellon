import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_selector/file_selector.dart';
import '../../providers/kanban_provider.dart';

class SettingsDialog extends ConsumerStatefulWidget {
  const SettingsDialog({super.key});

  @override
  ConsumerState<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends ConsumerState<SettingsDialog> {
  final _clientIdController = TextEditingController();
  final _clientSecretController = TextEditingController();
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    final kanbanNotifier = ref.read(kanbanProvider.notifier);
    final isCloudSignedIn = kanbanNotifier.isCloudSignedIn;

    return Dialog(
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
            const Divider(height: 32),
            
            _buildSectionHeader(context, 'Data Management'),
            const SizedBox(height: 16),
            
            // Import / Export
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                       try {
                           await kanbanNotifier.importData();
                           if (context.mounted) {
                               Navigator.pop(context);
                               ScaffoldMessenger.of(context).showSnackBar(
                                   const SnackBar(content: Text('Data imported successfully!'))
                               );
                           }
                       } catch (e) {
                           if (context.mounted) {
                               ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(content: Text('Import Failed: $e'), backgroundColor: Colors.red)
                               );
                           }
                       }
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Import JSON'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                         kanbanNotifier.exportData();
                         if (context.mounted) Navigator.pop(context);
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Export JSON'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Storage Location
            Text('Storage Location', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.folder_open, size: 20, color: Colors.grey),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "Data is saved locally used the configured path.", 
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                ],
              ),
            ),
             const SizedBox(height: 8),
             Align(
                 alignment: Alignment.centerRight,
                 child: TextButton.icon(
                     onPressed: () async {
                         String? selectedDirectory = await getDirectoryPath();
                         if (selectedDirectory == null) return;
                         
                         final path = '$selectedDirectory/kanban_data.json';
                         await kanbanNotifier.setPersistencePath(path);
                         
                         if (context.mounted) {
                             ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content: Text('Save location updated to: $path'))
                             );
                         }
                     },
                     icon: const Icon(Icons.edit),
                     label: const Text("Change Save Location")
                 ),
             ),
             
             const Divider(height: 32),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 _buildSectionHeader(context, 'Cloud Sync (Google Drive)'),
                 IconButton(
                   icon: const Icon(Icons.help_outline, color: Colors.grey),
                   tooltip: "How to get credentials",
                   onPressed: () => _showCredentialsHelp(context),
                 )
               ],
             ),
             const SizedBox(height: 16),
             if (kanbanNotifier.isCloudSignedIn) ...[
                 Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                    child: Row(
                        children: const [
                            Icon(Icons.check_circle, color: Colors.green),
                            SizedBox(width: 12),
                            Text("Connected to Google Drive", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                        ],
                    )
                 ),
                 const SizedBox(height: 8),
                 OutlinedButton.icon(
                     onPressed: () async {
                         await kanbanNotifier.syncFromCloud();
                         if (context.mounted) {
                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Synced from cloud!")));
                         }
                     }, 
                     icon: const Icon(Icons.cloud_download), 
                     label: const Text("Force Sync from Cloud")
                 )
             ] else ...[
                 const Text("Enter your Google Cloud OAuth Credentials to enable sync.", style: TextStyle(fontSize: 12, color: Colors.grey)),
                 const SizedBox(height: 8),
                 TextField(
                     controller: _clientIdController,
                     decoration: const InputDecoration(labelText: "Client ID", border: OutlineInputBorder()),
                 ),
                 const SizedBox(height: 8),
                 TextField(
                     controller: _clientSecretController,
                     decoration: const InputDecoration(labelText: "Client Secret", border: OutlineInputBorder()),
                     obscureText: true,
                 ),
                 const SizedBox(height: 16),
                 FilledButton.icon(
                     onPressed: _isSigningIn ? null : () async {
                         setState(() => _isSigningIn = true);
                         await kanbanNotifier.signInToDrive(_clientIdController.text, _clientSecretController.text);
                         setState(() => _isSigningIn = false);
                     },
                     icon: _isSigningIn ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.cloud),
                     label: const Text("Connect Drive")
                 )
             ],

            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _showCredentialsHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("How to get Credentials"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("1. Go to the Google Cloud Console (console.cloud.google.com)."),
              SizedBox(height: 8),
              Text("2. Create a new Project."),
              SizedBox(height: 8),
              Text("3. Navigate to 'APIs & Services' > 'Credentials'."),
              SizedBox(height: 8),
              Text("4. Click 'Create Credentials' > 'OAuth client ID'."),
              SizedBox(height: 8),
              Text("5. Application Type: 'Desktop app'."),
              SizedBox(height: 8),
              Text("6. Copy the Client ID and Client Secret."),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Close")),
        ],
      ),
    );
  }
}
