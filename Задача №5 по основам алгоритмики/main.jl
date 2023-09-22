#https://github.com/Vibof/HorizonSideRobot.jl
using HorizonSideRobots

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
function fillInnerPerimeter!(r::Robot)
    moveToSideWithWallUp!(r,West)
    move!(r,Nord)
    moveToSideWithWallRight!(r,Nord)
    move!(r,Ost)
    moveToSideWithWallBottom!(r,Ost)
    move!(r,Sud)
    moveToSideWithWallLeft!(r,Sud)
    move!(r,West)
    moveToSideWithWallUp!(r,West)
    moveToDeadEnd!(r,Sud)
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
function findInnerRectangle(r::Robot,height::Int64)
    steps = 1
    while !isborder(r,Nord)
        move!(r,Nord)
        steps+=1
    end
    if steps == height
        moveToDeadEnd!(r,Sud)
        if !isborder(r,Ost) 
            move!(r,Ost)
            findInnerRectangle(r,height)
        else
            moveToDeadEnd!(r,West)
            return false
        end
    else
        return true
    end
end
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

function main()
    robot = Robot("Задача №5 по основам алгоритмики\\map.sit")
    height2, width2 = moveToLeftBotCorner!(robot)
    width, height = fillOuterPerimeter!(robot)
    move!(robot,Ost)
    condition = findInnerRectangle(robot,height)
    if condition 
        fillInnerPerimeter!(robot)
        moveToLeftBotCorner!(robot)
    end
    moveBySteps!(robot,Ost,width2)
    moveBySteps!(robot,Nord,height2)
    show!(robot)
    sleep(100)
end


main()