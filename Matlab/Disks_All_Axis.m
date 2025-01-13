folder = uigetdir;

mkdir(folder, 'normal');
mkdir(folder, 'spindle');
mkdir(folder, 'ortho');
mkdir(folder, 'vert');
mkdir(folder, 'NonDividingLateral');
mkdir(folder, 'NonDividingNormal');
mkdir(folder, 'NonDividingVert');
mkdir(folder, 'OrthoDP');
mkdir(folder, 'NonDividingOrthoDP');

% for i = 1:1:length(Celloutput)
%     if Celloutput(i).scoring(1,1) == -5000 || Celloutput(i).scoring(1,1) == 5000
%         Celloutput(i).scoring(1,1) = NaN;
%     end
%     if Celloutput(i).scoring(1,2) == -5000 || Celloutput(i).scoring(1,2) == 5000
%         Celloutput(i).scoring(1,2) = NaN;
%     end
%     if Celloutput(i).scoring(1,3) == -5000 || Celloutput(i).scoring(1,3) == 5000
%         Celloutput(i).scoring(1,3) = NaN;
%     end
%
% end
for i = 1:1:length(Celloutput)
    GermlinesAll{i,1} = Celloutput(i).gonad;
end
Germlines = unique(GermlinesAll);


for h = -6:0.25:6
    for i = 1:1:length(Celloutput)
        if ~isnan(Celloutput(i).meas)
            gonad = Celloutput(i).gonad;
            specific_gonad = matches(Germlines,gonad);
            specific_gonad=num2cell(specific_gonad);
            for op=1:1:length(specific_gonad)
                if isequal(specific_gonad{op,1},0)
                    specific_gonad{op,1}=[];
                end
            end
            ffoo = find(~cellfun('isempty', specific_gonad));
            
