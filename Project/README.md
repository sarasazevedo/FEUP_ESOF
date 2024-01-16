# Eventfully Development Report

Welcome to the documentation pages of the Eventfully!

You can find here detailed about Eventfully, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report , organized by discipline (as of RUP):

* Business modeling 
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-Pitch)
* Requirements
  * [Use Case Model]
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* Architecture and Design
  * [Logical architecture](#Logical-architecture)
  * [Physical architecture](#Physical-architecture)
  * [Vertical prototype](#Vertical-prototype)
* [Implementation]
* [Test]
* [Configuration and change management]
* [Project management](#Project-management)


So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us!

Thank you!

[Carlos Madaleno](https://github.com/up201604906)

[Lara Cunha](https://github.com/liac1983)

[Sara azevedo](https://github.com/sarasazevedo)

[Igor Andrade](https://github.com/IgorAndrade10)

[Nuno Antunes](https://github.com/nunoantunes10)


## Product Vision
An app to make it easier to keep up with university events, from workshops, speeches and job fairs to different competitions and social events.

## Elevator Pitch
With personal and business e-mails completely mixed up, and the sure feeling that It’s only going to get worse due to the mass adoption of digital technology in all areas of life and business, changing how we communicate.
It made me realise that I had Never understood how hard it was to search for a needle in a haystack, until I had to go through all of my correspondence in search of an event invite. 
So having an app to simplify keeping up with all of my favourite events and that provides information to both the user and the event organiser on the event’s details, that is not another calendar or scheduler, would come in handy.
That’s Eventfully, it keeps you up with life.

## Main Features
 - Feature 1 - View any type of university events.
 - Feature 2 - Create events.
 - Feature 3 - Sign up for events and get notified when they are starting.
 

## Extra Features
 - Feature 4 - Create your timetable with events you signed up for.
 - Feature 5 - Log in as a student or a organization.

## Assumptions and dependencies
- Student email from sigarra.

## Requirements

## User Stories
### Story #1
As a user I want to see all the events from a university so that I can be informed.

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
 As a user I want to login into my account so that I can view my account.

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
    When I input a valid email address
    And I input a valid password
    And I click the sign in button
    Then I should get an error message "Unregistered Account"
```
 ```Gherkin
Scenario: Signing in
    Given I have an account already registered
    And I have selected my favourite types of events
    And I am on the login page
    When I input the incorrect email address
    And I input the correct password
    And I click the sign in button
    Then I should get an error message "Invalid Credentials"
```

 ```Gherkin
Scenario: Signing in
    Given I have an account already registered
    And I have selected my favourite types of events
    And I am on the login page
    When I input the correct email address
    And I input the incorrect password
    And I click the sign in button
    Then I should get an error message "Invalid Credentials"
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
    And I should be able to see the events that I applied to
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
    And I should be redirected to the profile page
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
  As a logged user I can add events to my favorites so that I can be notified when they start.

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
    Then I should have an event added to my account's favourites
    And the + button should turn into a checkmark
    And I should receive a notification on the day of the event
    
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
 As a user I want to filter events so that I can view them.
 
 #### User interface mock-up!
 Filter View ![FilterView](https://user-images.githubusercontent.com/94714591/224501985-3dff7104-127d-4c07-9a42-fe6f96d25198.jpeg)


 
 #### Acceptance tests
 ```Gherkin
Scenario: Event filtering
    Given I am in the home page
    When I click on the 3 bars button
    And I click on one of the filtering options
    Then the events that appear on the home page should be filtered by the option I chose
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

## Architecture and Design
In this section we will describe the logical and physical architectures of our project.

### Logical architecture

The system components (and their dependencies) needed to fulfill our application's needs.

- `authentication` : Module for user login and signup.

- `database` : Module to store user information using firestore database.

- `model` : Module to structure the database.

- `Pages` : Module for our application screens and their interaction with users.

- `services` : Module to establish communication between our application and the firestore data base. To upload and download saved images. 

- `widgets` : Module with widgets to style our application.

- `Components` : Some application components.

### Package diagram

![Diagrama sem nome drawio](https://user-images.githubusercontent.com/93602635/226955370-0c8ae20b-af41-48a2-b2c2-6d5a05226953.png)


### Physical architecture

The document representing the high-level structure of our software system is as follows.

![Captura de Ecrã (92)](https://user-images.githubusercontent.com/93602635/224853861-aa5a6dae-d699-40d1-b926-6aa92d5d9d3d.png)

In our application we implement two entities: the database server where we will store the users' information and the application itself, which interacts with the users. In our project we use Flutter technology (with Dart language) for Frontend and Firebase in backend.

### Vertical prototype
How our user stories were implemented:

- As a user I want to see all the events from a university so that I can be informed.

Implementation: in the home page there's a button that takes the user to a page where they can view all the events from a university.

- As a user I want to login in my account so that I can view my account.

Implementation: in the login page there are two text boxes that allow the user to sign in the application, one for your email and another for your password. There is also a button in case the user is not yet registered.

- As a user I want see my profile so that I can view my events and my current information.

Implementation: in the profile page it is possible to view my current events and my current information.

- As a user I want to register my account so that I can login.

Implementation: in the register page there are four text boxes, one for the user to write his username, another for his institutional email, another for his password and yet another for the name of his university. In addition, there is also a button for the user to login if he has already registered.

- As a logged user I can add events to my favorites so that I can get notified when they start.

Implementation: in the feed page there's a button for each event in the form of a star that allows the user to add the events of his choice.

- As a user I want to be able to edit my profile so that I can update my current information or correct errors in it.

Implementation: in the profile page there's a button that allows the user to edit his profile.

- As a user I can filter events by topic so that I can view more easily.

Implementation: in the home page there's a section with several topics that allows the user to filter the events.

- As a user I can create events so that my friends can subscribe to.

Implementation: in the top right corner of the user page there is a button with a plus symbol that allows each registered user to create their own events.

- As a user I want to be able to see all the posts I created so that I can remember which posts I have introduced to the app.

Implementation: if the user clicks on the three dots that appear in the upper right corner of your profile page, a new page will appear with all your events created to date.

## Project management

In order to facilitate the communication and organization of the project, we use [GitHub Projects](https://github.com/orgs/FEUP-LEIC-ES-2022-23/projects/78/views/1). 
This project has six columns: **New**, **Backlog**, **Ready**, **In progress**, **In review**, and **Done**, the column names are quite explicit. As soon as we finish a task, we move on to the next column and so on.

### Iteration 1
![Captura de Ecrã (100)](https://user-images.githubusercontent.com/93602635/231398930-72417489-fc09-4360-a138-dcf46a65e3c5.png)

### Did well
- We were able to make the login and sign up pages.
- We organized the project as intended in Github.

### Do Differently
- Improve the layout of the ReadMe file.

### Puzzles
- Connected to the Firebase.

### Iteration 2

<img width="1440" alt="Screenshot 2023-04-12 at 09 23 15" src="https://user-images.githubusercontent.com/91210939/231398199-a9decb13-9581-45d7-8e5b-09e6d538a55d.png">

### Did well
- We were able to make the profile page 

### Do Differently 
- The acceptance tests

### Puzzles
- Write Acceptance tests

![Captura de Ecrã (105)](https://user-images.githubusercontent.com/93602635/234514058-0f021801-cacd-475c-ab51-11d97791d011.png)

### Iteration 3

![Captura de Ecrã (106)](https://user-images.githubusercontent.com/93602635/234515902-eee4f941-838c-4224-86d6-d54e2f332a03.png)

### Did well
- We were able to see all the events from university and create new events

### Do Differently 
- The acceptance tests

### Puzzles
- Write  and test the Acceptance tests

![Captura de Ecrã (107)](https://user-images.githubusercontent.com/93602635/234517540-02dcb2c2-1fe0-48d4-8ca8-68b33549195e.png)

### Iteration 4

![Captura de Ecrã (114)](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC12T1/assets/93602635/dc3ccf07-5cbc-4592-9400-8621d43d4375)

### Did well
- We completed all the features we had committed to implementing

### Do Differently
- The acceptance tests

### Puzzles
- Write and test the acceptance tests

![image](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC12T1/assets/93602635/e0b52b84-ae1f-4aea-b6a5-856c718178c7)

