function [steps] = drawDft(array_x,array_y, array_z, figure_num, activitie_name)
    Fs = 50;
    N = numel(array_x); %Peri�do Fundamental
    t = linspace(0,(N-1)/Fs,N);

    if (mod(N,2)==0)
        f = -Fs/2:Fs/N:Fs/2-Fs/N;
    else
        f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
    end
    %BLACKMAN WINDOWS
    black_win_x = blackman(numel(array_x));
    dft_black_x = fftshift(fft(detrend(array_x).*black_win_x));
    m_black_x = abs(dft_black_x); 

    black_win_y = blackman(numel(array_y));
    dft_black_y = fftshift(fft(detrend(array_y).*black_win_y));
    m_black_y = abs(dft_black_y);

    black_win_z = blackman(numel(array_z));
    dft_black_z = fftshift(fft(detrend(array_z).*black_win_z));
    m_black_z = abs(dft_black_z);

    %HAMMING WINDOWS
    hamm_win_x = hamming(numel(array_x));
    dft_hamm_x = fftshift(fft(detrend(array_x).*hamm_win_x));
    m_hamm_x = abs(dft_hamm_x); 

    hamm_win_y = hamming(numel(array_y));
    dft_hamm_y = fftshift(fft(detrend(array_y).*hamm_win_y));
    m_hamm_y = abs(dft_hamm_y); 

    hamm_win_z = hamming(numel(array_z));
    dft_hamm_z = fftshift(fft(detrend(array_z).*hamm_win_z));
    m_hamm_z = abs(dft_hamm_z); 
    %HANNING WINDOWS
    hann_win_x = hanning(numel(array_x));
    dft_hann_x = fftshift(fft(detrend(array_x).*hann_win_x));
    m_hann_x = abs(dft_hann_x);

    hann_win_y = hanning(numel(array_y));
    dft_hann_y = fftshift(fft(detrend(array_y).*hann_win_y));
    m_hann_y = abs(dft_hann_y);

    hann_win_z = hanning(numel(array_z));
    dft_hann_z = fftshift(fft(detrend(array_z).*hann_win_z));
    m_hann_z = abs(dft_hann_z);
    %STEPS
    [~, pks_f] = findpeaks(m_hamm_x);
    Ts = 1/pks_f(1);
    steps = 60/Ts;


    figure(figure_num)
    subplot(2, 2, 1)
    plot(t,array_x)
    axis tight
    xlabel('t [s]')
    ylabel('Amplitude')
    title(activitie_name)
    subplot(2, 2, 2)
    p1 = plot(f,m_black_x, 'r'); hold on;
    p2 = plot(f,m_hamm_x, 'b');
    p3 = plot(f,m_hann_x, 'g'); hold off;
    title('|DFT| WINDOWS X');
    ylabel('Magnitude = |X|')
    xlabel('f [Hz]')
    legend([p1; p2; p3], 'BLACKMAN', 'HAMMING', 'HANNING');
    axis tight

    subplot(2, 2, 3)
    p1 = plot(f,m_black_y, 'r'); hold on;
    p2 = plot(f,m_hamm_y, 'b');
    p3 = plot(f,m_hann_y, 'g'); hold off;
    title('|DFT| WINDOWS Y');
    ylabel('Magnitude = |X|')
    xlabel('f [Hz]')
    legend([p1; p2; p3], 'BLACKMAN', 'HAMMING', 'HANNING');
    axis tight

    subplot(2, 2, 4)
    p1 = plot(f,m_black_z, 'r'); hold on;
    p2 = plot(f,m_hamm_z, 'b');
    p3 = plot(f,m_hann_z, 'g'); hold off;
    title('|DFT| WINDOWS Z');
    ylabel('Magnitude = |X|')
    xlabel('f [Hz]')
    legend([p1; p2; p3], 'BLACKMAN', 'HAMMING', 'HANNING');
    axis tight
end

