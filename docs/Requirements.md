## Requirements

## User Stories
### Story #1
As a user want see all the events from university so that I can be informed.

#### User interface mock-up
Feed View
![FeedView1](https://user-images.githubusercontent.com/94714591/224497156-9fcf923a-9d3b-452a-8374-dbc26fdfaf91.jpeg)


#### Acceptance tests
```Gherkin
Scenario: Seing the events.
    Given I am on the app
    When I click on the home page button
    Then I should be able to see all the events
```

#### Value and effort
* Value: Must have
* Effort: 5

 ### Story #2
 As a user I want to login in my account so that I can view my account.

 #### User interface mock-up
Login View
![LoginView](https://user-images.githubusercontent.com/93602635/223664615-192fd868-9b50-4756-8e73-45df61c0de64.PNG)

 #### Acceptance tests
 ```Gherkin
Scenario: Signing in
    Given I have an account already registered
    And I have selected my favourite types of events
    And I am on the login page
    When I input the correct email address
    And I input the correct password
    And I click the sign in button
    Then I should be authenticated
    And I should be redirected to the home page
    And I should be presented with the events filtered to my favourite types
```

 ```Gherkin
Scenario: Signing in
    Given I dont have an account already registered
    And I have selected my favourite types of events
    And I am on the login page
    When I input the correct email address
    And I input the correct password
    And I click the sign in button
    Then I should get an error message "Invalid Password"
```

```Gherkin
Scenario: Signing in
    Given I have an account already registered
    And I have not selected my favourite types of events
    And I am on the login page
    When I input the correct email address
    And I input the correct password
    And I click the sign in button
    Then I should be authenticated
    And I should be redirected to the home page
    And I should be presented with all types of events
    
```
 ```Gherkin
Scenario: Signing in
    Given I dont have an account already registered
    And I have selected my favourite types of events
    And I am on the login page
    When I input the correct email address
    And I input the correct password
    And I click the sign in button
    Then I should get an error message "Invalid Password"
```
 ```Gherkin
Scenario: Signing in
    Given I have an account already registered
    And I have selected my favourite types of events
    And I am on the login page
    When I input the incorrect email address
    And I input the correct password
    And I click the sign in button
    Then I should get an error message "Invalid Password"
```

 ```Gherkin
Scenario: Signing in
    Given I have an account already registered
    And I have selected my favourite types of events
    And I am on the login page
    When I input the correct email address
    And I input the incorrect password
    And I click the sign in button
    Then I should get an error message "Invalid Password"
```




 
 #### Value and effort
* Value: Must have
* Effort: 3

 ### Story #3
 As a user I want to be able to see my profile so that I can view my events and my current information.

 #### User interface mock-up
 Profile View
![image0](https://user-images.githubusercontent.com/94714591/224499829-490ae67a-17f2-4fe0-8fa6-2e803f0613eb.jpeg)


 #### Acceptance tests
  ```Gherkin
Scenario: Viewing profile
    Given I have an account already signed in
    When I click on the profile page button
    Then I should be able to see my up number
    And I should be able to see my selected photo
    And I should be able to see my university
    And I should be able to see the events that i'm applied to
```
 
 #### Value and effort
* Value: Should have
* Effort: 8

 ### Story #4
 As a user I want to be able to register my account so that I can login.

 #### User interface mock-up
 Register View
![RegisterView](https://user-images.githubusercontent.com/93602635/223664809-b444da98-a18f-45b6-94d5-1498066cf702.jpeg)
Login View
![LoginView](https://user-images.githubusercontent.com/93602635/223664615-192fd868-9b50-4756-8e73-45df61c0de64.PNG)

 #### Acceptance tests
   ```Gherkin
Scenario: Registering
    Given I don't have an account already
    And I am on the register page
    When I input a valid username
    And I input a valid email address
    And I input a valid password
    And I input a valid university
    Then My account should be stored in the database for later use
    And I should be logged in
    And I should be redirected to the home page
```

  ```Gherkin
Scenario: Registering
    Given I don't have an account already
    And I am on the register page
    When I input a invalid username
    And I input a valid email address
    And I input a valid password
    And I input a valid university
    Then I should get an error message "Username not valid"
    And I should not be logged in
```

  ```Gherkin
Scenario: Registering
    Given I don't have an account already
    And I am on the register page
    When I input a valid username
    And I input a invalid email address
    And I input a valid password
    And I input a valid university
    Then I should get an error message "Email Address not valid"
    And I should  not be logged in
```

  ```Gherkin
Scenario: Registering
    Given I don't have an account already
    And I am on the register page
    When I input a valid username
    And I input a valid email address
    And I input a invalid password
    And I input a valid university
    Then I should get an error message "Password not valid"
    And I should  not be logged in
```

  ```Gherkin
Scenario: Registering
    Given I don't have an account already
    And I am on the register page
    When I input a valid username
    And I input a valid email address
    And I input a valid password
    And I input a invalid university
    Then I should get an error message "University not valid"
    And I should  not be logged in
```

 
 #### Value and effort
* Value: Must have
* Effort: 3

 ### Story #5
  As a logged user I can add events to my favorites so that I can get notified when they start.

 #### User interface mock-up
Feed View
![FeedView1](https://user-images.githubusercontent.com/94714591/224497156-9fcf923a-9d3b-452a-8374-dbc26fdfaf91.jpeg)
 Profile View
![image0](https://user-images.githubusercontent.com/94714591/224499829-490ae67a-17f2-4fe0-8fa6-2e803f0613eb.jpeg)

 #### Acceptance tests
```Gherkin
Scenario: Adding events to favorites
    Given I have an account already signed in
    And I am in the home page
    When I click on the button to add an event to favourites
    Then I should have an event added to my account
    And I should receive a notification on the day of the event
    And the + button should turn into a checkmark
```
 
 #### Value and effort
* Value: Should have
* Effort: 8

 ### Story #6 
 As a user I want to be able to edit my profile so that I can update my current information or correct errors in it.

 #### User interface mock-up
 Profile View
![image0](https://user-images.githubusercontent.com/94714591/224499829-490ae67a-17f2-4fe0-8fa6-2e803f0613eb.jpeg)

 #### Acceptance tests
```Gherkin
Scenario: Editing profile
    Given I have an account already signed in
    And I am on the profile page
    When I click on the 3 dots button
    And I click on the "Edit" button
    And I input a new name on the "New Name" text box
    And I click the "Submit button"
    Then my name should be changed to the name I inserted
```

```Gherkin
Scenario: Editing profile
    Given I have an account already signed in
    And I am on the profile page
    When I click on the 3 dots button
    And I click on the "Edit" button
    And I input an empty name on the "New Name" text box
    And I click the "Submit button"
    Then I should get an error message "Username not valid"
```
 
 #### Value and effort
* Value: Shoud have
* Effort: 5
 
 ### Story #7
 As a user I can filter events so that I can view them.
 
 #### User interface mock-up!
 Filter View ![FilterView](https://user-images.githubusercontent.com/94714591/224501985-3dff7104-127d-4c07-9a42-fe6f96d25198.jpeg)


 
 #### Acceptance tests
 ```Gherkin
Scenario: Event filtering
    Given I am in the home page
    When I click on the 3 bars button
    And I click on one of the filtering options
    Then the event that appear on the home page should be filtered by the option I chose
```
 
 #### Value and effort
* Value: Must have
* Effort: 8
 
 ### Story #8
As a user I can create events so that my friends can subscribe to.

#### User interface mock-up
 Profile View
![image0](https://user-images.githubusercontent.com/94714591/224499829-490ae67a-17f2-4fe0-8fa6-2e803f0613eb.jpeg)

#### Acceptance tests
 ```Gherkin
Scenario: Event creation
    Given I am on the profile page
    And I have an account already signed in
    When I click on the + button
    And I input the required information about an event
    And I click the "Submit" button
    Then the event I created should be added to the database
    And the event should be able to be viewed by other users
```

#### Value and effort
* Value: Must have
* Effort: 5

### Story #9
As a user I want to be able to see all the posts I created so that I can remember which posts I have introduced to the app.

#### User interface mock-up
![image0 2](https://user-images.githubusercontent.com/94714591/224503239-b9e36a77-3698-42e6-b5c5-656ef5ce8f2a.jpeg)

#### Acceptance tests
 ```Gherkin
Scenario: Event viewing
    Given I am on the profile page
    And I have an account already signed in
    When I click on the 3 dots button
    And I click on the "My Events" button
    Then I should be able to see all the events I created
```
#### Value and effort
* Value: Should have
* Effort: 8

### Domain model
![domain_model](https://user-images.githubusercontent.com/91210939/226856008-a37e0b32-f2d3-4710-92f3-773acdbb46ff.png)