using HorizonSideRobots

function snailFind!(r::Robot)
    step = 1
    sides = [Nord,Ost,Sud,West]
    sideIndex = 1
    while !ismarker(r)
        for i in range(0,step-1)
            move!(r,sides[sideIndex])
            if ismarker(r)
                return true
            end
        end
        if (sideIndex < 4)
            sideIndex += 1
        else
            sideIndex = 1
        end
        for i in range(0,step-1)
            move!(r,sides[sideIndex])
            if ismarker(r)
                return true
            end
        end
        if (sideIndex < 4)
            sideIndex += 1
        else
            sideIndex = 1
        end
        step+=1
    end
    return true
end

function main()
    r = Robot("map8.sit",animate = true)
    snailFind!(r)
    sleep(100)
end

main()