import 'package:add_just/models/account.dart';
import 'package:add_just/models/project.dart';

class ProjectPermissionsResolver {
  ProjectPermissionsResolver({
    this.project,
  });

  final Project project;

  bool get isProjectCreated => project.status == 'created';
  bool get isProjectWorkCommenced => project.status == 'work_commenced';
  bool get isProjectMarkedCompleted => project.status == 'marked_completed';
  bool get isProjectCompletionCertIssued => project.status == 'completion_cert_issued';
  bool get isProjectPaymentClaimSubmitted => project.status == 'payment_claim_submitted';
  bool get isProjectPaymentRecommendationIssued => project.status == 'payment_recommendation_issued';
  bool get isProjectPaymentCertificationIssued => project.status == 'payment_certification_issued';
  bool get isProjectInvoiceReceived => project.status == 'invoice_received';
  bool get isProjectPaid => project.status == 'paid';

  bool get isAMO => Account.current.isAMO;
  bool get isCTR => Account.current.isContractor;

  bool get canAddScopeItems => isProjectCreated && isAMO;
  bool get canAmendScopeItemQty => canAddScopeItems;
  bool get canRemoveScopeItems => canAddScopeItems;
  bool get canSetDoneScopeItems => isProjectWorkCommenced;
  bool get canFinaliseScope => canAddScopeItems && project.sections.length > 0
    && project.sections.firstWhere((s) => !s.isNotEmpty, orElse: () => null) != null;

  bool get canIssueCompletionCertificate => isProjectWorkCommenced && isAMO;

  bool get canSubmitPaymentClaim => isProjectCompletionCertIssued && isCTR;

  bool get canSubmitInvoice => isProjectPaymentCertificationIssued && isCTR;
}
