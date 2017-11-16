function imgMozaic = adaugaPieseMozaicPeCaroiaj(params)
%
%tratati si cazul in care imaginea de referinta este gri (are numai un canal)


[H,W,C,N] = size(params.pieseMozaic);
[h,w,c] = size(params.imgReferintaRedimensionata);

hexaTemplate = getHexMatrix();

if params.hexagonalPieces == 1 
    filt = zeros(81, 81, params.colorCh);
    filt(41, 41, 1:params.colorCh) = 1;
    imgRefBordered = imfilter(params.imgReferintaRedimensionata, filt, 'replicate', 'full');
    imgRefBordered(41 : 41 + h - 1, 41 : 41 + w - 1, 1 : params.colorCh) = params.imgReferintaRedimensionata(:, :, 1 : params.colorCh);
    imgMosaicBordered = uint8(zeros(80 + h, 80 + w, params.colorCh));
else 
    imgMozaic = uint8(zeros(size(params.imgReferintaRedimensionata)));
end

switch(params.criteriu)
    case 'aleator'
        imgMozaic = uint8(zeros(size(params.imgReferintaRedimensionata)));
        %pune o piese aleatoare in mozaic, nu tine cont de nimic
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        nrPieseAdaugate = 0;
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                %alege un indice aleator din cele N
                indice = randi(N);    
                imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,indice);
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
    case 'distantaCuloareMedie'
        %completati codul Matlab
        for line = 1:params.numarPieseMozaicVerticala
            for column = 1:params.numarPieseMozaicOrizontala
                if params.hexagonalPieces == 0
                    colorMean = computeColorMean(params, params.imgReferintaRedimensionata((line - 1) * H + 1 : line * H, (column - 1) * W + 1 : column * W, :));

                    upperPieceIndex = -1;
                    leftPieceIndex = -1;
                    if params.pieseAdiacenteDiferite 
                        if line > 1
                            upperPieceIndex = params.indexMatrix(1, column);
                        end

                        if column > 1
                            leftPieceIndex = params.indexMatrix(1, column - 1);
                        end
                    end

                    index = getMosaicPieceByMean(params, colorMean, upperPieceIndex, leftPieceIndex);
                    if params.colorCh == 3
                        imgMozaic((line - 1) * H + 1 : line * H, (column - 1) * W + 1 : column * W, :) = params.pieseMozaic(:, :, :, index);
                    else 
                        imgMozaic((line - 1) * H + 1 : line * H, (column - 1) * W + 1 : column * W, :) = rgb2gray(params.pieseMozaic(:, :, :, index));
                    end

                    if params.pieseAdiacenteDiferite
                        params.indexMatrix(1, column) = index;
                    end
                else 
                    idxLine = 0;
                    idxColumn = 0;
                    if mod(line, 2) == 1
                        idxLine = 14 * (line - 2) + 40;
                        idxColumn = 54 * (column - 1) - 13 + 40 + 1;
                    else 
                        idxLine = 14 * (line - 2) + 40;
                        idxColumn = 54 * (column - 1) + 15 + 40 ; 
                    end

                    colorMean = computeColorMean(params, imgRefBordered(idxLine : idxLine + 27, idxColumn : idxColumn + 39, :));
                    index = getMosaicPieceByMean(params, colorMean, -1, -1);    
                    mosaicPiece = params.pieseMozaic(:, :, :, index);
                    finalMosaicPiece = mosaicPiece .* hexaTemplate;

                    if params.colorCh == 3
                        imgMosaicBordered(idxLine : idxLine + 27, idxColumn : idxColumn + 39, :) = imgMosaicBordered(idxLine : idxLine + 27, idxColumn : idxColumn + 39, :) + finalMosaicPiece(:,:,:);
                    else 
                        imgMosaicBordered(idxLine : idxLine + 27, idxColumn : idxColumn + 39, :) = imgMosaicBordered(idxLine : idxLine + 27, idxColumn : idxColumn + 39, :) + rgb2gray(finalMosaicPiece(:,:,:));
                    end

                end
            end
        end

        if params.hexagonalPieces == 1
            imgMozaic = imgMosaicBordered(41 : 41 + h - 1, 41 : 41 + w - 1, 1 : params.colorCh);

    end       
    otherwise
        printf('EROARE, optiune necunoscuta \n');
    
end
    
    
    
    
    
