for j = 1:1:length(Celloutput)
    xstart = -6;
    xstop = 6;
    Celloutput(j).meas(:,48) = NaN;
    Celloutput(j).meas(:,49) = NaN;
    Celloutput(j).meas(:,50) = NaN;
    Celloutput(j).meas(:,51) = NaN;
    Celloutput(j).meas(:,52) = NaN;
    Celloutput(j).meas(:,53) = NaN;
    
    gonad = Celloutput(j).gonad;
    specific_gonad = matches(Germlines,gonad);
    specific_gonad=num2cell(specific_gonad);
    for op=1:1:length(specific_gonad)
        if isequal(specific_gonad{op,1},0)
            specific_gonad{op,1}=[];
        end
    end
    ffoo = find(~cellfun('isempty', specific_gonad));
    
    foa = Celloutput(j).scoring(1,2);
    ioa = find ((Celloutput(j).meas(:,1))== foa);
    if ~isnan(foa)
        if length(1:ioa) >= 2
            for h = 1:1:length(Celloutput(j).meas(:,1))
                if h<=ioa+1 && h>=ioa-1
                    if ~isnan(Celloutput(j).Area_orthoDP_Ch1(h,1))
                        spin_midpnt = Celloutput(j).meas(h,4:6);
                        SpinVect = Celloutput(j).meas(h,7:9);
                        aa = ((spin_midpnt * 2) - SpinVect)./2;
                        ab = SpinVect + aa;
                        frame = Celloutput(j).meas(h,1);
                        NormalVect = (Celloutput(j).meas(h,14:16))/(norm(Celloutput(j).meas(h,14:16)));
                        OrthogonalVect = cross(SpinVect,NormalVect)/norm(cross(SpinVect,NormalVect));
                        DPVect = [Germlineoutput(ffoo).DPaxisVector(1,1);Germlineoutput(ffoo).DPaxisVector(1,2);Germlineoutput(ffoo).DPaxisVector(1,3)];
                        ortho1 =  cross(DPVect,NormalVect)/norm(cross(DPVect,NormalVect));
                        % Create figure full screen
                        figure1 = figure('units','normalized','outerposition',[0 0 1 1]);
                        % Create axes
                        % sets the x-axis tick values
                        axes1 = axes('Parent',figure1,'XTick',[xstart:2:xstop],'XGrid','on');
                        box(axes1,'on');
                        hold(axes1,'all');
                        % Create plot - frames/orthoDPdle length
                        X1 = IndexTranslation(:,2);
                        hold on
                        
                        yyaxis right
                        Y1 = Celloutput(j).RawIntDen_orthoDP_Ch1(h,:)./Celloutput(j).Area_orthoDP_Ch1(h,:);
                        plot(X1,Y1,'Marker','o','Color',[1 0 0]);
                        xlim([-6 6])
                        
                        yyaxis left
                        Y1 = Celloutput(j).RawIntDen_orthoDP_Ch2(h,:)./Celloutput(j).Area_orthoDP_Ch2(h,:);
                        plot(X1,Y1,'Marker','o','Color',[0 0 1]);
                        xlim([-6 6])
                        
                        hold off
                        %         SLfig = figure;
                        % Add titlesdvg
                        title([num2str(Celloutput(j).gonad), ' ', num2str(Celloutput(j).cell), ' frame ', num2str(h)],'Interpreter','none');
                        %axis([xstart xstop 5000 15000]);
                        %         shg;
                        %spot your frame surestimated !
                        %identify first point = first frame where orthoDPdle length <= mean
                        %length during congression
                        %and second point = last frame of congression prior to
                        %rapid/anaphase orthoDPdle elongation
                        %!!!!!if track starts after NEBD, first point is NaN
                        %choose it in a way that his x position is subsequent to second
                        %point
                        [x,y] = ginput(2);
                        %rounds each element of x to the nearest integer
                        %less than or equal to that element.
                        %round up
                        x = floor(x) + ceil( (x-floor(x))/0.25) * 0.25;
                        if x(1)<-6 || x(1)>6
                            x(1)=NaN;
                        end
                        if x(2)<-6 || x(2)>6
                            x(2)=NaN;
                        end
                        
                        Fs = x(1); %Ch1 left
                        Fe = x(2); %Ch1 rigth
                        
                        
                        if ~isnan(Fs)
                            f = Fs/norm(ortho1);
                            TranslationVect = ortho1*f;
                            CenterEllipsoid = spin_midpnt + TranslationVect;
                            DistanceCenta = norm(CenterEllipsoid - aa);
                            DistanceCentb = norm(CenterEllipsoid - ab);
                            disp(DistanceCenta);
                            disp(DistanceCentb);
                            if DistanceCenta > 1.5 && DistanceCentb > 1.5
                                waa = find ((IndexTranslation(:,2)) == Fs);
                                wii = IndexTranslation(waa,1);
                                Celloutput(j).meas(h,48) =  Celloutput(j).RawIntDen_orthoDP_Ch2(h,wii)/Celloutput(j).Area_orthoDP_Ch2(h,wii);
                                Celloutput(j).meas(h,49) =  Fs;
                                Celloutput(j).meas(h,52) =  Celloutput(j).RawIntDen_orthoDP_Ch1(h,wii)/Celloutput(j).Area_orthoDP_Ch1(h,wii);
                            end
                        end
                        if ~isnan(Fe)
                            f = Fe/norm(ortho1);
                            TranslationVect = ortho1*f;
                            CenterEllipsoid = spin_midpnt + TranslationVect;
                            DistanceCenta = norm(CenterEllipsoid - aa);
                            DistanceCentb = norm(CenterEllipsoid - ab);
                            disp(DistanceCenta);
                            disp(DistanceCentb);
                            if DistanceCenta > 1.5 && DistanceCentb > 1.5
                                waa = find ((IndexTranslation(:,2)) == Fe);
                                wii = IndexTranslation(waa,1);
                                Celloutput(j).meas(h,50) =  Celloutput(j).RawIntDen_orthoDP_Ch2(h,wii)/Celloutput(j).Area_orthoDP_Ch2(h,wii);
                                Celloutput(j).meas(h,51) =  Fe;
                                Celloutput(j).meas(h,53) =  Celloutput(j).RawIntDen_orthoDP_Ch1(h,wii)/Celloutput(j).Area_orthoDP_Ch1(h,wii);
                            end
                        end
                        close(figure1);
                    end
                end
            end
        end
    end
end