%             foa = Celloutput(i).scoring(1,2);
%             ioa = find ((Celloutput(i).meas(:,1))== foa);
%             if ~isnan(foa)
                
                N = cell(length(Celloutput(i).meas(:,1))+1,12);
                S = cell(length(Celloutput(i).meas(:,1))+1,12);
                OS = cell(length(Celloutput(i).meas(:,1))+1,12);
                V = cell(length(Celloutput(i).meas(:,1))+1,12);
                OG = cell(length(Celloutput(i).meas(:,1))+1,12);
                
                N{1,1}='Frames';
                N{1,2}='xcoord';
                N{1,3}='ycoord';
                N{1,4}='zcoord';
                N{1,5}='radius';
                N{1,6}='V1x';
                N{1,7}='V1y';
                N{1,8}='V1z';
                N{1,9}='V2x';
                N{1,10}='V2y';
                N{1,11}='V2z';
                N{1,12}='radius2';
                
                S{1,1}='Frames';
                S{1,2}='xcoord';
                S{1,3}='ycoord';
                S{1,4}='zcoord';
                S{1,5}='radius';
                S{1,6}='V1x';
                S{1,7}='V1y';
                S{1,8}='V1z';
                S{1,9}='V2x';
                S{1,10}='V2y';
                S{1,11}='V2z';
                S{1,12}='radius2';
                
                OS{1,1}='Frames';
                OS{1,2}='xcoord';
                OS{1,3}='ycoord';
                OS{1,4}='zcoord';
                OS{1,5}='radius';
                OS{1,6}='V1x';
                OS{1,7}='V1y';
                OS{1,8}='V1z';
                OS{1,9}='V2x';
                OS{1,10}='V2y';
                OS{1,11}='V2z';
                OS{1,12}='radius2';
                
                V{1,1}='Frames';
                V{1,2}='xcoord';
                V{1,3}='ycoord';
                V{1,4}='zcoord';
                V{1,5}='radius';
                V{1,6}='V1x';
                V{1,7}='V1y';
                V{1,8}='V1z';
                V{1,9}='V2x';
                V{1,10}='V2y';
                V{1,11}='V2z';
                V{1,12}='radius2';
                
                OG{1,1}='Frames';
                OG{1,2}='xcoord';
                OG{1,3}='ycoord';
                OG{1,4}='zcoord';
                OG{1,5}='radius';
                OG{1,6}='V1x';
                OG{1,7}='V1y';
                OG{1,8}='V1z';
                OG{1,9}='V2x';
                OG{1,10}='V2y';
                OG{1,11}='V2z';
                OG{1,12}='radius2';
                
                for j = 1:1:length(Celloutput(i).meas(:,1))
                    
                    frame = Celloutput(i).meas(j,1);
                    
                    N{j+1,1}= Celloutput(i).meas(j,1);
                    S{j+1,1}= Celloutput(i).meas(j,1);
                    OS{j+1,1}= Celloutput(i).meas(j,1);
                    V{j+1,1}= Celloutput(i).meas(j,1);
                    OG{j+1,1}= Celloutput(i).meas(j,1);
                    
                    SpinMid = Celloutput(i).meas(j,4:6);
                    SpinVect = (Celloutput(i).meas(j,7:9))/(norm(Celloutput(i).meas(j,7:9)));
                    NormalVect = (Celloutput(i).meas(j,14:16))/(norm(Celloutput(i).meas(j,14:16)));
                    OrthogonalVect = cross(SpinVect,NormalVect)/norm(cross(SpinVect,NormalVect));
                    DPVect = [Germlineoutput(ffoo).DPaxisVector(1,1);Germlineoutput(ffoo).DPaxisVector(1,2);Germlineoutput(ffoo).DPaxisVector(1,3)];
                    ortho1 =  cross(DPVect,NormalVect)/norm(cross(DPVect,NormalVect));
                    ortho2 =  cross(ortho1,NormalVect)/norm(cross(ortho1,NormalVect));
                    
                    lenghtNormalVect = sqrt((NormalVect(1,1)^2) + (NormalVect(1,2)^2) +  (NormalVect(1,3)^2));
                    lenghtSpindleVect = sqrt((SpinVect(1,1)^2) + (SpinVect(1,2)^2) +  (SpinVect(1,3)^2));
                    lenghtOrthoVect = sqrt((OrthogonalVect(1,1)^2) + (OrthogonalVect(1,2)^2) +  (OrthogonalVect(1,3)^2));
                    lenghtOrtho2 = sqrt((ortho2(1,1)^2) + (ortho2(1,2)^2) +  (ortho2(1,3)^2));
                    lenghtOrtho1 = sqrt((ortho1(1,1)^2) + (ortho1(1,2)^2) +  (ortho1(1,3)^2));
                    
                    LenghtTranslation = h;
                    
                    fnormal = LenghtTranslation/lenghtNormalVect;
                    fspindle = LenghtTranslation/lenghtSpindleVect;
                    fortho = LenghtTranslation/lenghtOrthoVect;
                    fortho2 = LenghtTranslation/lenghtOrtho2;
                    fortho1 = LenghtTranslation/lenghtOrtho1;
                    
                    TranslationVectN = NormalVect*fnormal;
                    TranslationVectS = SpinVect*fspindle;
                    TranslationVectO = OrthogonalVect*fortho;
                    TranslationVectO2 = ortho2*fortho2;
                    TranslationVectOG = ortho1*fortho1;
                    
                    fazelN = SpinMid + TranslationVectN;
                    fazelS = SpinMid + TranslationVectS;
                    fazelO = SpinMid + TranslationVectO;
                    fazelO2 = SpinMid + TranslationVectO2;
                    fazelOG = SpinMid + TranslationVectOG;
                    
                    N{j+1,2}= NaN;
                    N{j+1,3}= NaN;
                    N{j+1,4}= NaN;
                    N{j+1,5}= NaN;
                    N{j+1,6} = NaN;
                    N{j+1,7} = NaN;
                    N{j+1,8} = NaN;
                    N{j+1,9} = NaN;
                    N{j+1,10} = NaN;
                    N{j+1,11} = NaN;
                    N{j+1,12}= NaN;
                    
                    S{j+1,2}= NaN;
                    S{j+1,3}= NaN;
                    S{j+1,4}= NaN;
                    S{j+1,5}= NaN;
                    S{j+1,6} = NaN;
                    S{j+1,7} = NaN;
                    S{j+1,8} = NaN;
                    S{j+1,9} = NaN;
                    S{j+1,10} = NaN;
                    S{j+1,11} = NaN;
                    S{j+1,12}= NaN;
                    
                    OS{j+1,2}= NaN;
                    OS{j+1,3}= NaN;
                    OS{j+1,4}= NaN;
                    OS{j+1,5}= NaN;
                    OS{j+1,6} = NaN;
                    OS{j+1,7} = NaN;
                    OS{j+1,8} = NaN;
                    OS{j+1,9} = NaN;
                    OS{j+1,10} = NaN;
                    OS{j+1,11} = NaN;
                    OS{j+1,12}= NaN;
                    
                    V{j+1,2}= NaN;
                    V{j+1,3}= NaN;
                    V{j+1,4}= NaN;
                    V{j+1,5}= NaN;
                    V{j+1,6} = NaN;
                    V{j+1,7} = NaN;
                    V{j+1,8} = NaN;
                    V{j+1,9} = NaN;
                    V{j+1,10} = NaN;
                    V{j+1,11} = NaN;
                    V{j+1,12}= NaN;
                    
                    OG{j+1,2}= NaN;
                    OG{j+1,3}= NaN;
                    OG{j+1,4}= NaN;
                    OG{j+1,5}= NaN;
                    OG{j+1,6} = NaN;
                    OG{j+1,7} = NaN;
                    OG{j+1,8} = NaN;
                    OG{j+1,9} = NaN;
                    OG{j+1,10} = NaN;
                    OG{j+1,11} = NaN;
                    OG{j+1,12}= NaN;
                    
                    TR = isnan(Celloutput(i).sp_centroids{1, j});
                    if TR ~= 1
                        if ~isnan(fazelN(1,1))
                            N{j+1,2}= fazelN(1,1);
                            N{j+1,3}= fazelN(1,2);
                            N{j+1,4}= fazelN(1,3);
                            N{j+1,5}= 0.25;
                            N{j+1,6} = NormalVect(1,1);
                            N{j+1,7} = NormalVect(1,2);
                            N{j+1,8} = NormalVect(1,3);
                            N{j+1,9} = OrthogonalVect(1,1);
                            N{j+1,10} = OrthogonalVect(1,2);
                            N{j+1,11} = OrthogonalVect(1,3);
                            N{j+1,12}= 1;
                        end
                        if ~isnan(fazelS(1,1))
                            S{j+1,2}= fazelS(1,1);
                            S{j+1,3}= fazelS(1,2);
                            S{j+1,4}= fazelS(1,3);
                            S{j+1,5}= 0.25;
                            S{j+1,6} = SpinVect(1,1);
                            S{j+1,7} = SpinVect(1,2);
                            S{j+1,8} = SpinVect(1,3);
                            S{j+1,9} = OrthogonalVect(1,1);
                            S{j+1,10} = OrthogonalVect(1,2);
                            S{j+1,11} = OrthogonalVect(1,3);
                            S{j+1,12}= 1;
                        end
                        if ~isnan(fazelO(1,1))
                            OS{j+1,2}= fazelO(1,1);
                            OS{j+1,3}= fazelO(1,2);
                            OS{j+1,4}= fazelO(1,3);
                            OS{j+1,5}= 0.25;
                            OS{j+1,6} = OrthogonalVect(1,1);
                            OS{j+1,7} = OrthogonalVect(1,2);
                            OS{j+1,8} = OrthogonalVect(1,3);
                            OS{j+1,9} = SpinVect(1,1);
                            OS{j+1,10} = SpinVect(1,2);
                            OS{j+1,11} = SpinVect(1,3);
                            OS{j+1,12}= 1;
                        end
                        if ~isnan(fazelO2(1,1))
                            V{j+1,2}= fazelO2(1,1);
                            V{j+1,3}= fazelO2(1,2);
                            V{j+1,4}= fazelO2(1,3);
                            V{j+1,5}= 0.25;
                            V{j+1,6} = ortho2(1,1);
                            V{j+1,7} = ortho2(1,2);
                            V{j+1,8} = ortho2(1,3);
                            V{j+1,9} = NormalVect(1,1);
                            V{j+1,10} = NormalVect(1,2);
                            V{j+1,11} = NormalVect(1,3);
                            V{j+1,12}= 1;
                        end
                        if ~isnan(fazelO2(1,1))
                            OG{j+1,2}= fazelOG(1,1);
                            OG{j+1,3}= fazelOG(1,2);
                            OG{j+1,4}= fazelOG(1,3);
                            OG{j+1,5}= 0.25;
                            OG{j+1,6} = ortho1(1,1);
                            OG{j+1,7} = ortho1(1,2);
                            OG{j+1,8} = ortho1(1,3);
                            OG{j+1,9} = ortho2(1,1);
                            OG{j+1,10} = ortho2(1,2);
                            OG{j+1,11} = ortho2(1,3);
                            OG{j+1,12}= 1;
                        end
                    end
                end
                
                E = '_length_';
                D = num2str(h);
                B = '_Disk_';
                C = char([Celloutput(i).cell]);
                A = char([Celloutput(i).gonad,B,C,E,D,'.txt']);
                filename1 = char([folder,'/normal/',A]);
                filename2 = char([folder,'/spindle/',A]);
                filename3 = char([folder,'/ortho/',A]);
                filename4 = char([folder,'/vert/',A]);
                filename5 = char([folder,'/OrthoDP/',A]);
                
                writecell(N,filename1,'Delimiter','tab');
                writecell(S,filename2,'Delimiter','tab');
                writecell(OS,filename3,'Delimiter','tab');
                writecell(V,filename4,'Delimiter','tab');
                writecell(OG,filename5,'Delimiter','tab')
            end
        end
    end
