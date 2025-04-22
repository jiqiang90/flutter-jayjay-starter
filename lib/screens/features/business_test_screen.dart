import 'package:flutter/material.dart';
import 'package:jayjay_starter/models/business.dart';
import 'package:jayjay_starter/services/core/service_factory.dart';
import 'package:jayjay_starter/l10n/app_localizations.dart';
import 'package:jayjay_starter/widgets/premium/upgrade_premium_sheet.dart';
import 'package:jayjay_starter/config/routes.dart';

class BusinessTestScreen extends StatefulWidget {
  const BusinessTestScreen({super.key});

  @override
  State<BusinessTestScreen> createState() => _BusinessTestScreenState();
}

class _BusinessEditDialog extends StatefulWidget {
  final Business business;
  final AppLocalizations l10n;

  const _BusinessEditDialog({
    required this.business,
    required this.l10n,
  });

  @override
  State<_BusinessEditDialog> createState() => _BusinessEditDialogState();
}

class _BusinessEditDialogState extends State<_BusinessEditDialog> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.business.name);
    descriptionController = TextEditingController(text: widget.business.description);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.l10n.confirm),
      content: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: widget.l10n.businessName,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: widget.l10n.businessDescription,
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(widget.l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop({
            'name': nameController.text,
            'description': descriptionController.text,
          }),
          child: Text(widget.l10n.confirm),
        ),
      ],
    );
  }
}

class _BusinessTestScreenState extends State<BusinessTestScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _userIdController = TextEditingController(text: 'test_user');
  List<Business> _businesses = [];
  String _status = '';
  int _remainingOperations = 0;
  int _remainingBusinesses = 0;
  late AppLocalizations _l10n;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _l10n = AppLocalizations.of(context)!;
    ServiceFactory.businessService.setL10n(_l10n);
    _loadBusinesses();
  }

  Future<void> _loadBusinesses() async {
    final businessService = ServiceFactory.businessService;
    final userId = _userIdController.text;

    setState(() {
      _status = _l10n.loading;
    });

    try {
      final businesses = await businessService.getUserBusinesses(userId);
      final remainingOperations = await businessService.getRemainingOperations(userId);
      final remainingBusinesses = await businessService.getRemainingBusinesses(userId);

      setState(() {
        _businesses = businesses;
        _remainingOperations = remainingOperations;
        _remainingBusinesses = remainingBusinesses;
        _status = _l10n.loadingComplete;
      });
    } catch (e) {
      setState(() {
        _status = _l10n.loadingFailed(e.toString());
      });
    }
  }

  void _handlePremiumError(String message) {
    if (!mounted) return;
    
    UpgradePremiumSheet.show(
      context,
      message: _l10n.premiumLimitReached,
      onUpgradePressed: () {
        Navigator.of(context).pushNamed(AppRoutes.premium);
      },
    );
  }

  Future<void> _createBusiness() async {
    final businessService = ServiceFactory.businessService;

    try {
      await businessService.createBusiness(
        name: _nameController.text,
        description: _descriptionController.text,
        userId: _userIdController.text,
      );

      _nameController.clear();
      _descriptionController.clear();
      await _loadBusinesses();
    } catch (e) {
      if (!mounted) return;
      
      final errorMessage = e.toString();
      setState(() {
        _status = errorMessage;
      });
      
      if (errorMessage.toLowerCase().contains('limit') || 
          errorMessage.toLowerCase().contains('premium')) {
        _handlePremiumError(errorMessage);
      }
    }
  }

  Future<void> _updateBusiness(Business business) async {
    final Map<String, String>? result = await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) => _BusinessEditDialog(
        business: business,
        l10n: _l10n,
      ),
    );

    if (result == null) return;

    try {
      final businessService = ServiceFactory.businessService;
      final updatedBusiness = Business(
        id: business.id,
        name: result['name'] ?? business.name,
        description: result['description'] ?? business.description,
        createdAt: business.createdAt,
        updatedAt: DateTime.now(),
        userId: business.userId,
      );

      final updateResult = await businessService.updateBusiness(updatedBusiness);
      if (updateResult != null && mounted) {
        setState(() {
          _status = _l10n.updateSuccess;
        });
        await _loadBusinesses();
      }
    } catch (e) {
      if (!mounted) return;
      
      final errorMessage = e.toString();
      setState(() {
        _status = _l10n.updateFailed(errorMessage);
      });
      
      if (errorMessage.toLowerCase().contains('limit') || 
          errorMessage.toLowerCase().contains('premium')) {
        _handlePremiumError(errorMessage);
      }
    }
  }

  Future<void> _deleteBusiness(String businessId) async {
    try {
      final businessService = ServiceFactory.businessService;
      final success = await businessService.deleteBusiness(
        businessId,
        _userIdController.text,
      );

      if (success && mounted) {
        setState(() {
          _status = _l10n.deleteSuccess;
        });
        await _loadBusinesses();
      }
    } catch (e) {
      if (!mounted) return;
      
      final errorMessage = e.toString();
      setState(() {
        _status = _l10n.deleteFailed(errorMessage);
      });
      
      if (errorMessage.toLowerCase().contains('limit') || 
          errorMessage.toLowerCase().contains('premium')) {
        _handlePremiumError(errorMessage);
      }
    }
  }

  Future<void> _clearAllData() async {
    try {
      final businessService = ServiceFactory.businessService;
      await businessService.clearAllData();
      setState(() {
        _status = _l10n.dataCleared;
        _businesses = [];
      });
    } catch (e) {
      setState(() {
        _status = _l10n.clearFailed(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_l10n.businessTest),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(
                labelText: _l10n.userId,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: _l10n.businessName,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: _l10n.businessDescription,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createBusiness,
              child: Text(_l10n.createBusiness),
            ),
            const SizedBox(height: 16),
            Text(
              _l10n.remainingOperations(_remainingOperations),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              _l10n.remainingBusinesses(_remainingBusinesses),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(_status),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _clearAllData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text(_l10n.clearData),
            ),
            const SizedBox(height: 16),
            Text(
              _l10n.businessList,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._businesses.map((business) => Card(
              child: ListTile(
                title: Text(business.name),
                subtitle: Text(business.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _updateBusiness(business),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteBusiness(business.id),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _userIdController.dispose();
    super.dispose();
  }
} 