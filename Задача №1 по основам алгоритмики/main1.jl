using HorizonSideRobots

function inverse(side::HorizonSide)
    invSide = side == Nord ? Sud : side == Ost ? West : side == Sud ? Nord : Ost;
    return invSide
end

function paintTillWallThenGoBack!(r::Robot,side)
    counter = 0
    while !isborder(r,side)
        move!(r,side)
        counter+=1
        putmarker!(r)
    end
    while counter>0
        move!(r,inverse(side))
        counter-=1
    end
end

function main()
    r = Robot("map.sit")
    sides = [Nord,Ost,West,Sud]
    for s in sides
        paintTillWallThenGoBack!(r,s)
    end
    show!(r)
    sleep(100)
end

main()