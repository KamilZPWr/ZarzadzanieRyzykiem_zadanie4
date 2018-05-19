function index = findIndexWhereValueCloseToX(column, x)
    for index=1:length(column)
        if column(index) <= x
            continue
        else
            break
        end
    end
end