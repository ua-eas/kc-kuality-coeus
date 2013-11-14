Feature: Proposal Workflows and Routing

  As system user with the appropriate roles and permissions, I want the ability to
  take actions against a proposal that will navigate it through various routes
  in workflow.

  Scenario Outline: Proposal is successfully routed to PI for action
    Given users exist with the following roles: OSPApprover, Proposal Creator, Unassigned
    And   I log in with the Proposal Creator user
    And   initiate a Proposal
    And   add the Unassigned user as a Principal Investigator to the key personnel proposal roles
    And   complete the required custom fields on the Proposal
    And   submit the Proposal
    When  the OSPApprover user approves the Proposal
    And   I log in with the Unassigned user
    Then  I can access the proposal from my action list
    And   the <Action> button appears on the Proposal Summary and Proposal Action pages

  Examples:
    | Action     |
    | Approve    |
    | Disapprove |
    | Reject     |

  Scenario Outline: Proposal is successfully routed to OSP Approver for action
    Given users exist with the following roles: Proposal Creator, OSPApprover
    And   I log in with the Proposal Creator user
    And   submit a new development Proposal into routing
    When  I log in with the OSPApprover user
    Then  I can access the proposal from my action list
    And   the <Action> button appears on the Proposal Summary and Proposal Action pages

  Examples:
    | Action     |
    | Approve    |
    | Disapprove |
    | Reject     |

  Scenario: Aggregator successfully submits a proposal into routing
    Given a user exists with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   submit a new development Proposal into routing
    Then  the proposal status should be Approval Pending

  Scenario: Aggregator successfully blanket approves a routed proposal
    Given a user exists with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I submit a new development Proposal into routing
    When  I blanket approve the proposal
    Then  the proposal status should be Approval Granted

  Scenario: Aggregator successfully recalls a routed proposal
    Given a user exists with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   I submit a new development Proposal into routing
    When  I recall the Proposal
    Then  the proposal status should be Revisions Requested

  Scenario: Successful delivery of an FYI from a development proposal
    Given users exist with the following roles: Proposal Creator, OSPApprover
    And   I log in with the Proposal Creator user
    And   I initiate a Proposal
    When  I send a notification to the OSPApprover user
    And   I log in with the OSPApprover user
    Then  I should receive an action list item with the requested action being: FYI
    And   I can acknowledge the requested action list item
  @test
  Scenario: An OSP Admin overrides a budget's cost sharing amount
    Given the Budget Column's 'Cost Sharing Amount' has a lookup for 'Proposal Cost Share' that returns 'Amount'
    And   users exist with the following roles: Proposal Creator, OSP Administrator
    And   I log in with the Proposal Creator user
    And   initiate a Proposal
    And   add a principal investigator
    And   set valid credit splits for the Proposal
    And   create a budget version with cost sharing for the Proposal
    And   finalize the budget version
    And   mark the budget version complete
    And   complete the required custom fields on the Proposal
    And   submit the Proposal
    When  I log in with the OSP Administrator user
    Then  I can override the cost sharing amount