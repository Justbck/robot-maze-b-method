//Justyna Bucko
//w1692858
//Reasoning about programs coursework
//Robot maze


MACHINE
    Robot

INCLUDES
    Maze
    
PROMOTES
    foundExit, hasVisitedSquare, robotsRoute
    
SETS
    DIRECTIONS = {North, South, West, East};
    SHOW_MESSAGE = {
        Move, 
        InternalWall, 
        ExternalWall, 
        Teleport,
        CannotTeleportToExitOnEntrance,
        CannotTeleportToExternalWalls
    }
    
VARIABLES
    visitedDirection, visitedPath,
    xPos, yPos
        
INVARIANT
    
    visitedDirection: seq(DIRECTIONS) &
    visitedPath: seq(INTEGER * INTEGER) &
    xPos: NATURAL1 &
    xPos: xAxis &
    yPos:NATURAL1 &
    yPos: yAxis
    
INITIALISATION
    
    visitedDirection := [] ||
    visitedPath := [] ||
    xPos := 1 ||
    yPos := 1

OPERATIONS

//Move Robot to North 

   message  <-- moveNorth  =
   
    IF
        ((xPos|-> yPos  + 1 ) /: Walls & 
        (yPos + 1 : yAxis))
THEN
        //change the y position according to direction
        yPos := yPos + 1 ||
        visitedDirection := visitedDirection <- North ||
        visitedPath := visitedPath <- (xPos |-> yPos) ||
        updateAll(xPos, yPos +1, visitedPath <- (xPos  |-> yPos)) ||
        message := Move
    ELSIF
        //if yPos + 1 is outside the maze
        (yPos +1 /:  yAxis)
	      THEN 
	          //yPos hits the external Wall
	          message := ExternalWall
	 ELSE 
	     //yPos hits the internal Wall
	     message := InternalWall
    END;

//Move Robot to South 

   message  <-- moveSouth  =
    IF
        ((xPos |-> yPos -1) /: Walls & 
        (yPos - 1 :  yAxis))
THEN
        //change the y position according to direction
        yPos := yPos - 1 ||
        visitedDirection := visitedDirection <- South ||
        visitedPath := visitedPath <- (xPos |-> yPos) ||
        updateAll(xPos, yPos -1, visitedPath <- (xPos  |-> yPos)) ||
        message := Move
    ELSIF
        //if yPos - 1 is outside the maze
        (yPos - 1 /:  yAxis)
	      THEN 
	          //yPos hits the external Wall
	          message := ExternalWall
	 ELSE 
	     //yPos hits the internal Wall
	     message := InternalWall
    END;

//Move Robot to West 

   message  <-- moveWest  =
    IF
        ((xPos  - 1 |-> yPos) /: Walls & 
        (xPos - 1 : xAxis))
THEN
        //change the x position according to direction
        xPos := xPos - 1 ||
        visitedDirection := visitedDirection <- West ||
        visitedPath := visitedPath <- (xPos |-> yPos) ||
        updateAll(xPos - 1, yPos, visitedPath <- (xPos  |-> yPos)) ||
        message := Move
    ELSIF
         //if xPos - 1 is outside the maze
        (xPos - 1 /: xAxis)
	      THEN 
	          //xPos hits the external Wall
	          message := ExternalWall
	 ELSE 
	    //xPos hits the internal Wall
	     message := InternalWall
    END;
    
    
//Move Robot to East 

   message  <-- moveEast  =
    IF
        ((xPos +1  |-> yPos) /: Walls & 
        (xPos + 1 : xAxis))
THEN
        //change the x position according to direction
        xPos := xPos + 1 ||
        visitedDirection := visitedDirection <- East ||
        visitedPath := visitedPath <- (xPos  |-> yPos) ||
        updateAll(xPos + 1, yPos, visitedPath <- (xPos  |-> yPos)) ||
        message := Move
    ELSIF
        //if xPos + 1 is outside the maze
        (xPos + 1 /:  xAxis)
	      THEN 
	          //xPos hits the external Wall
	          message := ExternalWall
	 ELSE 
	     //xPos hits the internal Wall
	     message := InternalWall
    END;
    
    
//Get the current position of the robot


   currentPosition  <-- getPosition  =
   BEGIN 
       currentPosition := (xPos, yPos)
   END;




//teleport Robot



   //teleport robot to specific square
   teleportMessage  <-- teleport(xPoint, yPoint)  =
   PRE
       xPoint : xAxis &
       yPoint : yAxis 
   THEN
       IF
           ((xPoint |-> yPoint) /: Walls &
            ((xPoint |-> yPoint) /: Exit or
            (xPos |-> yPos) /: Entry))
       THEN
           //change robot's position
           xPos := xPoint ||
           yPos := yPoint ||
           teleportMessage := Teleport ||
		     visitedPath := visitedPath <- (xPos |-> yPos) ||
		     updateAll(xPoint, yPoint, visitedPath <- (xPos  |-> yPos))
       ELSE IF
               //if the point hits the wall - 'black filled square'
               ((xPoint |-> yPoint) : Walls)
           THEN
               teleportMessage := CannotTeleportToExternalWalls
       ELSE
            //teleportation from the entry square is not possible
            teleportMessage := CannotTeleportToExitOnEntrance
    
           END
       END
   END
   
END
