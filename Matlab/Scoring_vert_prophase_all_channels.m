for j = 1:1:length(CellCenteroutput)
    if size(CellCenteroutput(j).meas) > 1
        xstart = -6;
        xstop = 6;
        CellCenteroutput(j).meas(:,42) = NaN;
        CellCenteroutput(j).meas(:,43) = NaN;
        CellCenteroutput(j).meas(:,44) = NaN;
        CellCenteroutput(j).meas(:,45) = NaN;
        CellCenteroutput(j).meas(:,46) = NaN;
        CellCenteroutput(j).meas(:,47) = NaN;
        
        for h = 1:1:length(CellCenteroutput(j).Area_vert_Ch1(:,1))
            
            if ~isnan(CellCenteroutput(j).Area_vert_Ch1(h,1))
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
                Y1 = CellCenteroutput(j).RawIntDen_vert_Ch1(h,:)./CellCenteroutput(j).Area_vert_Ch1(h,:);
                plot(X1,Y1,'Marker','o','Color',[1 0 0]);
                xlim([-6 6])
                
                yyaxis left
                Y1 = CellCenteroutput(j).RawIntDen_vert_Ch2(h,:)./CellCenteroutput(j).Area_vert_Ch2(h,:);
                plot(X1,Y1,'Marker','o','Color',[0 0 1]);
                xlim([-6 6])
                
                hold off
                
                ax = gca;
                ax.YAxis(1).Color = 'blue';
                ax.YAxis(2).Color = 'red';
                %         SLfig = figure;
                % Add titlesdvg
                title([num2str(CellCenteroutput(j).gonad), ' ', num2str(CellCenteroutput(j).cell), ' frame ', num2str(h)],'Interpreter','none');
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
                
                Ff = x(2); %Ch1 right
                
                if ~isnan(Fs)
                    
                    waa = find ((IndexTranslation(:,2)) == Fs);
                    wii = IndexTranslation(waa,1);
                    CellCenteroutput(j).meas(h,42) =  CellCenteroutput(j).RawIntDen_vert_Ch2(h,wii)/CellCenteroutput(j).Area_vert_Ch2(h,wii);
                    CellCenteroutput(j).meas(h,43) =  Fs;
                    CellCenteroutput(j).meas(h,46) = CellCenteroutput(j).RawIntDen_vert_Ch1(h,wii)/CellCenteroutput(j).Area_vert_Ch1(h,wii);
                end
                if ~isnan(Ff)
                    
                    waa = find ((IndexTranslation(:,2)) == Ff);
                    wii = IndexTranslation(waa,1);
                    CellCenteroutput(j).meas(h,44) =  CellCenteroutput(j).RawIntDen_vert_Ch2(h,wii)/CellCenteroutput(j).Area_vert_Ch2(h,wii);
                    CellCenteroutput(j).meas(h,45) =  Ff;
                    CellCenteroutput(j).meas(h,47) = CellCenteroutput(j).RawIntDen_vert_Ch1(h,wii)/CellCenteroutput(j).Area_vert_Ch1(h,wii);
                end
                close(figure1);
            end
        end
    end
end