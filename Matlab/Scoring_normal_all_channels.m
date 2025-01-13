for j = 1:1:length(Celloutput)
    xstart = -6;
    xstop = 6;
    %     Celloutput(j).MeannormalVectFluo = nan(length(Celloutput(j).Mean_normal_Ch1(:,1)), 2);
    Celloutput(j).meas(:,21) = NaN;
    Celloutput(j).meas(:,22) = NaN;
    Celloutput(j).meas(:,23) = NaN;
    Celloutput(j).meas(:,24) = NaN;
    Celloutput(j).meas(:,38) = NaN;
    Celloutput(j).meas(:,39) = NaN;
    foa = Celloutput(j).scoring(1,2);
    ioa = find ((Celloutput(j).meas(:,1))== foa);
    if ~isnan(foa)
        for h = 1:1:length(Celloutput(j).meas(:,1))
            
            %                 if h<=ioa+1 && h>=ioa-1
            if h == ioa
                if ~isnan(Celloutput(j).Area_normal_Ch1(h,1))
                    % Create figure full screen
                    figure1 = figure('units','normalized','outerposition',[0 0 1 1]);
                    % Create axes
                    % sets the x-axis tick values
                    axes1 = axes('Parent',figure1,'XTick',[xstart:2:xstop],'XGrid','on');
                    box(axes1,'on');
                    hold(axes1,'all');
                    % Create plot - frames/normaldle length
                    X1 = IndexTranslation(:,2);
                    hold on
                    
                    yyaxis right
                    Y1 = Celloutput(j).RawIntDen_normal_Ch1(h,:)./Celloutput(j).Area_normal_Ch1(h,:);
                    plot(X1,Y1,'Marker','o','Color',[1 0 0]);
                    xlim([-6 6])
                    
                    yyaxis left
                    Y1 = Celloutput(j).RawIntDen_normal_Ch2(h,:)./Celloutput(j).Area_normal_Ch2(h,:);
                    plot(X1,Y1,'Marker','o','Color',[0 0 1]);
                    xlim([-6 6])
                    
                    hold off
                    %         SLfig = figure;
                    % Add titlesdvg
                    title([num2str(Celloutput(j).gonad), ' ', num2str(Celloutput(j).cell), ' frame ', num2str(h)],'Interpreter','none');
                    %axis([xstart xstop 5000 15000]);
                    %         shg;
                    %spot your frame surestimated !
                    %identify first point = first frame where normaldle length <= mean
                    %length during congression
                    %and second point = last frame of congression prior to
                    %rapid/anaphase normaldle elongation
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
                        
                        waa = find ((IndexTranslation(:,2)) == Fs);
                        wii = IndexTranslation(waa,1);
                        Celloutput(j).meas(h,21) =  Celloutput(j).RawIntDen_normal_Ch2(h,wii)/Celloutput(j).Area_normal_Ch2(h,wii);
                        Celloutput(j).meas(h,22) =  Fs;
                        Celloutput(j).meas(h,38) = Celloutput(j).RawIntDen_normal_Ch1(h,wii)/Celloutput(j).Area_normal_Ch1(h,wii);
                    end
                    if ~isnan(Fe)
                        
                        waa = find ((IndexTranslation(:,2)) == Fe);
                        wii = IndexTranslation(waa,1);
                        Celloutput(j).meas(h,23) =  Celloutput(j).RawIntDen_normal_Ch2(h,wii)/Celloutput(j).Area_normal_Ch2(h,wii);
                        Celloutput(j).meas(h,24) =  Fe;
                        Celloutput(j).meas(h,39) = Celloutput(j).RawIntDen_normal_Ch1(h,wii)/Celloutput(j).Area_normal_Ch1(h,wii);
                    end
                    close(figure1);
                end
            end
        end
    end
end
