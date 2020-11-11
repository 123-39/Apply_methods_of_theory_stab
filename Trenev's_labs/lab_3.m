clear all;
clc;
% Параметры
k_1 = 2.0;
tau_2 = 4.0;
T_2 = 3.0;
T_31 = 1.5;
zeta_31 = 0.25;
T_32 = 1.0;
zeta_32 = 0.10;
k_4 = 1.0;
% Передаточные функции
W_1 = tf(k_1,[1 0]);
W_2 = tf([tau_2 1],[T_2 -1]);
W_3 = tf([T_31^2 2*zeta_31*T_31 1],[T_32^2 2*zeta_32*T_32 1]);
W_4 = tf(k_4,1);

disp('ПФ размокнутой цепи:');
W_openloop = W_1*W_2*feedback(W_3,W_4)
[p_1,z_1] = pzmap(W_openloop);
disp('Нули:');
disp(z_1);
disp('Полюсы:');
disp(p_1);
% Временные характеристики; ЛАЧХ, ЛФЧХ; Найквист; 
ltiview({'step';'impulse';'bode';'nyquist'},W_openloop); 

disp('ПФ замкнутой цепи:');
W_closedloop = feedback(W_openloop,1)
[p_2,z_2] = pzmap(W_closedloop);
disp('Нули:');
disp(z_2);
disp('Полюсы:');
disp(p_2);
% Временные характеристики; ЛАЧХ, ЛФЧХ; Найквист; 
ltiview({'step';'impulse';'bode';'nyquist'},W_closedloop);

disp('ПФ замкнутой по ошибке цепи:');
W_closedmistakeloop = feedback(1,W_openloop)
[p_3,z_3] = pzmap(W_closedmistakeloop);
disp('Нули:');
disp(z_3);
disp('Полюсы:');
disp(p_3);
% Временные характеристики; ЛАЧХ, ЛФЧХ; Найквист; 
ltiview({'step';'impulse';'bode';'nyquist'},W_closedmistakeloop);