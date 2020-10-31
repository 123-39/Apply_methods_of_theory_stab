% clc
% clear all
% 
% % task 1a)
syms t tau s a b p

% Daniil's task
f1 = cosh(a*t) - cosh(b*t);
% f2 = (cosh(alpha*tau) - cosh(beta*tau)) / tau;
L1 = laplace(f1);
res1 = int(L1, p, +inf);

disp('������� 1a.');
disp('����: [cosh(at) - cosh(bt)]/t. ����� �����������.')
disp('�������� ��������� ������/��������, ������� ���� ��������� ������:');
disp(res1)
disp('�����: 1/2 * ln[ (s^2 - a^2) / (s^2 - b^2)]\n');

disp('������� 1.1a.');
disp('����: int([cosh(at) - cosh(bt)]/t, 0, t). ����� �����������.')
disp('�������� ��������� ������/��������, ������� ���� ��������� ������:');
disp(res1 / s)
disp('�����: 1/(2*s) * ln[ (s^2 - a^2) / (s^2 - b^2)]\n');

or = ilaplace(1/(s^2 - 1)^2);
or_1 = ilaplace(s/(s^2 - 1)^2);
or_2 = ilaplace(s^2/(s^2 - 1)^2);

disp('������� 1�.');
disp('����: 1/(s^2 - 1)^2, s/(s^2 - 1)^2, s^2/(s^2 - 1)^2. ����� ��������.')
disp('����� 1.1�:');
disp(or)
disp('����� 1.2�:');
disp(or_1)
disp('����� 1.3�:');
disp(or_2)

or_3 = ilaplace((s^3 + s^2 + s - 1) / (s^4 - 1))

disp('����: s^3 + s^2 + s - 1 / (s^4 - 1). ����� ��������.')
disp('����� 1d:');

% ------------------------------- task 2 ---------------------------------
% enter syms variable
syms y(t) y0 dy0 s Y

% enter diff
dy(t) = diff(y(t), t);
d2y(t) = diff(dy(t), t);

% Daniil's task
f = d2y(t) + 2*dy(t) + y(t) == exp(-t);

% make beatiful picture
% ���� ����������� 
F = laplace(f, t, s);
% ��� �������� ��������� ��������� �������� �� �������� ��
F = subs(F, [laplace(y(t), t, s) dy(0) y(0)], [Y dy0 y0]);
% ������ ��������� ������������ ����������� Y
Ysol = solve(F, Y);
% ��������� ������� � ��������
f = ilaplace(Ysol);
disp('������� 2.');
disp('����: d2y(t) + 2*dy(t) + y(t) = exp(-t). dy(0) = dy0, y(0) = y0. �����: y(t).');
disp('�����:');
disp(f)


% ------------------------------- task 3 ---------------------------------

syms x1(t) x2(t) X1 X2

dx1(t) = diff(x1(t), t);
dx2(t) = diff(x2(t), t);

% ������ �������
sys = [dx1(t) == -2*x1(t) + 5*x2(t) + 1, dx2(t) == x1(t) + 2*x2(t) + 1];
% ������� � �����������
SYS = laplace(sys, t, s);
% ��� �������� ��������� ��������� �������� �� �������� ��
SYS = subs(SYS, [laplace(x1(t), t, s) laplace(x2(t), t, s) x1(0) x2(0)], ...
    [X1 X2 0 2]);
% ������ ���� 
[X1sol, X2sol] = solve(SYS, X1, X2);
% ��������� ������� � ����������

real_x1 = ilaplace(X1sol);
real_x2 = ilaplace(X2sol);

disp('������� 2.');
disp('���� �������: dx1(t) == -2*x1(t) + 5*x2(t) + 1,');
disp('              dx2(t) == x1(t) + 2*x2(t) + 1.');
disp('��: x1(0) = 0, x2(0) = 2. �����: y(t) = x1(t) + x2(t).');
disp('�����:');

disp(real_x1 + real_x2)


