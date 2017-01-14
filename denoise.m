
function denoise()
[data.numerical,data.rext]=xlsread(fullfile(pwd,'total_flight.xlsx')); 
data__accel_z = data.numerical(:,63);
f = [-1*ones(1000,1);3*ones(100,1);1*ones(500,1);-2*ones(800,1);0*ones(900,1)];
plot(f);
axis([1 length(f) -4 4]);
title('Original');
%g = f + .25*randn(length(f),1);
g = data__accel_z;
figure;
plot(g,'r');
title('Noisy');
axis([1 length(g) -4 4]);
fc = denoisetv(g,0.1);
figure;
plot(fc,'g');
title('De-noised');
axis([1 length(f) -4 4]);

function f = denoisetv(g,mu)
I = length(g);
u = zeros(I,1);
y = zeros(I,1);
rho = 1;

eigD = abs(fftn([-1;1],[I 1])).^2;
for k=1:100
    f = real(ifft(fft(mu*g+rho*Dt(u)-Dt(y))./(mu+rho*eigD)));
    v = D(f)+(1/rho)*y;
    u = max(abs(v)-1/rho,0).*sign(v);
    y = y - rho*(u-D(f));
end

function y = D(x)
y = [diff(x);x(1)-x(end)];

function y = Dt(x)
y = [x(end)-x(1);-diff(x)];