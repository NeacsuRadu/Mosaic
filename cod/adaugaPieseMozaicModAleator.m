function imgMosaic = adaugaPieseMozaicModAleator(params)

    [h,w,c] = size(params.imgReferintaRedimensionata);
    
    filt = zeros(81, 81, params.colorCh);
    filt(41, 41, 1:params.colorCh) = 1;
    imgRefBordered = imfilter(params.imgReferintaRedimensionata, filt, 'replicate', 'full');
    imgRefBordered(41 : 41 + h - 1, 41 : 41 + w - 1, 1 : params.colorCh) = params.imgReferintaRedimensionata(:, :, 1 : params.colorCh);

    imgMosaicBordered = uint8(zeros(80 + h, 80 + w, params.colorCh));

    freePixels = randperm(h * w);

    len = length(freePixels);
    for idx = 1 : len
        pixelColumn = ceil(freePixels(idx) / h) + 40;
        pixelLine = mod(freePixels(idx), h);
        if pixelLine == 0
            pixelLine =  h;
        end
        pixelLine = pixelLine + 40;

        if params.colorCh == 3 
            if imgMosaicBordered(pixelLine, pixelColumn, 1) == 0  && imgMosaicBordered(pixelLine, pixelColumn, 2) == 0 && imgMosaicBordered(pixelLine, pixelColumn, 3) == 0
                colorMean = computeColorMean(params, imgRefBordered(pixelLine : pixelLine + 27, pixelColumn : pixelColumn + 39, :));
                indexMosaicPiece = getMosaicPieceByMean(params, colorMean, -1, -1);

                imgMosaicBordered(pixelLine : pixelLine + 27, pixelColumn : pixelColumn + 39, :) = params.pieseMozaic(:, :, :, indexMosaicPiece);
            end
        else 
            if imgMosaicBordered(pixelLine, pixelColumn) == 0 
                colorMean = computeColorMean(params, imgRefBordered(pixelLine : pixelLine + 27, pixelColumn : pixelColumn + 39, :));
                indexMosaicPiece = getMosaicPieceByMean(params, colorMean, -1, -1);

                imgMosaicBordered(pixelLine : pixelLine + 27, pixelColumn : pixelColumn + 39, :) = rgb2gray(params.pieseMozaic(:, :, :, indexMosaicPiece));
            end
        end
    end

    imgMosaic = imgMosaicBordered(41 : 41 + h - 1, 41 : 41 + w - 1, 1 : params.colorCh);
end

