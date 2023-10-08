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

function moveTillDeadEnd!(r::Robot,side)
    while !isborder(r,side)
        move!(r,side)
    end
end

function find(array, elem)::Int
    for index in range(1,length(array))
        item = array[index]
        if item == elem
            return index
        end
    end
    return -1
end

function chess!(w,h,N::Int)
    map = []
    for y in range(0,h)
        for x in range(0,w)
            push!(map,(x,y,false))
        end
    end
    for y in range(0,h)
        for x in range(0,w)
            newX = x*N
            newY = y*N
            newX2 = x*N+N
            newY2 = y*N+N
            if x%2==0 && y%2==0
                for tempX in range(0,N-1)
                    for tempY in range(0,N-1)
                        tT = (newX+tempX,newY+tempY,false)
                        tT2 = (newX2+tempX,newY2+tempY,false)
                        index = find(map,tT)
                        index2 = find(map,tT2)
                        if index != -1
                            map[index] = (newX+tempX,newY+tempY,true)
                        end
                        if index2 != -1
                            map[index2] = (newX2+tempX,newY2+tempY,true)
                        end
                    end
                end
            end
        end
    end
    return map
end

function inverse(side::HorizonSide)
    invSide = side == Nord ? Sud : side == Ost ? West : side == Sud ? Nord : Ost;
    return invSide
end

function fill!(r::Robot,map)
    rX = 0
    rY = 0
    if ((rX,rY,true) in map)
        putmarker!(r)
    end
    side = Ost
    while !(isborder(r,Nord) && isborder(r,Ost))
        while !isborder(r,side)
            move!(r,side)
            rX+=1
            if ((rX,rY,true) in map)
                putmarker!(r)
            end
        end
        side = inverse(side)
        if (isborder(r,Nord))
            break
        end
        move!(r,Nord)
        rY+=1
        if ((rX,rY,true) in map)
            putmarker!(r)
        end
        while !isborder(r,side)
            move!(r,side)
            rX-=1
            if ((rX,rY,true) in map)
                putmarker!(r)
            end
        end
        side = inverse(side)
        if (isborder(r,Nord))
            break
        end
        move!(r,Nord)
        rY+=1
        if ((rX,rY,true) in map)
            putmarker!(r)
        end
    end
end

function main()
    r = Robot(64,64)
    moveTillDeadEnd!(r,Nord)
    moveTillDeadEnd!(r,Ost)
    x = countSteps!(r,West)
    y = countSteps!(r,Sud)
    map = chess!(x,y,8)
    fill!(r,map)
    show!(r)
    sleep(100)
end

main()