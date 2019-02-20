function plot_psd(signal_type,a,f,d,Fs,D)

% parameters
dt = 1/Fs;      % sampling interval
N = Fs*D;       % length of total (samples)
NFFT = N*16;       % length of signal (samples)
T = 0:dt:D-dt;  % timesteps of total

figure
cnt=1;
for(ii = 1:length(a))
    a_i = a(ii); % amplitude
    for(jj = 1:length(f))
        f_i = f(jj); % frequency        
        for(kk = 1:length(d))
            d_i = d(kk); % duration
            
            % length of signal (samples)
            n = Fs*d_i;     
            
            % start of signal (samples)
            s0 = N/2-n/2;
            
            % timesteps of signal
            t = 0:dt:d_i-dt;
            
            % create pad
            pad = zeros(1,s0);
            
            % create signal
            switch lower(signal_type)                
                case 'noise'
                    y = a_i/2*randn(1,n);
                    f_i = NaN; % frequency doesn't apply here
                case 'sine'
                    y = a_i*sin(2*pi*f_i*t);
                case 'pulse'
                    y = a_i*gauspuls(t,f_i,0.5,-30);
                case 'pulsetrain'                    
                    
                    % create single pulse
                    y_pulse = a_i*gauspuls(t,f_i,0.5,-30);
                    
                    % number of pulses
                    npls = 3;

                    % crop single pulse
                    pls = y_pulse(1:floor(n/npls));

                    % repeat single pulse
                    pls = repmat(pls,1,npls);

                    % combine in zero-padded array
                    y = zeros(1,n);
                    y(1:length(pls)) = pls;
                
                case 'chirp'
                    y = chirp(t,f_i/2,d_i,f_i,'linear', -90);
            end

            % pad signal
            Y = [pad y pad];
            
            % power spectral density
            [psd,f_psd] = periodogram(Y,rectwin(N),NFFT,Fs, 'psd');
            
            % calculate energy
            E = sum(psd*Fs*N)/NFFT;

            % calculate power
            P = E / N;         
            
            % plot            
            subplot(length(a)*length(f)*length(d)/2,2,cnt)
            plot(f_psd,10*log10(psd)); grid on;
            ylim([-60 10])
            xlim([0 2*max(f)])
            ylabel('Power/frequency [dB/Hz]')
            xlabel('Normalized frequency [Hz]')
            title({'Power spectral density',...
                sprintf('Amplitude: %1d  Duration: %1d  Frequency: %1d', a_i, d_i, f_i),...
                sprintf('Energy: %.0f   Power: %.02f', E, P)})
            
            % update counter
            cnt=cnt+1;
        end
    end
end

set(gcf, 'PaperPosition', [0 0 20 24]); % increase figure size
return