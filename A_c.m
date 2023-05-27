function A_c = A_c(t_n)
global tau K Ks k_0 gamma
A_c = [ k_0*t_n/tau+Ks -Ks; -Ks K+Ks ]/gamma;