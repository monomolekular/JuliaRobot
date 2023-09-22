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

function moveToLeftBotCorner!(r::Robot)
    moveToDeadEnd!(r,West)
    moveToDeadEnd!(r,Sud)
    moveToDeadEnd!(r,West)
end

function main()
    robot = Robot(10,10;animate=true)
    moveToLeftBotCorner!(robot)
    fillOuterPerimeter!(robot)
    sleep(100)
end


main()