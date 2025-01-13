clear IndexTranslation
IndexTranslation(:,2) =  -6:0.25:6;
IndexTranslation(:,1) =  1:1:49;
folder = uigetdir;


for h = -6:0.25:6
    LenghtTranslation = h;
    D = num2str(h);
    waa = find ((IndexTranslation(:,2)) == LenghtTranslation);
    wii = IndexTranslation(waa,1);
    for i =  1:1:length(CellCenteroutput)
        
        foa1 = [CellCenteroutput(i).gonad,'_Disk_' CellCenteroutput(i).cell,'_length_',D,'.zip_channel_1.txt'];
        foa2 = [CellCenteroutput(i).gonad,'_Disk_' CellCenteroutput(i).cell,'_length_',D,'.zip_channel_2.txt'];
        
        fileNN1 = [folder,'/ProphaseNormal/',foa1];
        fileNN2 = [folder,'/ProphaseNormal/',foa2];
        
        fileNV1 = [folder,'/ProphaseVert/',foa1];
        fileNV2 = [folder,'/ProphaseVert/',foa2];
        
        fileNOG1 = [folder,'/ProphaseOrthoDP/',foa1];
        fileNOG2 = [folder,'/ProphaseOrthoDP/',foa2];
        
        CellCenteroutput(i).RawIntDen_normal_Ch1(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).RawIntDen_normal_Ch2(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).Area_normal_Ch1(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).Area_normal_Ch2(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).RawIntDen_lateral_Ch1(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).RawIntDen_lateral_Ch2(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).Area_lateral_Ch1(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).Area_lateral_Ch2(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).RawIntDen_vert_Ch1(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).RawIntDen_vert_Ch2(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).Area_vert_Ch1(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).Area_vert_Ch2(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).RawIntDen_orthoDP_Ch1(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).RawIntDen_orthoDP_Ch2(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).Area_orthoDP_Ch1(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        CellCenteroutput(i).Area_orthoDP_Ch2(:,wii)= nan(length(CellCenteroutput(i).meas(:,1)),1);
        if isfile(fileNN1)
            num = readmatrix(fileNN1);
            for ii = 1:1:length(num(:,1))
                foa = num(ii,2);
                ioa = find ((CellCenteroutput(i).meas(:,1))== foa);
                CellCenteroutput(i).RawIntDen_normal_Ch1(ioa,wii)= num(ii,3);
                CellCenteroutput(i).Area_normal_Ch1(ioa,wii)= num(ii,4);
            end
        end
        
        if isfile(fileNN2)
            num = readmatrix(fileNN2);
            for ii = 1:1:length(num(:,1))
                foa = num(ii,2);
                ioa = find ((CellCenteroutput(i).meas(:,1))== foa);
                CellCenteroutput(i).RawIntDen_normal_Ch2(ioa,wii)= num(ii,3);
                CellCenteroutput(i).Area_normal_Ch2(ioa,wii)= num(ii,4);
            end
        end
        
        if isfile(fileNV1)
            num = readmatrix(fileNV1);
            for ii = 1:1:length(num(:,1))
                foa = num(ii,2);
                ioa = find ((CellCenteroutput(i).meas(:,1))== foa);
                CellCenteroutput(i).RawIntDen_vert_Ch1(ioa,wii)= num(ii,3);
                CellCenteroutput(i).Area_vert_Ch1(ioa,wii)= num(ii,4);
            end
        end
        
        if isfile(fileNV2)
            num = readmatrix(fileNV2);
            for ii = 1:1:length(num(:,1))
                foa = num(ii,2);
                ioa = find ((CellCenteroutput(i).meas(:,1))== foa);
                CellCenteroutput(i).RawIntDen_vert_Ch2(ioa,wii)= num(ii,3);
                CellCenteroutput(i).Area_vert_Ch2(ioa,wii)= num(ii,4);
            end
        end
        if isfile(fileNOG1)
            num = readmatrix(fileNOG1);
            for ii = 1:1:length(num(:,1))
                foa = num(ii,2);
                ioa = find ((CellCenteroutput(i).meas(:,1))== foa);
                CellCenteroutput(i).RawIntDen_orthoDP_Ch1(ioa,wii)= num(ii,3);
                CellCenteroutput(i).Area_orthoDP_Ch1(ioa,wii)= num(ii,4);
            end
        end
        
        if isfile(fileNOG2)
            num = readmatrix(fileNOG2);
            for ii = 1:1:length(num(:,1))
                foa = num(ii,2);
                ioa = find ((CellCenteroutput(i).meas(:,1))== foa);
                CellCenteroutput(i).RawIntDen_orthoDP_Ch2(ioa,wii)= num(ii,3);
                CellCenteroutput(i).Area_orthoDP_Ch2(ioa,wii)= num(ii,4);
            end
        end
    end
end