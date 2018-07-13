% Read world data, i.e. landmarks
printf("Reading world data ...");fflush(stdout);
landmarks = read_world('../data/world.dat');
printf(" done\n\n");fflush(stdout);
disp("landmark 1 is:");
disp(landmarks(1));


particles = [0 0 0; 0.1 0.1 0; 0 0.1 0; -0.2 0.1 0.5];
z = struct;
z.id = 1;
z.range = 2.3;
likelihoods = measurement_model(z, particles, landmarks);
normalized_likelihoods = likelihoods' ./ sum(likelihoods)
disp("expecting normalized_likelihoods = 0.28283   0.18268   0.25808   0.27641");


% verify output
