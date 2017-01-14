%take data to be filtered
g = data__accel_x;

%plot raw data
figure;
plot(g,'r');
title('Noisy');
xlabel('Sample');
%axis([1 length(g) -4 4]);

%use the denoise function 
%tune 'um' to your taste
fc = denoisetv(g,0.01);

%plot denoised data
figure;
plot(fc,'g');
title('De-noised');
xlabel('Sample');
%axis([1 length(f) -4 4]);

%define denoise function
%algorithm is based on this paper http://www.ccom.ucsd.edu/~peg/papers/ALvideopaper.pdf
function f = denoisetv(g,mu)
I = length(g);
u = zeros(I,1);
y = zeros(I,1);
%tune rho to your taste
rho = 1;

%to do: translate fft, ifft and fftn to C
eigD = abs(fftn([-1;1],[I 1])).^2;
for k=1:100
    f = real(ifft(fft(mu*g+rho*Dt(u)-Dt(y))./(mu+rho*eigD)));
    v = D(f)+(1/rho)*y;
    u = max(abs(v)-1/rho,0).*sign(v);
    y = y - rho*(u-D(f));
end

function y = D(x)
y = [diff(x);x(1)-x(end)];
end

function y = Dt(x)
y = [x(end)-x(1);-diff(x)];
end
end