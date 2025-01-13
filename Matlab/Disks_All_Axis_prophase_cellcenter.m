folder = uigetdir;

mkdir(folder, 'ProphaseNormal');
mkdir(folder, 'ProphaseVert');
mkdir(folder, 'ProphaseOrthoDP');


for i = 1:1:length(CellCenteroutput)
    GermlinesAll{i,1} = CellCenteroutput(i).gonad;
end
Germlines = unique(GermlinesAll);
for h = -6:0.25:6
    for i = 1:1:length(CellCenteroutput)
        if size(CellCenteroutput(i).meas)>1
            gonad = CellCenteroutput(i).gonad;
            
            specific_gonad = matches(Germlines,gonad);
            specific_gonad=num2cell(specific_gonad);
            for op=1:1:length(specific_gonad)
                if isequal(specific_gonad{op,1},0)
                    specific_gonad{op,1}=[];
                end
            end
            ffoo = find(~cellfun('isempty', specific_gonad));
            
            N = cell(length(CellCenteroutput(i).meas(:,1))+1,12);
            V = cell(length(CellCenteroutput(i).meas(:,1))+1,12);
            OG = cell(length(CellCenteroutput(i).meas(:,1))+1,12);
            
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
            
            for j = 1:1:length(CellCenteroutput(i).meas(:,1))
                
                N{j+1,1}= CellCenteroutput(i).meas(j,1);
                L{j+1,1}= CellCenteroutput(i).meas(j,1);
                V{j+1,1}= CellCenteroutput(i).meas(j,1);
                OG{j+1,1}= CellCenteroutput(i).meas(j,1);
                
                SpinMid = CellCenteroutput(i).meas(j,3:5);
                NormalVect = (CellCenteroutput(i).meas(j,14:16))/(norm(CellCenteroutput(i).meas(j,14:16)));
                
                frame = 1;
                DPVect = [Germlineoutput(ffoo).DPaxisVector(frame,1);Germlineoutput(ffoo).DPaxisVector(frame,2);Germlineoutput(ffoo).DPaxisVector(frame,3)];
                ortho1 = cross(DPVect,NormalVect)/norm(cross(DPVect,NormalVect));
                ortho2 = cross(ortho1,NormalVect)/norm(cross(ortho1,NormalVect));
                
                lenghtNormalVect = sqrt((NormalVect(1,1)^2) + (NormalVect(1,2)^2) +  (NormalVect(1,3)^2));
                lenghtortho2 = sqrt((ortho2(1,1)^2) + (ortho2(1,2)^2) +  (ortho2(1,3)^2));
                lenghtortho1 = sqrt((ortho1(1,1)^2) + (ortho1(1,2)^2) +  (ortho1(1,3)^2));
                
                LenghtTranslation = h;
                
                fnormal = LenghtTranslation/lenghtNormalVect;
                fortho2 = LenghtTranslation/lenghtortho2;
                fortho1 = LenghtTranslation/lenghtortho1;
                
                TranslationVectN = NormalVect*fnormal;
                TranslationVectO2 = ortho2*fortho2;
                TranslationVectOG = ortho1*fortho1;
                
                fazelN = SpinMid + TranslationVectN;
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
                
                TR = isnan(CellCenteroutput(i).sp_centroids{1, j});
                if TR ~= 1
                    if ~isnan(fazelN(1,1))
                        N{j+1,2}= fazelN(1,1);
                        N{j+1,3}= fazelN(1,2);
                        N{j+1,4}= fazelN(1,3);
                        N{j+1,5}= 0.25;
                        N{j+1,6} = NormalVect(1,1);
                        N{j+1,7} = NormalVect(1,2);
                        N{j+1,8} = NormalVect(1,3);
                        N{j+1,9} = ortho1(1,1);
                        N{j+1,10} = ortho1(1,2);
                        N{j+1,11} = ortho1(1,3);
                        N{j+1,12}= 1;
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
                    if ~isnan(fazelOG(1,1))
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
            C = char([CellCenteroutput(i).cell]);
            A = char([CellCenteroutput(i).gonad,B,C,E,D,'.txt']);
            filename1 = char([folder,'/ProphaseNormal/',A]);
            filename3 = char([folder,'/ProphaseVert/',A]);
            filename4 = char([folder,'/ProphaseOrthoDP/',A]);
            writecell(N,filename1,'Delimiter','tab');
            writecell(V,filename3,'Delimiter','tab');
            writecell(OG,filename4,'Delimiter','tab');
            
        end
    end
end