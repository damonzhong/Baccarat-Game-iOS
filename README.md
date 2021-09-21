# Baccarat-Game-iOS
Simple single page Baccarat game created with MVC design archiecture

![chip_pan_gesture](https://user-images.githubusercontent.com/70302984/134259658-1cca3671-0044-4ba0-a211-c581ce406d7a.gif)






# Version of XCode
XCode Version 11.1

# Simulator:
iPhone 11 Pro Max 

## MVC: 
  -  The baccarat table as a whole is used as the view
  -  The betting table is the model which updates the controller
  -  The controller in this project is the "Baccarat Dealer" that handles distributing and deducting bet amounts for the user

## Game functions:
  - To place a bet, tap/click hold the chip image then drag and drop onto a bet container 
  - To clear the bets in the container, press "CLEAR"
  - To start the game press "START" button
  
## Specific features:
  - the purpose was to have the betting feel close to real life
  - It was important to me to have the drag and drop feature to imitate the feeling on placing bets with chips
  - This was acomplished through the use of pan gestures
  
## Diffculties along the way:
  I struggled in the beginning to implement my must have feature of drag and drop
  - I first tried dragging and dropping images which was not the function or feature for this project
  - That was more for dragging and dropping images onto a view, which might be what I need to implement some future improvements to my game
  - With the given amount of time I was not able to implement constraints for my views, which I feel terrible about
  - I really wanted to make sure the game logic was working correctly along with the betting system.
  - The drag and drop, and animations for the overall UI took a lot of time, especially when faced with bugs 
  
## Future Improvements to the game:
  - Features to add is chart as a container view at the top horizontally that displays and keeps track of winners from each round
  - Also, adding another view to display the chart in full
  - Other UI features to add are displaying each chip added for the bet container 
  - Some UX, A notification for when the round is over the winner - More betting options: bet all, Panda and Dragon
  - Home screen UI 
  - Database to store user information
  
  
