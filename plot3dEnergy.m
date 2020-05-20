function plot3dEnergy(array_x, array_y, array_z, type)
    black_win = blackman(numel(array_x));
    m = abs(fftshift(fft(detrend(array_x).*black_win)));
    e_x = sum(m.^2);
    m = abs(fftshift(fft(detrend(array_y).*black_win)));
    e_y = sum(m.^2);
    m = abs(fftshift(fft(detrend(array_z).*black_win)));
    e_z = sum(m.^2);
    scatter3(e_x, e_y, e_z, type);
    hold on;
end
