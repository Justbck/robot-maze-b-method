//Justyna Bucko
//w1692858
//Reasoning about programs coursework
//Robot maze



MACHINE
    Maze
    
SETS
    OUTPUT_MESSAGE = {Yes, No}

CONSTANTS

    Entry, Exit,xAxis,yAxis,Walls

PROPERTIES
    //creating the maze limited amount of squares
    xAxis <: NATURAL1 & xAxis = 1..7 &
    yAxis <: NATURAL1 & yAxis = 1..5 &
    
    //setting entry and exit squares
    Entry: NATURAL1 <-> NATURAL1 & Entry = {(1 |-> 1)} &
    Exit: NATURAL1 <-> NATURAL1 & Exit  = {(1 |-> 5)} & 
    
    //creating obstacles
    Walls: NATURAL1 <-> NATURAL1 &
    Walls = {(1 |-> 3), (2 |-> 1), (2 |-> 3), (2 |-> 5), (3 |-> 3), (4 |-> 2), (4 |-> 3), (4 |-> 4), (6 |-> 1), (6 |-> 2), (6 |-> 4), (7 |-> 4)}

VARIABLES

    xVisited, yVisited,visitedRoute

INVARIANT
    
    xVisited: NATURAL &
    yVisited: NATURAL &
    visitedRoute: seq(INTEGER * INTEGER)

INITIALISATION
    
    visitedRoute := [] ||
    xVisited := 0 ||
    yVisited := 0

OPERATIONS

//Update all

   updateAll(xAxiss, yAxiss, route)  =
   PRE
       xAxiss: NATURAL1 & yAxiss: NATURAL1 & route: seq(INTEGER * INTEGER)    
   THEN
       visitedRoute := route ||
       xVisited := xAxiss ||
       yVisited := yAxiss
   END;
   
//Check if the robot has reached the exit

   exitFound  <-- foundExit  =
   IF
       ((xVisited |-> yVisited) : Exit) 
   THEN
       exitFound := Yes
   ELSE
       exitFound := No
   END;

//Get the visited square position on the maze

   isVisited  <-- hasVisitedSquare(xPoint, yPoint)  =
   PRE    
       xPoint : xAxis &
       yPoint : yAxis
   THEN
       IF
           (xPoint |-> yPoint : ran(visitedRoute)) 
       THEN
           isVisited := Yes
       ELSE
           isVisited := No
       END
   END;

//Get the robot's route through the maze

   route  <-- robotsRoute  =
   BEGIN 
       route := visitedRoute
   END
   
END