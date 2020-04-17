
clearvars; close all; clc;
addpath('./utils');

%% Forward model
x_orig = im2double(imread('./house.tif')); % Ground-truth
r = 0.7;                % Fraction of missing pixels
sigma_n = 10/255;       % Noise standard deviation (on a scale of [0,1])

[rr,cc] = size(x_orig);
P = double(rand(rr,cc)>=r);     % Decimation operator
b = P.*x_orig;
b(P==1) = b(P==1) + sigma_n*randn(nnz(P),1);    % Observed image
b(b>1) = 1; b(b<0) = 0;
gradf = @(x) P.*(x-b);      % Gradient of data fidelity term (f)

imshow(b); title('Input (decimated) image');
pause(0.1); drawnow;

%% Algorithm parameters
searchRad = 10;             % Search window radius in NLM
patchRad = 3;               % Patch radius in NLM
h = 40/255;                 % Gaussian parameter in NLM
delta = 0.9;                % Step-size in PnP-ISTA
tol = 1e-5;                 % Tolerance for termination of algorithm
maxiters = 200;             % Max. no. of iterations

%% Main algorithm
x0 = initInpainting(b,P==0,5);  % Initial point to start the iterations
figure; imshow(x0); title('Initialization');
pause(0.1); drawnow;

W = @(x) JNLM(x,x0,patchRad,searchRad,h);   % Linear NLM denoiser
[x_hat,converged,iters,errors,psnrs] = ...
        pnpISTA(x0,gradf,W,delta,x_orig,tol,maxiters);  % Run algorithm

fprintf('\nNo. of iterations completed = %d\n',iters);

figure; imshow(x_hat); title('Output');
drawnow;
figure;
subplot(1,2,1); plot(errors,'LineWidth',2);
grid on; axis tight; xlabel('Iteration'); ylabel('Error');
title('Error');
subplot(1,2,2); plot(psnrs,'LineWidth',2);
grid on; axis tight; xlabel('Iteration'); ylabel('PSNR');
title('PSNR');
drawnow;

