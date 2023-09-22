using HorizonSideRobots

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function move_rungs!(r, side_first, side_second; mark_full = false, mark_cross=false, rev = false)
    # Двигает робота на одну клетку в две заданные стороны до упора 
    if mark_full putmarker!(r) end
    if mark_cross putmarker!(r) end
    k = 0
    c = 0
    while !isborder(r,side_first)
        move!(r, side_first)
        k +=1
        if mark_full putmarker!(r) end

        if !isborder(r,side_second)
            move!(r, side_second)
            c +=1
            if mark_full putmarker!(r) end
            if mark_cross putmarker!(r) end
        else break
        end
    end

    if rev && k==c
        for x in 1:c
            move!(r, inverse(side_second))
            move!(r, inverse(side_first))
        end
    elseif rev
        move!(r, inverse(side_first))
        for x in 1:c
            move!(r, inverse(side_second))
            move!(r, inverse(side_first))
        end
    end
end


function Cross_on_start()
    r = Robot(10,10;animate=true)
    
    for s_1 in (Nord, Sud)
        for s_2 in (West, Ost)
            move_rungs!(r, s_1, s_2; mark_full = false, mark_cross=true, rev = true)
        end
    end

    sleep(300) 
end

Cross_on_start()