function plot_file(landmark_locations, x_true, X_samples, pause_time)
    measurement_lineAx = linspace(landmark_locations(1,1), x_true(1), 100);
    measurement_lineAy = linspace(landmark_locations(1,2), x_true(2), 100);
    measurement_lineBx = linspace(landmark_locations(2,1), x_true(1), 100);
    measurement_lineBy = linspace(landmark_locations(2,2), x_true(2), 100);
    measurement_lineCx = linspace(landmark_locations(3,1), x_true(1), 100);
    measurement_lineCy = linspace(landmark_locations(3,2), x_true(2), 100);
    measurement_lineDx = linspace(landmark_locations(4,1), x_true(1), 100);
    measurement_lineDy = linspace(landmark_locations(4,2), x_true(2), 100);
    plot(measurement_lineAx, measurement_lineAy, '--r');
    hold on;
    plot(measurement_lineBx, measurement_lineBy, '--r');
    hold on;
    plot(measurement_lineCx, measurement_lineCy, '--r');
    hold on;
    plot(measurement_lineDx, measurement_lineDy, '--r');
    hold on;
    plot(landmark_locations(:,1), landmark_locations(:,2),'s',...
                                'MarkerSize',25,...
                                'MarkerEdgeColor','r',...
                                'MarkerFaceColor',[0,1,0])
    hold on;
    plot(X_samples(1,:), X_samples(2,:),'o',...
                                'MarkerSize',1,...
                                'MarkerEdgeColor','b',...
                                'MarkerFaceColor',[0,0,1])
    hold on;
    plot(x_true(1), x_true(2),'o',...
                                'MarkerSize',10,...
                                'MarkerEdgeColor','r',...
                                'MarkerFaceColor',[1,0,0]);
    hold off;
    axis square;
    xlim([0 100]);
    ylim([0 100]);
    grid;
    pause(pause_time);   
end