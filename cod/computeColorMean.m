function colorMean = computeColorMean( params, image )
    if params.colorCh == 1 
        gray = image(:, :, 1);
        colorMean = [mean(gray(:)), 0, 0];
    else
        red = image(:, :, 1);
        green = image(:, :, 2);
        blue = image(:, :, 3);

        redMean = mean(red(:));
        greenMean = mean(green(:));
        blueMean = mean(blue(:));

        colorMean = [redMean, greenMean, blueMean];
    end
end

