function data = read_data(filename)
    % Reads the odometry and sensor readings from a file.
    %
    % The data is returned in a structure where the u_t and z_t are stored
    % within a single entry. The i-th pair of odometry and measurements are
    % accessed as follows
    % data.timestep(i)
    % this returns a structure of the following type
    % {
    %   odometry,
    %   sensor
    % }
    % where "odometry" has the fields r1, r2, t which contain the values of
    % the identically named motion model variables, and sensor is a list of
    % sensor readings with id, range, bearing as values.
    input = fopen(filename);

    data = struct;
    data.timestep.sensor = struct;
    first = 1;

    odom = struct;
    sensor = struct;

    while(!feof(input))
        line = fgetl(input);
        arr = char(strsplit(line, ' '));
        type = deblank(arr(1,:));

        if(strcmp(type, 'ODOMETRY') == 1)
            if(first == 0)
                data.timestep(end+1).odometry = odom;
                data.timestep(end).sensor = sensor(2:end);
                odom = struct;
                sensor = struct;
            endif
            first = 0;
            odom.r1 = str2num(arr(2,:));
            odom.t  = str2num(arr(3,:));
            odom.r2 = str2num(arr(4,:));
        elseif(strcmp(type, 'SENSOR') == 1)
            reading = struct;
            reading.id      = str2num(arr(2,:));
            reading.range   = str2num(arr(3,:));
            reading.bearing = str2num(arr(4,:));
            sensor(end+1) = reading;
        endif
    endwhile

    data.timestep = data.timestep(2:end);

    fclose(input);
end
