using HorizonSideRobots

function countAndGoToLeftBotCorner!(r::Robot)
    width = 0
    height = 0
    while !(isborder(r,Sud) && isborder(r,West))
        if !isborder(r,Sud)
            move!(r,Sud)
            height += 1
        end
        if !isborder(r,West)
            move!(r,West)
            width+=1
        end
    end
    return (width,height)
end

function p1!(r::Robot)
    sides = [Nord,Ost,Sud,West]
    for s in sides
        while !isborder(r,s)
            move!(r,s)
            putmarker!(r)
        end
    end
end

function moveTillDeadEnd!(r::Robot,side)
    while !isborder(r,side)
        move!(r,side)
    end
end

function moveSteps!(r::Robot,side,steps)
    for i in range(0,steps-1)
        move!(r,side)
    end
end

function p2!(r::Robot,x,y)
    moveTillDeadEnd!(r,Ost)
    moveSteps!(r,Nord,y)
    putmarker!(r)
    moveTillDeadEnd!(r,Sud)
    moveTillDeadEnd!(r,West)
    moveSteps!(r,Ost,x)
    putmarker!(r)
    moveTillDeadEnd!(r,West)
    moveSteps!(r,Nord,y)
    putmarker!(r)
    moveTillDeadEnd!(r,Nord)
    moveSteps!(r,Ost,x)
    putmarker!(r)
    moveTillDeadEnd!(r,West)
    moveTillDeadEnd!(r,Sud)
end

function main()
    r = Robot("map6.sit",animate=true)
    x,y = countAndGoToLeftBotCorner!(r)
    p2!(r,x,y)
    sleep(100)
end

main()