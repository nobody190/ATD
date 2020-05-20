function plot3dPotency(array_x, array_y, array_z, type)
    black_win = blackman(numel(array_x));
    m = abs(fftshift(fft(detrend(array_x).*black_win)));
    p_x = sum(m.^2) / (2*length(m));
    m = abs(fftshift(fft(detrend(array_y).*black_win)));
    p_y = sum(m.^2) / (2*length(m));
    m = abs(fftshift(fft(detrend(array_z).*black_win)));
    p_z = sum(m.^2) / (2*length(m));
    scatter3(p_x, p_y, p_z, type);
    hold on;
end

