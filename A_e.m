function A_e = A_e(t_n)
global tau K Ks k_0 gamma
A_e = [ k_0*(1-t_n/tau)+Ks -Ks; -Ks K+Ks ]/gamma;