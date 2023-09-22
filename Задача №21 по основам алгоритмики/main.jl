using HorizonSideRobots

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)-2,4))



function main()
    r = Robot(10,10)
    show!(r)
    sleep(100)
end

main()