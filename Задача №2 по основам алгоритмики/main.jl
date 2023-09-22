#https://github.com/Vibof/HorizonSideRobot.jl
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

function moveToSideWithWallUp!(r::Robot,side)
    counter::Int64 = 1
    while !isborder(r,side) && isborder(r,Nord)
        putmarker!(r)
        move!(r,side)
        counter+=1
    end
    putmarker!(r)
    return counter
end
function moveToSideWithWallLeft!(r::Robot,side)
    counter::Int64 = 1
    while !isborder(r,side) && isborder(r,West)
        putmarker!(r)
        move!(r,side)
        counter+=1
    end
    putmarker!(r)
    return counter
end
function moveToSideWithWallRight!(r::Robot,side)
    counter::Int64 = 1
    while !isborder(r,side) && isborder(r,Ost)
        putmarker!(r)
        move!(r,side)
        counter+=1
    end
    putmarker!(r)
    return counter
end
function moveToSideWithWallBottom!(r::Robot,side)
    counter::Int64 = 1
    while !isborder(r,side) && isborder(r,Sud)
        putmarker!(r)
        move!(r,side)
        counter+=1
    end
    putmarker!(r)
    return counter
end
function moveToDeadEnd!(r::Robot,side)
    while !isborder(r,side)
        move!(r,side)
    end
end
function fillOuterPerimeter!(r::Robot)
    height = moveToSideWithWallLeft!(r,Nord)
    width = moveToSideWithWallUp!(r,Ost)
    moveToSideWithWallRight!(r,Sud)
    moveToSideWithWallBottom!(r,West)
    moveToDeadEnd!(r,Sud)
    return (width,height)
end

function moveToLeftBotCorner!(r::Robot)
    h1 = countSteps!(r,Sud)
    w1 = countSteps!(r,West)
    h2 = countSteps!(r,Sud)
    w2 = countSteps!(r,West)
    height = h1+h2
    width = h1+h2
    return height,width
end

function main()
    robot = Robot("Задача №2 по основам алгоритмики\\map.sit")
    height, width = moveToLeftBotCorner!(robot)
    fillOuterPerimeter!(robot)
    moveBySteps!(robot,Nord,height)
    moveBySteps!(robot,Ost,width)
    show!(robot)
    sleep(100)
end


main()