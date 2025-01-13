folder = uigetdir;
mkdir(folder, 'NonDividingLateral');
mkdir(folder, 'NonDividingNormal');

for h = -6:0.25:6
    for i = 1:1:length(Celloutputnondiv)
        
        N = cell(length(Celloutputnondiv(i).meas(:,1))+1,12);
        L = cell(length(Celloutputnondiv(i).meas(:,1))+1,12);
        
        
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
        
        L{1,1}='Frames';
        L{1,2}='xcoord';
        L{1,3}='ycoord';
        L{1,4}='zcoord';
        L{1,5}='radius';
        L{1,6}='V1x';
        L{1,7}='V1y';
        L{1,8}='V1z';
        L{1,9}='V2x';
        L{1,10}='V2y';
        L{1,11}='V2z';
        L{1,12}='radius2';
        
        for j = 1:1:length(Celloutputnondiv(i).meas(:,1))
            
            N{j+1,1}= Celloutputnondiv(i).meas(j,1);
            L{j+1,1}= Celloutputnondiv(i).meas(j,1);
            
            SpinMid = Celloutputnondiv(i).meas(j,2:4);
            NormalVect = (Celloutputnondiv(i).meas(j,14:16))/(norm(Celloutputnondiv(i).meas(j,14:16)));
            if ~isnan(NormalVect)
                %%%% Generate a random spindle pole
                M = (NormalVect)'; % the normal to the plane
                xyz0= (SpinMid)' ; % point inside the plane
                sz = 4; % size of the rectangle
                n = 1; % number of random points
                Q = null(M');
                xyz = xyz0 + Q*((rand(2,n)-0.5)*sz);%spindle pole
                LateralVect = ((xyz - xyz0)/(norm((xyz - xyz0))))';
            else
                LateralVect = [NaN   NaN   NaN];
            end
            OrtogonalVect = cross(LateralVect,NormalVect)/norm(cross(LateralVect,NormalVect));
            lenghtNormalVect = sqrt((NormalVect(1,1)^2) + (NormalVect(1,2)^2) +  (NormalVect(1,3)^2));
            LenghtTranslation = h;
            f = LenghtTranslation/lenghtNormalVect;
            TranslationVect = NormalVect*f;
            fazel = SpinMid + TranslationVect;
            
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
            
            L{j+1,2}= NaN;
            L{j+1,3}= NaN;
            L{j+1,4}= NaN;
            L{j+1,5}= NaN;
            L{j+1,6} = NaN;
            L{j+1,7} = NaN;
            L{j+1,8} = NaN;
            L{j+1,9} = NaN;
            L{j+1,10} = NaN;
            L{j+1,11} = NaN;
            L{j+1,12}= NaN;
            
            TR = isnan(Celloutputnondiv(i).sp_centroids{1, j});
            if TR ~= 1
                if ~isnan(fazel(1,1))
                    N{j+1,2}= fazel(1,1);
                    N{j+1,3}= fazel(1,2);
                    N{j+1,4}= fazel(1,3);
                    N{j+1,5}= 0.25;
                    N{j+1,6} = NormalVect(1,1);
                    N{j+1,7} = NormalVect(1,2);
                    N{j+1,8} = NormalVect(1,3);
                    N{j+1,9} = OrtogonalVect(1,1);
                    N{j+1,10} = OrtogonalVect(1,2);
                    N{j+1,11} = OrtogonalVect(1,3);
                    N{j+1,12}= 1;
                    
                    L{j+1,2}= fazel(1,1);
                    L{j+1,3}= fazel(1,2);
                    L{j+1,4}= fazel(1,3);
                    L{j+1,5}= 0.25;
                    L{j+1,6} = LateralVect(1,1);
                    L{j+1,7} = LateralVect(1,2);
                    L{j+1,8} = LateralVect(1,3);
                    L{j+1,9} = OrtogonalVect(1,1);
                    L{j+1,10} = OrtogonalVect(1,2);
                    L{j+1,11} = OrtogonalVect(1,3);
                    L{j+1,12}= 1;
                    
                end
            end
        end
        E = '_length_';
        D = num2str(h);
        B = '_Disk_';
        C = char([Celloutputnondiv(i).cell]);
        A = char([Celloutputnondiv(i).gonad,B,C,E,D,'.txt']);
        filename1 = char([folder,'/NonDividingNormal/',A]);
        filename2 = char([folder,'/NonDividingLateral/',A]);
        writecell(N,filename1,'Delimiter','tab');
        writecell(L,filename2,'Delimiter','tab');
    end
end