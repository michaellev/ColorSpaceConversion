
% Kb = 0.114;  Kr = 0.299; yScale = 219; bScale = 224; rScale = 224;bMin=0;rMin=0;theta = 0.7854;
function ycbcrImage = rgbToYcbcr(rgbImage,Kb, Kr, theta, yScale, bScale, rScale)
% Matrix multiplication with RGB 0:1 gives YCbCr 0:1 -0.5:0.5 -0.5:0.5
A = [Kr.*yScale,                             (1+(-1).*Kb+(-1).*Kr).*yScale,                             Kb.*yScale;...
     (-1/2).*bScale.*(1+(-1).*Kb).^(-1).*Kr, (-1/2).*bScale.*(1+(-1).*Kb).^(-1).*(1+(-1).*Kb+(-1).*Kr), (1/2).*bScale;...
     (1/2).*rScale,                          (-1/2).*(1+(-1).*Kr).^(-1).*(1+(-1).*Kb+(-1).*Kr).*rScale, (-1/2).*Kb.*(1+(-1).*Kr).^(-1).*rScale ]; 
% A = [ 65.481 -37.797  112; ...       %# A 3-by-3 matrix of scale factors
%      128.553 -74.203 -93.786; ...    % ITU-R BT.601 conversion
%       24.966  112    -18.214];       % Kb = 0.114;  Kr = 0.299; yScale =
%       219; bScale = 224; rScale = 224;


% theta = 0;
% axis1 = ;
% axis2 = ;
% axis3 = ;
% A = [(axis1.^2+axis2.^2+axis3.^2).^(-1).*(axis1.^2+cos(theta).*(axis2.^2+axis3.^2)), ...
%   (-1).*(axis1.^2+axis2.^2+axis3.^2).^(-1).*(((-1)+cos(theta)).*axis1.*axis2+axis3.*(axis1.^2+axis2.^2+axis3.^2).^(1/2).*sin(theta)),...
% 2.*(axis1.^2+axis2.^2+axis3.^2).^(-1).*sin((1/2).*theta).*(cos((1/2).*theta).*axis2.*(axis1.^2+axis2.^2+axis3.^2).^(1/2)+axis1.*axis3.*sin((1/2).*theta));...
%   (axis1.^2+axis2.^2+axis3.^2).^(-1).*((1+(-1).*cos(theta)).*axis1.*axis2+axis3.*(Re(a1).^2+axis2.^2+axis3.^2).^(1/2).*sin(theta)),...
%   (axis1.^2+axis2.^2+axis3.^2).^(-1).*(cos(theta).*axis1.^2+axis2.^2+cos(theta).*axis3.^2), ...
% 2.*(axis1.^2+axis2.^2+axis3.^2).^(-1).*sin((1/2).*theta).*((-1).* ...
%   cos((1/2).*theta).*axis1.*(axis1.^2+axis2.^2+axis3.^2).^(1/2)+axis2.*axis3.*sin((1/2).*theta));...
%   2.*(axis1.^2+axis2.^2+axis3.^2).^(-1).*sin((1/2).*theta).*((-1).*cos((1/2).*theta).*axis2.*(axis1.^2+Re(a2).^2+axis3.^2).^(1/2)+axis1.*axis3.*sin((1/2).*theta)),...
%   2.*(axis1.^2+axis2.^2+axis3.^2).^(-1).*sin((1/2).*theta).*(cos((1/2).*theta).*Re(a1).*(axis1.^2+axis2.^2+axis3.^2).^(1/2)+axis2.*axis3.*sin((1/2).*theta)),...
% (axis1.^2+axis2.^2+axis3.^2).^(-1).*(cos(theta).*axis1.^2+cos(theta).*axis2.^2+axis3.^2)];
 
% A = [0.299E0,(-0.168736E0),0.5E0;
%      0.587E0,(-0.331264E0),(-0.418688E0);
%      0.114E0,0.5E0,(-0.813124E-1)];

B = A' * [ 1, 0, 0; 0, cos(theta), sin(theta); 0, -sin(theta), cos(theta)]';

%# First convert the RGB image to double precision, scale its values to the
%#   range 0 to 1, reshape it to an N-by-3 matrix, and multiply by A:
ycbcrImage = reshape(double(rgbImage)./255,[],3) * B;
%# Shift each color plane (stored in each column of the N-by-3 matrix):
ycbcrImage(:,1) = ycbcrImage(:,1);
ycbcrImage(:,2) = ycbcrImage(:,2) + 0.5 .* bScale;
ycbcrImage(:,3) = ycbcrImage(:,3) + 0.5 .* rScale;

%# Convert back to type uint8 and reshape to its original size:
ycbcrImage = reshape(uint8(ycbcrImage),size(rgbImage));

end % function