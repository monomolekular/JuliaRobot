using HorizonSideRobots

function countSteps!(r,side)
    counter = 0
    while !isborder(r,side)
        counter+=1
        move!(r,side)
    end
end

function moveAlongWall!(r::Robot,side)
    while isborder(r,Nord) && !isborder(r,side)
        move!(r,side)
    end
end

invert(s::HorizonSide) = HorizonSide(mod(Int(s)-2,4))

#if (isborder(r,Nord) && isborder(r,side))
#    condition2 = false
#elseif (isborder(r,Nord))
#    condition2 = true
#end

function countWallsUp!(r)
    counter=0
    side = Ost
    condition = false
    condition2 = false
    while !condition
        while !isborder(r,side)
            while !isborder(r,Nord) && !isborder(r,side)
                move!(r,side)
            end
            while isborder(r,Nord) && !isborder(r,side)
                moveAlongWall!(r,side)
                if (isborder(r,Nord) && isborder(r,side))
                    condition2 = false
                else
                    condition2 = true
                end
                if isborder(r,side)
                    break
                end
                move!(r,side)
            end
            if condition2
                counter+=1
            end
            condition2 = false
        end
        if isborder(r,Nord)
            condition = true
            break
        end
        move!(r,Nord)
        side = invert(side)
    end
    return counter
end

function main()
    r = Robot("Задача №12 по основам алгоритмики\\map12.sit",animate=true)
    countSteps!(r,West)
    countSteps!(r,Sud)
    print(countWallsUp!(r))
    sleep(100)
end

main()