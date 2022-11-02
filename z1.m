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