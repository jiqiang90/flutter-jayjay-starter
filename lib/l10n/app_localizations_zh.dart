// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'JayJay Starter';

  @override
  String get home => '首页';

  @override
  String get test => '测试';

  @override
  String get profile => '我的';

  @override
  String get settings => '设置';

  @override
  String get themeSettings => '主题设置';

  @override
  String get lightMode => '浅色模式';

  @override
  String get darkMode => '深色模式';

  @override
  String get notificationSettings => '通知设置';

  @override
  String get notificationsEnabled => '已开启';

  @override
  String get notificationsDisabled => '已关闭';

  @override
  String get languageSettings => '语言设置';

  @override
  String get aboutApp => '关于应用';

  @override
  String get version => '版本';

  @override
  String get checkUpdates => '检查更新';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get userAgreement => '用户协议';

  @override
  String get premium => '高级会员';

  @override
  String get upgradeToPremium => '升级到高级会员';

  @override
  String get premiumBenefits => '解锁所有功能并移除广告';

  @override
  String get premiumStatus => '会员状态';

  @override
  String get upgradeNow => '立即升级';

  @override
  String get expireDate => '到期日期';

  @override
  String get noAds => '无广告';

  @override
  String get unlimitedRequests => '无限请求次数';

  @override
  String get unlimitedStorage => '无限存储空间';

  @override
  String get unlimitedHistory => '无限历史记录';

  @override
  String get advancedFeatures => 'Advanced Features';

  @override
  String get monthlyPlan => '月度会员';

  @override
  String get yearlyPlan => '年度会员';

  @override
  String get perMonth => '每月';

  @override
  String get perYear => '每年';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get purchaseSuccess => '购买成功';

  @override
  String get purchaseSuccessMessage => '感谢您的支持！您现在是高级会员了。';

  @override
  String get purchaseFailed => '购买失败';

  @override
  String get purchaseFailedMessage => '购买失败，请稍后重试。如果问题持续存在，请联系客服。';

  @override
  String get businessTest => '业务测试';

  @override
  String get businessName => '业务名称';

  @override
  String get businessDescription => '业务描述';

  @override
  String get userId => '用户ID';

  @override
  String get createBusiness => '创建业务';

  @override
  String remainingOperations(int count) {
    return '剩余操作次数：$count';
  }

  @override
  String remainingBusinesses(int count) {
    return '剩余可创建业务数量：$count';
  }

  @override
  String get loading => '加载中...';

  @override
  String get loadingComplete => '加载完成';

  @override
  String loadingFailed(String error) {
    return '加载失败：$error';
  }

  @override
  String get clearData => '清除数据';

  @override
  String get dataCleared => '数据已清除';

  @override
  String clearFailed(String error) {
    return '清除失败：$error';
  }

  @override
  String get confirm => '确定';

  @override
  String get cancel => '取消';

  @override
  String get ok => '确定';

  @override
  String get error => '错误';

  @override
  String get success => '成功';

  @override
  String get appDescription => '这是一个示例应用，展示了如何构建一个功能完整的 Flutter 应用。';

  @override
  String get usageLimits => '使用限制';

  @override
  String get premiumFeatures => '高级功能';

  @override
  String get featureNoAds => '无广告';

  @override
  String get featureUnlimitedRequests => '无限请求次数';

  @override
  String get featureUnlimitedStorage => '无限存储空间';

  @override
  String get featureUnlimitedHistory => '无限历史记录';

  @override
  String get featureAdvancedFeatures => '高级功能';

  @override
  String get dailyRequests => '每日请求次数';

  @override
  String get storageLimit => '存储空间限制';

  @override
  String get historyLimit => '历史记录限制';

  @override
  String get usageStats => '使用统计';

  @override
  String get todayRequests => '今日请求';

  @override
  String get storageUsage => '存储空间';

  @override
  String get historyRecords => '历史记录';

  @override
  String get upgradeToPremiumTitle => '升级到高级版';

  @override
  String get upgradeToPremiumDesc => '解锁所有限制，享受无限制使用体验';

  @override
  String get notLoggedIn => '未登录';

  @override
  String get premiumPurchase => 'Premium Purchase';

  @override
  String get purchaseServiceError => 'Unable to connect to purchase service';

  @override
  String get restoreSuccess => 'Restore Success';

  @override
  String get restoreSuccessMessage => 'Your purchases have been restored.';

  @override
  String get restoreFailed => 'Restore Failed';

  @override
  String get restoreFailedMessage => 'Failed to restore purchases';

  @override
  String get choosePlan => 'Choose Plan';

  @override
  String get purchaseNow => 'Purchase Now';

  @override
  String get mostPopular => 'Most Popular';

  @override
  String get featureEarlyAccess => 'Early access to new features';

  @override
  String get featurePrioritySupport => 'Priority customer support';

  @override
  String get premiumUpgradeTitle => '升级到高级会员';

  @override
  String get premiumUpgradeDescription => '解锁所有功能并移除广告';

  @override
  String get premiumFeatureNoAds => '享受无广告体验';

  @override
  String get premiumFeatureUnlimitedRequests => '无限制的请求次数';

  @override
  String get premiumFeatureUnlimitedStorage => '获得无限存储空间';

  @override
  String get premiumFeatureAdvanced => '使用高级功能';

  @override
  String get premiumUpgradeButton => '立即升级';

  @override
  String get premiumLimitReachedTitle => '已达到使用限制';

  @override
  String get premiumLimitReachedDescription => '您已达到免费版使用限制，升级到高级会员以继续使用';

  @override
  String get premiumTrialExpiredTitle => '试用期已过';

  @override
  String get premiumTrialExpiredDescription => '您的试用期已结束，升级到高级会员以继续使用所有功能';

  @override
  String get errorOperationLimitReached => '已达到免费用户操作次数上限，请升级到高级会员';

  @override
  String get errorBusinessLimitReached => '已达到免费用户业务数量上限，请升级到高级会员';

  @override
  String get errorPremiumRequired => '此功能需要高级会员，请升级后继续使用';

  @override
  String errorOperationFailed(String error) {
    return '操作失败：$error';
  }

  @override
  String get businessList => '业务列表';

  @override
  String get updateSuccess => '更新成功';

  @override
  String updateFailed(String error) {
    return '更新失败：$error';
  }

  @override
  String get deleteSuccess => '删除成功';

  @override
  String deleteFailed(String error) {
    return '删除失败：$error';
  }

  @override
  String get premiumLimitReached => '已达到免费用户使用限制';
}
