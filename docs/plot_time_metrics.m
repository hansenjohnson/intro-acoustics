function plot_time_metrics(signal_type,a,f,d,Fs,D)
%% plot_time_metrics(signal_type,a,f,d,Fs,D)

dt = 1/Fs;      % sampling interval
N = Fs*D;       % length of total (samples)
T = 0:dt:D-dt;  % timesteps of total

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
                    y = chirp(t,0,d_i,f_i,'linear', -90);
            end

            % pad signal
            Y = [pad y pad];

            % calculate energy
            E = sum(Y.^2)*dt;

            % calculate power
            P = E / n*dt;

            % calculate RMS
            RMS = sqrt(P);

            % calculate zero to peak
            P0 = max(abs(Y));

            % calculate peak to peak
            PP = max(Y)-min(Y);

            % plot
            subplot(length(a)*length(f)*length(d)/2,2,cnt)
            plot(T, Y)
            ylim([-max(a) max(a)]*2)
            title({sprintf('Amplitude: %1d  Duration: %1d  Frequency: %1d', a_i, d_i, f_i),...
                sprintf('Energy: %2f  Power: %2f', E, P),...
                sprintf('RMS: %2f, P0: %2f, PP: %2f', RMS, P0, PP)})

            % update counter
            cnt=cnt+1;
        end
    end
end

set(gcf, 'PaperPosition', [0 0 20 24]); % increase figure size

return