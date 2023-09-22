using HorizonSideRobots

function countSteps!(robot::Robot,side)::Int64
    counter = 0
    while !isborder(robot,side)
        move!(robot,side)
        counter+=1
    end

    return counter
end

function moveBySteps!(robot::Robot,side,steps::Int64)::Nothing
    for i in range(1,steps)
        move!(robot,side)
    end
end

function goTillTheEnd!(robot::Robot,side)::Nothing
    while !isborder(robot,side)
        move!(robot,side)
    end
end

function paintMap!(robot::Robot,xStepsMade::Int64,yStepsMade::Int64,alreadyPainted=0::Int64,totalPaintedCells=Nothing,prevSide=Nothing)
    sideToGo = (prevSide == Nothing) ? Nord : (prevSide == Nord) ? Ost : (prevSide == Ost) ? Sud : prevSide == Sud ? West : Nord
    key:: Bool = prevSide in [West, Ost, Nothing]
    stepsToDo::Int64 = key ? yStepsMade : xStepsMade
    if totalPaintedCells == Nothing
        totalPaintedCells::Int64 = yStepsMade*xStepsMade
    end
    if totalPaintedCells-alreadyPainted > 1
        for i in range(1,stepsToDo-1)
            putmarker!(robot)
            alreadyPainted+=1
            move!(robot,sideToGo)
        end
        return (alreadyPainted - stepsToDo + 1) == 0 ? paintMap!(robot,xStepsMade,yStepsMade,alreadyPainted,totalPaintedCells,sideToGo) : key ? paintMap!(robot,xStepsMade,stepsToDo-1,alreadyPainted,totalPaintedCells,sideToGo) : paintMap!(robot,stepsToDo-1,yStepsMade,alreadyPainted,totalPaintedCells,sideToGo)
    else
        putmarker!(robot)
        goTillTheEnd!(robot,West)
        goTillTheEnd!(robot,Sud)
        return
    end
end

function main()
    r = Robot(20,20)
    stepsToTop = countSteps!(r,Nord)
    stepsToRight = countSteps!(r,Ost)
    width = countSteps!(r,West)+1
    heigh = countSteps!(r,Sud)+1
    stepsToBackX = width-1-stepsToRight
    stepsToBackY = heigh-1-stepsToTop
    paintMap!(r,width,heigh)
    moveBySteps!(r,Nord,stepsToBackY)
    moveBySteps!(r,Ost,stepsToBackX)
    show!(r)
    sleep(100)
end

main()