import 'package:flutter/material.dart';
import 'package:req_sys_finale/features/home/pages/admin_tabs/requisition_tab.dart';

import '../../../../core/constants/color_constants.dart';
import '../../model/requisition.dart';

class ExeRequisitions extends StatefulWidget {
  final List<Requisition> requisitions;
  final String searchTerm;
  const ExeRequisitions({super.key, required this.requisitions, required this.searchTerm});

  @override
  State<ExeRequisitions> createState() => _ExeRequisitionsState();
}

class _ExeRequisitionsState extends State<ExeRequisitions>with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Requisitions',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TabBar(
            controller: _tabController,
            physics: const BouncingScrollPhysics(),
            isScrollable: true,
            unselectedLabelStyle: TextStyle(
              color: Pallete.greyAccent,
              fontSize: 14,
            ),
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            tabAlignment: TabAlignment.start,
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
            ],
          ),
          SizedBox(
            height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                RequisitionTab(
                  searchTerm: widget.searchTerm,
                  requisition: widget.requisitions
                      .where((requisition) =>  requisition.authorisedByMD == false
                  ).toList(),
                ),
                RequisitionTab(
                  searchTerm: widget.searchTerm,
                  requisition: widget.requisitions
                      .where((requisition) =>  requisition.authorisedByMD == true
                  ).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
