#  Generate a rubik's cube and allow you to solve it
#
#  Menu:
#  N)ew Cube to make a solved cube
#  M)ix it up to make it solvable
#  S)olve to go into a loop where we try to fix
#  ?)swill determine the solution for you

#install.packages("rcube")
library("rcube")
# the following is for 3d
#require(magrittr)

#define some functions to be used
choosekey<-function() {
  input<-toupper(substr(readline(prompt="Choose? "),1,1))
  input
}

#choose input from valid twists
# currently no error checking.  Multiple moves is OK
choosetwist<-function() {
  input<-readline(prompt="Choose? ")
  input
}

# show the menu of choices
menu<-function() {
    # clear the screen
    cat("\014")  
    print("<X>-exit")
    print("<N>ew cube")
    print("<M>ix up cube")
#    print("<P>lay with the cube")
    print("<S>olve the cube")
    choosekey()
}

# interactive twisting of the cube by user
solve<-function(cube){
  # clear the screen
  cat("\014")  
  print("Good luck!")
  plot3dCube(cube)
  moves=NULL
# loop until solved
  repeat {
    ## get a single key for the twist command
    print("Moves are UDFBRL & udfbrl for reverse twist. X=exit")
    twist<-choosetwist()
    print(c("twist:", twist))
    moves<-paste(moves,twist,sep="")
    cube<-twistCube(cube, moves=twist, times=1)
    plot3dCube(cube)
  ## give the user a way to quit
    if (twist == "X") {
      break
    }
    
    if (is.solved(cube)) {
      print("Cube is solved! Hit <Enter> to return to main menu")
      print(c("moves:",moves))
      choosekey()
      break
    }
  }
  cube
}

# start with a solved cube
mycube<-createCube()
plot3dCube(mycube)

choice<-NULL
repeat{
  choice<-menu()
  
  if (choice == "N") {
      mycube<-createCube()
    }
  
  if (choice == "M") {
#      print("Let's mix this up!")
      mycube<-scramble(mycube)
  }
  
  if (choice == "S") {
      print("Good luck!, press return to begin")
      solve(mycube)
  }
  
  if (choice =="X")  {
      print("GoodBye!")
      break
  }
  # show the cube in 3d

  plot3dCube(mycube)
}
