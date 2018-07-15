function prob = measurement_probability(predicted_measurement, ... 
                                        measurement, sensor_noise)
  prob = 1;
  sigma_z2 = sensor_noise.^2;
  K = 1/sqrt(2*pi*sigma_z2);
  for i = 1:length(predicted_measurement)
      prob = prob*K*...
          exp(-((measurement(i) - predicted_measurement(i))^2)/(2*sigma_z2));
  end
end