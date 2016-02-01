function [fitresult, gof] = createFitSpl(x, f1, smooth)
%CREATEFITSPL(X,F1)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : x
%      Y Output: f1
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
s=0.1;
if (exist('smooth','var'))
    s=smooth;
end

%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( x, f1 );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = s;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

%%
% % Plot fit with data.
% figure( 'Name', 'fit' );
% h = plot( fitresult, xData, yData );
% legend( h, 'f1 vs. x', 'fit', 'Location', 'NorthEast' );
% % Label axes
% xlabel x
% ylabel f1
% grid on


