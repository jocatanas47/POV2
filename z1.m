clear;
close all;
clc;

% generisemo unimodalnu i polimodalnu gausovu
N = 1000;
M1 = [0 0]';
S1 = [1 0.5; 0.5 1];
M2 = [5 0]';
S2 = [1.5 -0.7; -0.7 1.5];
M3 = [6 6]';
S3 = [1 0.6; 0.6 1];

K1 = mvnrnd(M1, S1, N); %klasa jedan - unimodalna

% pomocne promenjive
pom = rand(N, 1);
K21 = mvnrnd(M2, S2, N);
K22 = mvnrnd(M3, S3, N);
K2 = (pom < 0.6).*K21 + (pom >= 0.6).*K22;

figure(1);
hold all;
scatter(K1(:, 1), K1(:, 2), 'ro');
scatter(K2(:, 1), K2(:, 2), 'bo');
grid on;

% Bayes-ov klasifikator minimalne greske

x = -5:0.1:12;
y = -5:0.1:12;
f1 = zeros(length(x), length(y));
f2 = zeros(length(x), length(y));
const1 = 1/(2*pi*det(S1))^0.5;
const2 = 1/(2*pi*det(S2))^0.5;
const3 = 1/(2*pi*det(S3))^0.5;
for i = 1:length(x)
    for j = 1:length(y)
        X = [x(i) y(j)]';
        f1(i, j) = const1*exp(-0.5*(X - M1)'*inv(S1)*(X - M1));
        f21 = const2*exp(-0.5*(X - M2)'*inv(S2)*(X - M2));
        f22 = const3*exp(-0.5*(X - M3)'*inv(S3)*(X - M3));
        f2(i, j) = 0.6*f21 + 0.4*f22;
    end
end

figure(1)
h = -log(f1./f2); % f-ja h u svakoj tacki prostora
contour(x, y, h', [0 0], 'g', 'Linewidth', 1.5);

% formula
% f1/f2 > (c12 - c22)/(c21 - c11) -> w1
% < -> w2
% cij - cena smestanja j-te klase u i-tu
% c11 = c22 = 0