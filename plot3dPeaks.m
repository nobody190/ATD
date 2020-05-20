function plot3dPeaks(array_x, array_y, array_z, type)
    black_win = blackman(numel(array_x));
    m = abs(fftshift(fft(detrend(array_x).*black_win)));
    [m_x, ~] = findpeaks(m);
    m = abs(fftshift(fft(detrend(array_y).*black_win)));
    [m_y, ~] = findpeaks(m);
    m = abs(fftshift(fft(detrend(array_z).*black_win)));
	[m_z, ~] = findpeaks(m);
    scatter3(m_x(1), m_y(1), m_z(1), type);
    hold on;
end

