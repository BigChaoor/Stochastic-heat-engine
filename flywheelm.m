%% parameter settings
global D_h D_eta D_c tau tau_eta K Ks k_0 gamma
D_h = 2; D_eta = 10; D_c = 0.1; tau = 1; tau_eta = 1;
K = 0.1; Ks = 10; k_0 = 10; gamma = 1;

%% Brown motion simulation
M = 5000; N = 500; h = 0.5/N; t = 0:h:tau;
b_h = [sqrt(D_h); sqrt(D_h)]/gamma; b_c = [sqrt(D_c); sqrt(D_c)]/gamma;
d_eta = [sqrt(D_eta/tau_eta); 0]/gamma; 
W = sqrt(h)*randn(2*N,M);  % Brown运动增量的模拟

%% compute
x = zeros(2,2*N+1, M); eta = zeros(2*N+1, M);
for m = 1:M
    for n = 1:N-1
        x(:,n+1,m) = x(:,n,m) - A_e(t(n))*x(:,n,m)*h + b_h*W(n,m);
        eta(n+1,m) = eta(n,m) - 1/tau_eta*eta(n,m)*h + sqrt(2/tau_eta)*W(n,m);
    end
    for n = N:2*N
        x(:,n+1,m) = x(:,n,m) - A_c(t(n))*x(:,n,m)*h + b_c*W(n,m) + d_eta*eta(n,m)*h;
        eta(n+1,m) = eta(n,m) - 1/tau_eta*eta(n,m)*h + sqrt(2/tau_eta)*W(n,m);
    end
end

%% plot
sigma_f = sum(x(2,:,:).^2,3)/M;
hold on
plot(t, sigma_f, 'r', 'LineWidth',1)

figure
for i =1:3
    plot(t, x(2,:,i^7))
    hold on
end