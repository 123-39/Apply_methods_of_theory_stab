clear all;
clc;
syms s
k = 30;
tau = 0.1;
zeta = 0.5;
omega = 1/tau;
W(1) = tf(k,1);
% Почти идеальное дифф. звено
W(2) = tf([1 0],[1e-16 1]);
W(3) = tf(1,[1 0]);
W(4) = tf(1,[tau 1]);
W(5) = tf(omega^2,[1 2*zeta*omega 1]);
% Переходная функция; Весовая функция; АЧХ; ЛАЧХ, ЛФЧХ;
for i=1:5
    ltiview({'step';'impulse';'nyquist';'bode'},W(i)); 
end