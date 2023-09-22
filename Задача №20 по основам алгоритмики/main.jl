using HorizonSideRobots

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)-2,4))

function moveTillDeadEndAndPlaceMarkerAndGoBack!(r::Robot,side,deep=0)
    if !isborder(r,side)
        move!(r,side)
        return moveTillDeadEndAndPlaceMarkerAndGoBack!(r,side,deep)
    elseif deep==0
        putmarker!(r)
        return moveTillDeadEndAndPlaceMarkerAndGoBack!(r,inverse(side),1)
    end
end

function main()
    r = Robot(10,10)
    moveTillDeadEndAndPlaceMarkerAndGoBack!(r,Ost)
    show!(r)
    sleep(100)
end

main()