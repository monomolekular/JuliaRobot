using HorizonSideRobots

function inverse(side::HorizonSide)
    invSide = side == Nord ? Sud : side == Ost ? West : side == Sud ? Nord : Ost;
    return invSide
end

function countSteps!(r::Robot,side)
    counter=0
    while !isborder(r,side)
        move!(r,side)
        counter+=1
    end
    return counter
end

function chess!(r::Robot,side = Ost, i = 0)
    while !(isborder(r,Nord) && isborder(r,West)) || !(isborder(r,Nord) && isborder(r,Ost))
        if (i%2==0)
            putmarker!(r)
        end
        if !isborder(r,side)
         move!(r,side)
        end
        i+=1
        if isborder(r,side)
            if isborder(r,Nord)
                return true
            end
            side = inverse(side)
            if !isborder(r,Nord)
                move!(r,Nord)
                i+=1
            end
        end
        return chess!(r,side,i)
    end
    return true
end

function main()
    r = Robot(10,10;animate=true)
    x = countSteps!(r,West)
    y = countSteps!(r,Sud)
    chess!(r,Ost,(x+y)%2)
    sleep(100)
end

main()