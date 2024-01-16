Feature: Profile
  Scenario: Navigate the Botton Bar
    Given the "Profile" screen 
    When I tap "EditProfilPage"
    And I write "CodeMasters" in "UserName"
    And I submit
    Then I can see "CodeMasters"