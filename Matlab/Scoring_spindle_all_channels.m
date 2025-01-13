for j = 1:1:length(Celloutput)
    xstart = -6;
    xstop = 6;
    % Celloutput(j).meas(:,29) = NaN;
    % Celloutput(j).meas(:,30) = NaN;
    % Celloutput(j).meas(:,31) = NaN;
    % Celloutput(j).meas(:,32) = NaN;
    % Celloutput(j).meas(:,34) = NaN;
    % Celloutput(j).meas(:,35) = NaN;
    foa = Celloutput(j).scoring(1,2);
    ioa = find ((Celloutput(j).meas(:,1))== foa);
    if ~isnan(foa)
        %         if length(1:ioa) >= 2
        for h = 1:1:length(Celloutput(j).Area_spindle_Ch1(:,1))
            %                 if h<=ioa+1 && h>=ioa-1
            if h == ioa
                if ~isnan(Celloutput(j).Area_spindle_Ch1(h,1))
                    % Create figure full screen
                    figure1 = figure('units','normalized','outerposition',[0 0 1 1]);
                    % Create axes
                    % sets the x-axis tick values
                    axes1 = axes('Parent',figure1,'XTick',[xstart:2:xstop],'XGrid','on');
                    box(axes1,'on');
                    hold(axes1,'all');
                    % Create plot - frames/orthodle length
                    X1 = IndexTranslation(:,2);
                    hold on
                    
                    yyaxis right
                    Y1 = Celloutput(j).RawIntDen_spindle_Ch1(h,:)./Celloutput(j).Area_spindle_Ch1(h,:);
                    plot(X1,Y1,'Marker','o','Color',[1 0 0]);
                    xlim([-6 6])
                    
                    yyaxis left
                    Y1 = Celloutput(j).RawIntDen_spindle_Ch2(h,:)./Celloutput(j).Area_spindle_Ch2(h,:);
                    plot(X1,Y1,'Marker','o','Color',[0 0 1]);
                    xlim([-6 6])
                    
                    hold off
                    
                    ax = gca;
                    ax.YAxis(1).Color = 'blue';
                    ax.YAxis(2).Color = 'red';
                    %         SLfig = figure;
                    % Add titlesdvg
                    title([num2str(Celloutput(j).gonad), ' ', num2str(Celloutput(j).cell), ' frame ', num2str(h)],'Interpreter','none');
                    %axis([xstart xstop 5000 15000]);
                    %         shg;
                    %spot your frame surestimated !
                    %identify first point = first frame where orthodle length <= mean
                    %length during congression
                    %and second point = last frame of congression prior to
                    %rapid/anaphase orthodle elongation
                    %!!!!!if track starts after NEBD, first point is NaN
                    %choose it in a way that his x position is subsequent to second
                    %point
                    [x,y] = ginput(4);
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
                    Fe = x(2); %centro left
                    Ft = x(3); %centro right
                    Ff = x(4); %Ch1 right
                    
                    % if ~isnan(Fs)
                    %     if -Fs + Fe > 1.5
                    %         waa = find ((IndexTranslation(:,2)) == Fs);
                    %         wee = find ((IndexTranslation(:,2)) == Fe);
                    %         wii = IndexTranslation(waa,1);
                    %         woo = IndexTranslation(wee,1);
                    %         Celloutput(j).meas(h,29) =  Celloutput(j).RawIntDen_spindle_Ch2(h,wii)/Celloutput(j).Area_spindle_Ch2(h,wii);
                    %         Celloutput(j).meas(h,30) =  Fs;
                    %         Celloutput(j).meas(h,34) = Celloutput(j).RawIntDen_spindle_Ch1(h,wii)/Celloutput(j).Area_spindle_Ch1(h,wii);
                    %     end
                    % end
                    % if ~isnan(Ff)
                    %     if Ff - Ft > 1.5
                    %         waa = find ((IndexTranslation(:,2)) == Ff);
                    %         wee = find ((IndexTranslation(:,2)) == Ft);
                    %         wii = IndexTranslation(waa,1);
                    %         woo = IndexTranslation(wee,1);
                    %         Celloutput(j).meas(h,31) =  Celloutput(j).RawIntDen_spindle_Ch2(h,wii)/Celloutput(j).Area_spindle_Ch2(h,wii);
                    %         Celloutput(j).meas(h,32) =  Ff;
                    %         Celloutput(j).meas(h,35) = Celloutput(j).RawIntDen_spindle_Ch1(h,wii)/Celloutput(j).Area_spindle_Ch1(h,wii);
                    %     end
                    % end
                    close(figure1);
                end
            end
        end
    end
end
