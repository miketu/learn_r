require(fftpipe)

wv <- waveform(duration_s = 1.0, sr = 100) %>%
    cos_sum(freqs = c(1.0), amplitudes = c(1)) %>%
    length_norm()

waveform_plot(wv*1)+ylim(c(-0.05,0.05))+xlim(c(0,1))

waveform_plot(wv+0.01)+ylim(c(-0.05,0.05))+xlim(c(0,1))

wv_fft <- compute_fft(wv) 

fft_plot(wv_fft)
