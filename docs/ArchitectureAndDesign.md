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

- As a user want see all the events from university so that I can be informed.

Implementation: in the home page there's a button that takes the user to a page where they can view all the events from university.

- As a user I want to login in my account so that I can view my account.

Implementation: in the login page there are two text boxes that allow the user to sign in the application, one for your email and another for your password. There is also a button in case the user is not yet registered.

- As a user I want see my profile so that I can view my events and my current information.

Implementation: in the profile page it is possible to view my current events and my current information.

- As a user I want to register my account so that I can login.

Implementation: in the register page there are four text boxes, one for the user to write his name, another for his email, another for his password and yet another for the name of his university. In addition, there is also a button for the user to login if he has already registered.

- As a logged user I can add events to my favorites so that I can get notified when they start.

Implementation: in the feed page there's for each event a button in the form of a star that allows the user to add the events of his choice.

- As a user I want to be able to edit my profile so that I can update my current information or correct errors in it.

Implementation: in the profile page there's a button that allows the user to edit his profile.

- As a user I can filter events so that I can view.

Implementation: in the home page there's a section with several topics that allows the user to filter the events.

- As a user I can create events so that my friends can subscribe to.

Implementation: in the top right corner of the user page there is a button with a plus symbol that allows each registered user to create their own events.

- As a user I want to be able to see all the posts I created so that I can remember which posts I have introduced to the app.

Implementation: if the user clicks on the three dots that appear in the upper right corner of your profile page, a new page will appear with all your events created to date.
