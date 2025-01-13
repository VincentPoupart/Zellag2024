    for j = 1:1:length(Celloutputnondiv)
        foa = Celloutputnondiv(j).scoring(1,2); 
        ioa = find ((Celloutputnondiv(j).meas(:,1))== foa);
        if ~isnan(foa)
        xstart = -6;
        xstop = 6;
        % Create figure full screen
        figure1 = figure('units','normalized','outerposition',[0 0 1 1]);
        % Create axes
        % sets the x-axis tick values 
        axes1 = axes('Parent',figure1,'XTick',[xstart:2:xstop],'XGrid','on');
        box(axes1,'on');
        hold(axes1,'all');
        % Create plot - frames/spindle length
        X1 = IndexTranslation(:,2);
        Y1 = Celloutputnondiv(j).SphereMean_along_spin_vect_Lin5(ioa,:);
        plot(X1,Y1,'Marker','o','Color',[0 0 1]);
        %SLfig = figure;
        %plot(output(j).meas(:,1),output(j).meas(:,3),'-ob');
        % Add titlesdvg
        title({Celloutputnondiv(j).gonad;Celloutputnondiv(j).cell},'Interpreter','none');
%         axis([xstart xstop 0 250000]);
        shg;
        %spot your frame surestimated !
        %identify first point = first frame where spindle length <= mean 
        %length during congression
        %and second point = last frame of congression prior to 
        %rapid/anaphase spindle elongation
        %!!!!!if track starts after NEBD, first point is NaN 
        %choose it in a way that his x position is subsequent to second
        %point
        [x,y] = ginput(2);
        %rounds each element of x to the nearest integer 
        %less than or equal to that element.
        %round up
        x = floor(x) + ceil( (x-floor(x))/0.25) * 0.25;
        if x(1)<-6 | x(1)>6
        x(1)=NaN;
        end
        if x(2)<-6 | x(2)>6
        x(2)=NaN;
        end
        Fs = x(1);
        Fe = x(2);
        % if ~isnan(Fs)
        % waa = find ((IndexTranslation(:,2)) == Fs);
        % wii = IndexTranslation(waa,1); 
        % Celloutputnondiv(j).MeanSpinVectFluo(1,1) =  Celloutputnondiv(j).SphereMean_along_spin_vect_Lin5(ioa,wii);
        % else
        % Celloutputnondiv(j).MeanSpinVectFluo(1,1) = NaN;    
        % end
        % if ~isnan(Fe)
        % waa = find ((IndexTranslation(:,2)) == Fe);
        % wii = IndexTranslation(waa,1);
        % Celloutputnondiv(j).MeanSpinVectFluo(1,2) =  Celloutputnondiv(j).SphereMean_along_spin_vect_Lin5(ioa,wii);
        % else
        % Celloutputnondiv(j).MeanSpinVectFluo(1,2) = NaN;  
        % end
        close(figure1);
        end
    end