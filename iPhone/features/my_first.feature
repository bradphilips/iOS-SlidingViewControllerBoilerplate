Feature: Login
  As an boilerplate user
  I want to be able to login to the application
  So I can use the app

Scenario: Login
  Given my app is running
  Then take picture
  And I enter "brad" into the "Username" text field
  And I enter "secure" into the "Password" text field
  Then I touch "Login"
  Then I should see "Main"
  Then take picture

  Then I swipe right
  Then I should see "Main"
  And I should see "Second"
  Then I touch "Second"
  Then I should see "Second"
  Then take picture