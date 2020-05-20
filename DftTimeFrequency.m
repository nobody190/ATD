function [steps] = DftTimeFrequency(array_z, figure_num, activitie_name)
    Fs = 50;
    N = numel(array_z); %Periódo Fundamental
    t = linspace(0,(N-1)/Fs,N);

    if (mod(N,2)==0)
        f = -Fs/2:Fs/N:Fs/2-Fs/N;
    else
        f = -Fs/2+Fs/(2*N):Fs/N:Fs/2-Fs/(2*N);
    end
    %DFT RECTANGULAR WINDOW  
    dft_z = fftshift(fft(detrend(array_z)));
    m_z = abs(dft_z); 
    
    %BLACKMAN WINDOWS
    black_win_z = blackman(numel(array_z));
    dft_black_z = fftshift(fft(detrend(array_z).*black_win_z));
    m_black_z = abs(dft_black_z);

    %HAMMING WINDOWS
    hamm_win_z = hamming(numel(array_z));
    dft_hamm_z = fftshift(fft(detrend(array_z).*hamm_win_z));
    m_hamm_z = abs(dft_hamm_z); 
    
    %HANNING WINDOWS
    hann_win_z = hanning(numel(array_z));
    dft_hann_z = fftshift(fft(detrend(array_z).*hann_win_z));
    m_hann_z = abs(dft_hann_z);
    %STEPS
    [~, pks_f] = findpeaks(m_hamm_z);
    Ts = 1/pks_f(1);
    steps = 60/Ts;


    figure(figure_num)
    subplot(2, 2, 1)
    plot(t,array_z)
    axis tight
    xlabel('t [s]')
    ylabel('Amplitude')
    title(activitie_name)
    
    subplot(2, 2, 2)
    p0 = plot(f,m_z, 'y');hold on;
    p1 = plot(f,m_black_z, 'r');
    p2 = plot(f,m_hamm_z, 'b');
    p3 = plot(f,m_hann_z, 'g'); hold off;
    title('|DFT| WINDOWS Z');
    ylabel('Magnitude = |X|')
    xlabel('f [Hz]')
    legend([p0; p1; p2; p3], 'RECTANGULAR', 'BLACKMAN', 'HAMMING', 'HANNING');
    axis tight
end