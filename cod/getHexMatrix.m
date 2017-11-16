function matrix = getHexMatrix()
    matrix = uint8(zeros(28, 40, 3));

    for it = 1 : 14
        matrix (it, 14 - it + 1 : 27 + it - 1, : ) = 1;
        matrix (28 - it + 1, 14 - it + 1 : 27 + it - 1, : ) = 1;        
    end 
end