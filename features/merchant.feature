Feature: Merchants can use the site

  As a merchant,
  I want to be able to view my items.

  Scenario: View my items in JSON
    Given I'm a merchant with no items
    When I send and accept JSON
    And I send a GET request to "/api/v1/merchants/items"
    Then the response status should be "200"
