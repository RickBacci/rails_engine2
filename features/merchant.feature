Feature: Merchants can use the site

  As a merchant,
  I want to be able to view my items.

  Scenario:
    Given I'm a registered merchant with an id of 1
    And I have no items
    When I send a GET request to "/api/v1/merchants/1/items"
      Then the response status should be "200"
       And the JSON response should be "[]"
