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

disp('Задание 1a.');
disp('Дано: [cosh(at) - cosh(bt)]/t. Найти изображение.')
disp('Получаем следующий предел/интеграл, который надо посчитать руками:');
disp(res1)
disp('Ответ: 1/2 * ln[ (s^2 - a^2) / (s^2 - b^2)]\n');

disp('Задание 1.1a.');
disp('Дано: int([cosh(at) - cosh(bt)]/t, 0, t). Найти изображение.')
disp('Получаем следующий предел/интеграл, который надо посчитать руками:');
disp(res1 / s)
disp('Ответ: 1/(2*s) * ln[ (s^2 - a^2) / (s^2 - b^2)]\n');

or = ilaplace(1/(s^2 - 1)^2);
or_1 = ilaplace(s/(s^2 - 1)^2);
or_2 = ilaplace(s^2/(s^2 - 1)^2);

disp('Задание 1б.');
disp('Дано: 1/(s^2 - 1)^2, s/(s^2 - 1)^2, s^2/(s^2 - 1)^2. Найти оригинал.')
disp('Ответ 1.1б:');
disp(or)
disp('Ответ 1.2б:');
disp(or_1)
disp('Ответ 1.3б:');
disp(or_2)

or_3 = ilaplace((s^3 + s^2 + s - 1) / (s^4 - 1))

disp('Дано: s^3 + s^2 + s - 1 / (s^4 - 1). Найти оригинал.')
disp('Ответ 1d:');

% ------------------------------- task 2 ---------------------------------
% enter syms variable
syms y(t) y0 dy0 s Y

% enter diff
dy(t) = diff(y(t), t);
d2y(t) = diff(dy(t), t);

% Daniil's task
f = d2y(t) + 2*dy(t) + y(t) == exp(-t);

% make beatiful picture
% ищем изображение 
F = laplace(f, t, s);
% Для создания понятного результат заменяем на реальные ГУ
F = subs(F, [laplace(y(t), t, s) dy(0) y(0)], [Y dy0 y0]);
% решаем уравнение относительно изображения Y
Ysol = solve(F, Y);
% переходим обратно в оригинал
f = ilaplace(Ysol);
disp('Задание 2.');
disp('Дано: d2y(t) + 2*dy(t) + y(t) = exp(-t). dy(0) = dy0, y(0) = y0. Найти: y(t).');
disp('Ответ:');
disp(f)


% ------------------------------- task 3 ---------------------------------

syms x1(t) x2(t) X1 X2

dx1(t) = diff(x1(t), t);
dx2(t) = diff(x2(t), t);

% Вводим систему
sys = [dx1(t) == -2*x1(t) + 5*x2(t) + 1, dx2(t) == x1(t) + 2*x2(t) + 1];
% Переход к изображению
SYS = laplace(sys, t, s);
% Для создания понятного результат заменяем на реальные ГУ
SYS = subs(SYS, [laplace(x1(t), t, s) laplace(x2(t), t, s) x1(0) x2(0)], ...
    [X1 X2 0 2]);
% Решаем СЛАУ 
[X1sol, X2sol] = solve(SYS, X1, X2);
% Переходим обратно к оригиналам

real_x1 = ilaplace(X1sol);
real_x2 = ilaplace(X2sol);

disp('Задание 2.');
disp('Дана система: dx1(t) == -2*x1(t) + 5*x2(t) + 1,');
disp('              dx2(t) == x1(t) + 2*x2(t) + 1.');
disp('ГУ: x1(0) = 0, x2(0) = 2. Найти: y(t) = x1(t) + x2(t).');
disp('Ответ:');

disp(real_x1 + real_x2)


