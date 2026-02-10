class DashboardModel {
  const DashboardModel({required this.title, required this.count});
  
  final String title;
  final String count;
}

class DashboardData {
  DashboardData._();

  static List<DashboardModel> list = const [
    DashboardModel(title: 'Total Annual Sales', count: '148.42 Cr'),
    DashboardModel(title: 'Month\'s Sales', count: '16.65 Cr'),
    DashboardModel(title: 'Today\'s Sales', count: '32,65,505.2'),
    DashboardModel(title: 'Today\'s Sales No.', count: '25'),
    DashboardModel(title: 'Month\'s Sales No.', count: '259'),
    DashboardModel(title: 'Year\'s Sales No.', count: '1158'),
  ];
}