% end
%     for i = 1:1:length(Celloutputnondiv)
%
%         gonad = Celloutputnondiv(i).gonad;
%         specific_gonad = matches(Germlines,gonad);
%         specific_gonad=num2cell(specific_gonad);
%         for op=1:1:length(specific_gonad)
%             if isequal(specific_gonad{op,1},0)
%                 specific_gonad{op,1}=[];
%             end
%         end
%         ffoo = find(~cellfun('isempty', specific_gonad));
%
%         N = cell(length(Celloutputnondiv(i).meas(:,1))+1,12);
%         V = cell(length(Celloutputnondiv(i).meas(:,1))+1,12);
%         OG = cell(length(Celloutputnondiv(i).meas(:,1))+1,12);
%
%         N{1,1}='Frames';
%         N{1,2}='xcoord';
%         N{1,3}='ycoord';
%         N{1,4}='zcoord';
%         N{1,5}='radius';
%         N{1,6}='V1x';
%         N{1,7}='V1y';
%         N{1,8}='V1z';
%         N{1,9}='V2x';
%         N{1,10}='V2y';
%         N{1,11}='V2z';
%         N{1,12}='radius2';
%
%         V{1,1}='Frames';
%         V{1,2}='xcoord';
%         V{1,3}='ycoord';
%         V{1,4}='zcoord';
%         V{1,5}='radius';
%         V{1,6}='V1x';
%         V{1,7}='V1y';
%         V{1,8}='V1z';
%         V{1,9}='V2x';
%         V{1,10}='V2y';
%         V{1,11}='V2z';
%         V{1,12}='radius2';
%
%         OG{1,1}='Frames';
%         OG{1,2}='xcoord';
%         OG{1,3}='ycoord';
%         OG{1,4}='zcoord';
%         OG{1,5}='radius';
%         OG{1,6}='V1x';
%         OG{1,7}='V1y';
%         OG{1,8}='V1z';
%         OG{1,9}='V2x';
%         OG{1,10}='V2y';
%         OG{1,11}='V2z';
%         OG{1,12}='radius2';
%
%         for j = 1:1:length(Celloutputnondiv(i).meas(:,1))
%
%             N{j+1,1}= Celloutputnondiv(i).meas(j,1);
%             L{j+1,1}= Celloutputnondiv(i).meas(j,1);
%             V{j+1,1}= Celloutputnondiv(i).meas(j,1);
%             OG{j+1,1}= Celloutputnondiv(i).meas(j,1);
%
%             SpinMid = Celloutputnondiv(i).meas(j,2:4);
%             NormalVect = (Celloutputnondiv(i).meas(j,14:16))/(norm(Celloutputnondiv(i).meas(j,14:16)));
%
%
%             DPVect = [Germlineoutput(ffoo).DPaxisVector(frame,1);Germlineoutput(ffoo).DPaxisVector(frame,2);Germlineoutput(ffoo).DPaxisVector(frame,3)];
%             ortho1 = cross(DPVect,NormalVect)/norm(cross(DPVect,NormalVect));
%             ortho2 = cross(ortho1,NormalVect)/norm(cross(ortho1,NormalVect));
%
%             lenghtNormalVect = sqrt((NormalVect(1,1)^2) + (NormalVect(1,2)^2) +  (NormalVect(1,3)^2));
%             lenghtortho2 = sqrt((ortho2(1,1)^2) + (ortho2(1,2)^2) +  (ortho2(1,3)^2));
%             lenghtortho1 = sqrt((ortho1(1,1)^2) + (ortho1(1,2)^2) +  (ortho1(1,3)^2));
%
%             LenghtTranslation = h;
%
%             fnormal = LenghtTranslation/lenghtNormalVect;
%             fortho2 = LenghtTranslation/lenghtortho2;
%             fortho1 = LenghtTranslation/lenghtortho1;
%
%             TranslationVectN = NormalVect*fnormal;
%             TranslationVectO2 = ortho2*fortho2;
%             TranslationVectOG = ortho1*fortho1;
%
%             fazelN = SpinMid + TranslationVectN;
%             fazelO2 = SpinMid + TranslationVectO2;
%             fazelOG = SpinMid + TranslationVectOG;
%
%             N{j+1,2}= NaN;
%             N{j+1,3}= NaN;
%             N{j+1,4}= NaN;
%             N{j+1,5}= NaN;
%             N{j+1,6} = NaN;
%             N{j+1,7} = NaN;
%             N{j+1,8} = NaN;
%             N{j+1,9} = NaN;
%             N{j+1,10} = NaN;
%             N{j+1,11} = NaN;
%             N{j+1,12}= NaN;
%
%             V{j+1,2}= NaN;
%             V{j+1,3}= NaN;
%             V{j+1,4}= NaN;
%             V{j+1,5}= NaN;
%             V{j+1,6} = NaN;
%             V{j+1,7} = NaN;
%             V{j+1,8} = NaN;
%             V{j+1,9} = NaN;
%             V{j+1,10} = NaN;
%             V{j+1,11} = NaN;
%             V{j+1,12}= NaN;
%
%             OG{j+1,2}= NaN;
%             OG{j+1,3}= NaN;
%             OG{j+1,4}= NaN;
%             OG{j+1,5}= NaN;
%             OG{j+1,6} = NaN;
%             OG{j+1,7} = NaN;
%             OG{j+1,8} = NaN;
%             OG{j+1,9} = NaN;
%             OG{j+1,10} = NaN;
%             OG{j+1,11} = NaN;
%             OG{j+1,12}= NaN;
%
%             TR = isnan(Celloutputnondiv(i).sp_centroids{1, j});
%             if TR ~= 1
%                 if ~isnan(fazelN(1,1))
%                     N{j+1,2}= fazelN(1,1);
%                     N{j+1,3}= fazelN(1,2);
%                     N{j+1,4}= fazelN(1,3);
%                     N{j+1,5}= 0.25;
%                     N{j+1,6} = NormalVect(1,1);
%                     N{j+1,7} = NormalVect(1,2);
%                     N{j+1,8} = NormalVect(1,3);
%                     N{j+1,9} = ortho1(1,1);
%                     N{j+1,10} = ortho1(1,2);
%                     N{j+1,11} = ortho1(1,3);
%                     N{j+1,12}= 1;
%                 end
%                 if ~isnan(fazelO2(1,1))
%                     V{j+1,2}= fazelO2(1,1);
%                     V{j+1,3}= fazelO2(1,2);
%                     V{j+1,4}= fazelO2(1,3);
%                     V{j+1,5}= 0.25;
%                     V{j+1,6} = ortho2(1,1);
%                     V{j+1,7} = ortho2(1,2);
%                     V{j+1,8} = ortho2(1,3);
%                     V{j+1,9} = NormalVect(1,1);
%                     V{j+1,10} = NormalVect(1,2);
%                     V{j+1,11} = NormalVect(1,3);
%                     V{j+1,12}= 1;
%                 end
%                 if ~isnan(fazelOG(1,1))
%                     OG{j+1,2}= fazelOG(1,1);
%                     OG{j+1,3}= fazelOG(1,2);
%                     OG{j+1,4}= fazelOG(1,3);
%                     OG{j+1,5}= 0.25;
%                     OG{j+1,6} = ortho1(1,1);
%                     OG{j+1,7} = ortho1(1,2);
%                     OG{j+1,8} = ortho1(1,3);
%                     OG{j+1,9} = ortho2(1,1);
%                     OG{j+1,10} = ortho2(1,2);
%                     OG{j+1,11} = ortho2(1,3);
%                     OG{j+1,12}= 1;
%                 end
%             end
%         end
%         E = '_length_';
%         D = num2str(h);
%         B = '_Disk_';
%         C = char([Celloutputnondiv(i).cell]);
%         A = char([Celloutputnondiv(i).gonad,B,C,E,D,'.txt']);
%         filename1 = char([folder,'/NonDividingNormal/',A]);
%         filename3 = char([folder,'/NonDividingVert/',A]);
%         filename4 = char([folder,'/NonDividingOrthoDP/',A]);
%         writecell(N,filename1,'Delimiter','tab');
%         writecell(V,filename3,'Delimiter','tab');
%         writecell(OG,filename4,'Delimiter','tab');
%     end
% end