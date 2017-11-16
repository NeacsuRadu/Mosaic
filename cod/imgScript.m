
numeDirector = '../data/test/test/';

imgList = dir([numeDirector '*.png']);

for imgIdx = 1 : length(imgList)
	imgPath = [numeDirector imgList(imgIdx).name];
    img = imread(imgPath);

    if length(strfind(imgList(imgIdx).name, 'frog')) ~= 0
        imwrite(img,['../data/test/frog/' imgList(imgIdx).name]);
    end

    if length(strfind(imgList(imgIdx).name, 'horse')) ~= 0
        imwrite(img,['../data/test/horse/' imgList(imgIdx).name]);
    end

    if length(strfind(imgList(imgIdx).name, 'bird')) ~= 0
        imwrite(img,['../data/test/bird/' imgList(imgIdx).name]);
    end
end



