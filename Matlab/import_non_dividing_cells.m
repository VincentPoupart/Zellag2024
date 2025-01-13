folder = uigetdir;
fileList = getAllFiles(folder);
Celloutputnondiv = cell(1,length(fileList));
for i = 1:1:length(fileList)
    num = csvread(fileList{i,1},1,0);
    file = fileList{i,1}; 
    mm = strfind(file, '\'); 
    mn = strfind(file, '.csv');
    gonad = file(1, (mm(1,length(mm))+1):mn(1,1)-1);
    for j = 1:1:length(num(:,1))
    Celloutputnondiv{i,j}.gonad = gonad;
    Celloutputnondiv{i,j}.cell = ['Cell_' num2str(num(j,1))];
    Celloutputnondiv{i,j}.meas(1,1) = num(j,6);
    Celloutputnondiv{i,j}.meas(1,2) = num(j,2);
    Celloutputnondiv{i,j}.meas(1,3) = num(j,3);
    Celloutputnondiv{i,j}.meas(1,4) = (num(j,5))/2;
    end
end
Celloutputnondiv = cat(1, Celloutputnondiv{:});
[~,index] = sortrows({Celloutputnondiv.gonad}.'); Celloutputnondiv = Celloutputnondiv(index); clear index

for i = 1:1:length(Celloutputnondiv)
 Celloutputnondiv(i).scoring(1,1:3) = [NaN 1 NaN];
 end