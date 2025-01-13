for j = 1:1:length(Celloutput)
    xstart = -6;
    xstop = 6;
    %     Celloutput(j).MeanvertVectFluo = nan(length(Celloutput(j).Mean_vert_Ch1(:,1)), 2);
    Celloutput(j).meas(:,42) = NaN;
    Celloutput(j).meas(:,43) = NaN;
    Celloutput(j).meas(:,44) = NaN;
    Celloutput(j).meas(:,45) = NaN;
    foa = Celloutput(j).scoring(1,2);
    ioa = find ((Celloutput(j).meas(:,1))== foa);
    if ~isnan(foa)
        if length(1:ioa) >= 2
            for h = 1:1:length(Celloutput(j).meas(:,1))
                if h<=ioa+1 && h>=ioa-1
                    if ~isnan(Celloutput(j).Area_vert_Ch1(h,1))
                        spin_midpnt = Celloutput(j).meas(h,4:6);
                        SpinVect = Celloutput(j).meas(h,7:9);
                        VertVect = [0 1 0];
                        lenghtVertVect = sqrt((VertVect(1,1)^2) + (VertVect(1,2)^2) +  (VertVect(1,3)^2));
                        aa = ((spin_midpnt * 2) - SpinVect)./2;
                        ab = SpinVect + aa;
                        % Create figure full screen
                        figure1 = figure('units','normalized','outerposition',[0 0 1 1]);
                        % Create axes
                        % sets the x-axis tick values
                        axes1 = axes('Parent',figure1,'XTick',[xstart:2:xstop],'XGrid','on');
                        box(axes1,'on');
                        hold(axes1,'all');
                        % Create plot - frames/vertdle length
                        X1 = IndexTranslation(:,2);
                        hold on
                        
                        yyaxis right
                        Y1 = Celloutput(j).RawIntDen_vert_Ch1(h,:)./Celloutput(j).Area_vert_Ch1(h,:);
                        plot(X1,Y1,'Marker','o','Color',[1 0 0]);
                        xlim([-6 6])
                        
                        yyaxis left
                        Y1 = Celloutput(j).RawIntDen_vert_Ch2(h,:)./Celloutput(j).Area_vert_Ch2(h,:);
                        plot(X1,Y1,'Marker','o','Color',[0 0 1]);
                        xlim([-6 6])
                        
                        hold off
                        %         SLfig = figure;
                        % Add titlesdvg
                        title([num2str(Celloutput(j).gonad), ' ', num2str(Celloutput(j).cell), ' frame ', num2str(h)],'Interpreter','none');
                        %axis([xstart xstop 5000 15000]);
                        %         shg;
                        %spot your frame surestimated !
                        %identify first point = first frame where vertdle length <= mean
                        %length during congression
                        %and second point = last frame of congression prior to
                        %rapid/anaphase vertdle elongation
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
                        
                        
                        Fs = x(1); %membrane left
                        Fe = x(2); %centro left
                        
                        
                        
                        if ~isnan(Fs)
                            fss = Fs/lenghtVertVect;
                            TranslationVects = VertVect*fss;
                            CenterEllipsoids = spin_midpnt + TranslationVects;
                            DistanceCentas = norm(CenterEllipsoids - aa);
                            DistanceCentbs = norm(CenterEllipsoids - ab);
                            disp(DistanceCentas)
                            disp(DistanceCentbs)
                            if DistanceCentas >= 1.5 && DistanceCentbs >= 1.5
                                waas = find ((IndexTranslation(:,2)) == Fs);
                                wiis = IndexTranslation(waas,1);
                                Celloutput(j).meas(h,42) =  Celloutput(j).RawIntDen_vert_Ch2(h,wiis)/Celloutput(j).Area_vert_Ch2(h,wiis);
                                Celloutput(j).meas(h,43) =  Fs;
                                
                            end
                        end
                        if ~isnan(Fe)
                            fee = Fe/lenghtVertVect;
                            TranslationVecte = VertVect*fee;
                            CenterEllipsoide = spin_midpnt + TranslationVecte;
                            DistanceCentae = norm(CenterEllipsoide - aa);
                            DistanceCentbe = norm(CenterEllipsoide - ab);
                            disp(DistanceCentae)
                            disp(DistanceCentbe)
                            if DistanceCentae >= 1.5 && DistanceCentbe >= 1.5
                                waae = find ((IndexTranslation(:,2)) == Fe);
                                wiie = IndexTranslation(waae,1);
                                Celloutput(j).meas(h,44) =  Celloutput(j).RawIntDen_vert_Ch2(h,wiie)/Celloutput(j).Area_vert_Ch2(h,wiie);
                                Celloutput(j).meas(h,45) =  Fe;
                            end
                        end
                        close(figure1);
                    end
                end
            end
        end
    end
end