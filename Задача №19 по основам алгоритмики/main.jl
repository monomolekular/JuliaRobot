using HorizonSideRobots

function moveTillDeadEnd!(r::Robot,side)
    if !isborder(r,side)
        move!(r,side)
        return moveTillDeadEnd!(r,side)
    end
end

function main()
    r = Robot(10,10)
    moveTillDeadEnd!(r,Ost)
    show!(r)
    sleep(100)
end

main()