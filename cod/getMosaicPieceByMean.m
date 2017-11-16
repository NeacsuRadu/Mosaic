function index = getMosaicPieceByMean(params, imgMean, upperPieceIndex, leftPieceIndex)
    index = 0;
    minMean = 3 * 255 * 255;
    for idx = 1 : length(params.colorMeans)
        currentMean = 0;
        if params.colorCh == 3
            currentMean = (imgMean(1) -params.colorMeans(1, 1, idx))^2 + (imgMean(2) -params.colorMeans(1, 2, idx))^2 + (imgMean(3) -params.colorMeans(1, 3, idx))^2;
        else 
            currentMean = (imgMean(1) - params.colorMeans(1, 1, idx))^2;
        end
        if (currentMean < minMean) && (idx ~= upperPieceIndex) && (idx ~= leftPieceIndex)    
            minMean = currentMean;
            index = idx;
        end
    end

end 

