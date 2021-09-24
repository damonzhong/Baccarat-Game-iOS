# Baccarat-Game-iOS
Simple single page Baccarat game created with MVC design archiecture

# Version of XCode
XCode Version 11.1

# Simulator:
iPhone 11 Pro Max 

## MVC: 
  -  The baccarat table along with the chips in the window count as the view
  -  Placing chips on the bet sections triggers the controller 
  ![Baccarat_View](https://user-images.githubusercontent.com/70302984/134600428-b5bb0109-5eb7-4deb-b771-264ef7a56f24.png)
  ![Baccarct_control_1](https://user-images.githubusercontent.com/70302984/134600487-7d35bd56-c1d3-454f-b014-52b53df036ac.png)    

  -  The betting table is the model which updates the controller
  ![Baccarat_control_2](https://user-images.githubusercontent.com/70302984/134600523-3d8e94a2-e674-47c1-a840-d1ebfa43f9b7.png)  

  -  The controller in this project is the "Baccarat Dealer" that handles distributing and deducting bet amounts for the user

## Game functions:
  - To place a bet, tap/click hold the chip image then drag and drop onto a bet container 
  - To clear the bets in the container, press "CLEAR"
  - To start the game press "START" button
  
  ![chip_pan_gesture](https://user-images.githubusercontent.com/70302984/134261447-91ec429f-e66e-4db3-b24e-4ae9d8e29000.gif)
 
## Specific features:
  - the purpose was to have the betting feel close to real life
  - It was important to me to have the drag and drop feature to imitate the feeling on placing bets with chips
  - This was acomplished through the use of pan gestures
  
  ![chip_pan_gesture](https://user-images.githubusercontent.com/70302984/134261805-3e55c368-88fd-400c-810a-32b3046045b2.gif)
  
## Future Improvements to the game:
  - Features to add is chart as a container view at the top horizontally that displays and keeps track of winners from each round
  - Also, adding another view to display the chart in full
  - Other UI features to add are displaying each chip added for the bet container 
  - Some UX, A notification for when the round is over the winner - More betting options: bet all, Panda and Dragon
  - Home screen UI 
  - Database to store user information
  
  
