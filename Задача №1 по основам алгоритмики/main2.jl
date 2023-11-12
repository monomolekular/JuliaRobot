using HorizonSideRobots

function inverse(side::HorizonSide)
    invSide = side == Nord ? Sud : side == Ost ? West : side == Sud ? Nord : Ost;
    return invSide
end


function main()
    r = Robot(15,15,animate=true)
    sleep(1000)
end

main()