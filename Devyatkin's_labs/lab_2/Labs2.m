clear all;
clc;

% for W_1
k_1 = 8;

% for W_2
tau_2 = 3;
T_2 = 2;

% for W_3
T_31 = 2;
zetta_31 = 0.75;
T_32 = 3;
zetta_32 = 0.5;
% -------------------------------------------------------------------------
% for W_4
k_4 = 8;

%         8
% W_1 =  ---
%         s
W_1 = tf(k_1, [1 0]);

%       3 s + 1
% W_2 = -------
%       2 s - 1
W_2 = tf([tau_2 1],  [T_2, - 1]);

%       4 s^2 + 3 s + 1
% W_3 = ---------------
%       9 s^2 + 3 s + 1
W_3 = tf([T_31^2 2*zetta_31*T_31 1], ...  
         [T_32^2 2*zetta_32*T_32 1]);    
                                         
% W_4 = k_4                                     
W_4 = tf(k_4, 1);

% build openloop system
W_openloop = W_1 * W_2 * feedback(W_3, W_4);

% build closeloop system
W_closewloop = feedback(W_openloop, 1, -1);

% build closeloop system
W_close_error_loops = feedback(1, W_openloop, -1);

% -------------------- Search root and pole for transfer function ---------

pole_root(W_openloop);

pole_root(W_closewloop);

pole_root(W_close_error_loops);

% Timing characteristic; ËÀ×Õ, ËÔ×Õ (bode); Nyquist; 
ltiview({'step';'impulse';'bode';'nyquist'}, W_openloop);
ltiview({'step';'impulse';'bode';'nyquist'}, W_closewloop);
ltiview({'step';'impulse';'bode';'nyquist'}, W_close_error_loops);

function [] = pole_root(transfer_function)
    
    [p, z] = pzmap(transfer_function);
    disp("Roots for close error loop: ");
    disp(z);
    disp("Poles for close error loop: ");
    disp(p);
end




