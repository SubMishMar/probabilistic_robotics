function landmarks = read_world(filename)
    % Reads the world definition and returns a list of landmarks.
    % 
    % The returned structure contains a list of landmarks each with the
    % following information: {id, x, y}
    input = fopen(filename);

    landmarks = struct;

    while(!feof(input))
        line = fgetl(input);
        data = char(strsplit(line, ' '));

        landmark = struct(
            "id", str2num(data(1,:)),
            "x" , str2num(data(2,:)),
            "y" , str2num(data(3,:))
        );
        landmarks(end+1) = landmark;
    endwhile

    landmarks = landmarks(2:end);

    fclose(input);
end
