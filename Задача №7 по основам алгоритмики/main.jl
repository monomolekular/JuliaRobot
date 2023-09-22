using HorizonSideRobots


function findWalls(r::Robot)
    return (isborder(r,Nord),isborder(r,Ost),isborder(r,Sud),isborder(r,West))
end

function moveSteps!(r,side,steps)
    for i in range(1,steps)
        move!(r,side)
    end
end

function raskachka!(r::Robot,wSide,steps)
    side = wSide == Nord ? West : Nord
    print(side)
    backSide = side == West ? Ost : Sud
    moveSteps!(r,side,steps)
    if isborder(r,wSide)
        moveSteps!(r,backSide,steps*2)
    else
        moveSteps!(r,backSide,steps)
        return (true,side)
    end
    if isborder(r,wSide)
        moveSteps!(r,side,steps)
    else
        moveSteps!(r,side,steps)
        return (true,backSide)
    end
    return(false,Nothing)
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)-2,4))

function findHole!(r::Robot, side)
    walls = findWalls(r)
    if walls == (false,false,false,false)
        move!(r,side)
        return 0
    end
    stepsToDo = 0
    foundOrNot = false
    data = (Nothing,Nothing)
    while !foundOrNot
        stepsToDo+=1
        data = raskachka!(r,side,stepsToDo)
        foundOrNot = data[1]
    end
    moveSteps!(r,data[2],stepsToDo)
    move!(r,Nord)
    moveSteps!(r,inverse(data[2]),stepsToDo)
end

function main()
    robot = Robot("Задача №7 по основам алгоритмики\\map.sit";animate=true)
    findHole!(robot,Nord)
    sleep(101000)
end

main()