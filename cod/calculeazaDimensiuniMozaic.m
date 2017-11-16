function params = calculeazaDimensiuniMozaic(params)
%calculeaza dimensiunile mozaicului
%obtine si imaginea de referinta redimensionata avand aceleasi dimensiuni
%ca mozaicul

%completati codul Matlab
[height width col] = size(params.imgReferinta);

if params.hexagonalPieces == 0
    params.width = params.widthPiesaMozaic * params.numarPieseMozaicOrizontala;
    params.numarPieseMozaicVerticala = round((params.width * height)/ (width * params.heightPiesaMozaic));
    params.height = params.numarPieseMozaicVerticala * params.heightPiesaMozaic;

else 
    params.width = 40 * params.numarPieseMozaicOrizontala + 14 * (params.numarPieseMozaicOrizontala - 1) - 26;
    params.numarPieseMozaicVerticala = round(((params.width * height)/ (width * 14)));
    if mod(params.numarPieseMozaicVerticala, 2) == 0
        params.numarPieseMozaicVerticala = params.numarPieseMozaicVerticala + 1;
    end
    params.height = (params.numarPieseMozaicVerticala - 1) * 14;
end

params.imgReferintaRedimensionata = imresize(params.imgReferinta, [params.height, params.width]);

end