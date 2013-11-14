Feature: Creating an Institutional Proposal from a Proposal Log

  Summary text TBD

  Scenario: Attempt to initiate a Funding Proposal document w/o a required field
    Given I'm logged in with dkensrue
    And   I submit a new proposal log
    When  I attempt to save an institutional proposal with a missing required field
    Then  an error should appear that says the field is required

  Scenario: Create a Temporary Proposal Log and merge it with an Institutional Proposal
    Given I'm logged in with dkensrue
    And   I submit a new institutional proposal created from a proposal log
    When  I submit a new temporary proposal log document
    And   I merge the temporary proposal log with the institutional proposal
    Then  the proposal log's status should reflect it has been merged