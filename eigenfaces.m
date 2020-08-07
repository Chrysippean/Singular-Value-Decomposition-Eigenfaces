%% Daniel Nguyen, AMATH 482, Assignment 1

%%% Cropped Yale
clear all;
close all;

cd '/Users/danielnn/Documents/MATLAB/CroppedYale'

CYfiles = dir(pwd);
CYcount = 1;
CYimages = [];
for i = 4:length(CYfiles)
  direct = strcat(pwd, '/', CYfiles(i).name);
  cd(direct);
  CYimgs = dir(direct);
  for j = 3:length(CYimgs)
  CYimg = imread(CYimgs(j).name);
  CYimages(:,CYcount) = CYimg(:);
  CYcount = CYcount + 1;
  end
  cd ..
end

%%
[CY_U, CY_S, CY_V] = svd(CYimages, 'econ');

%%
CYsing_val = diag(CY_S);
% plot(sing_val)
figure('Name', 'Singular Values Plotted on a Log Scale for CY', 'IntegerHandle', 'off')
semilogy(CYsing_val, '.')
title('Logarithmic Comparison of Singular Values for CY')
xlabel('Log Value')
ylabel('CY Singular Modes')
CYsing_val_percent = CYsing_val * 100 / sum(CYsing_val);

for i = 2:length(CYsing_val)
  CYsing_val_percent(i) = CYsing_val_percent(i) + CYsing_val_percent(i-1);
end

figure('Name', 'Cumulative Accuracy for CY', 'IntegerHandle', 'off')
plot(CYsing_val_percent)
title('Cumulative Percentages of Accuracy with Increasing Singular Modes for CY')
xlabel('CY Singular Modes')
ylabel('Percentage')
grid on

%%
figure(3)
subplot(2,1,1), plot(CY_U(:,2368))
legend('Mode 2368')
title('Modes of U')
xlabel('Image Pixels')
ylabel('U Values')
subplot(2,1,2), plot(CY_U(:,2368))
legend('Mode 2368')
title('Modes of V')
xlabel('Range of Images')
ylabel('V Values')
suptitle('Covariance of CY Mode 2368 Over Images')

%%
 CY_modes = [1 1 5 10 20 50 100 250 500 1000 2000 2368];
 CY_pic = 1;
 figure('Name', strcat('Face ', int2str(CY_pic)), 'IntegerHandle', 'off')
for i = 2:length(CY_modes)
  CY_m_num = CY_modes(i);
  CY_A1 = CY_U(:,1:CY_m_num)*CY_S(1:CY_m_num,1:CY_m_num)*CY_V(:,1:CY_m_num).';
  figure_title = strcat(int2str(CY_modes(i-1)), ' Modes');
  figure_title = strcat(figure_title, ' (', num2str(CYsing_val_percent(CY_modes(i-1))), ' % Accuracy)');
  title(figure_title)
  subplot(3,4,i-1)
  image(reshape(CY_A1(:,CY_pic),192,168));
end
title(strcat(int2str(2368), ' Modes', ', ', '100% Accuracy'));
suptitle(strcat('Face (', int2str(CY_pic), ')'))

%%
cd '/Users/danielnn/Documents/MATLAB/yalefaces'

YFfiles = dir(pwd);
YFcount = 1;
YFimages = [];
YFimgs = dir();
for i = 3:length(YFfiles)
  YFimg = imread(YFimgs(i).name);
  YFimages(:,YFcount) = YFimg(:);
  YFcount = YFcount + 1;
end

%%
[YF_U,YF_S, YF_V] = svd(YFimages, 'econ');

%% Yale Faces

YFsing_val = diag(YF_S);
% plot(sing_val)
figure('Name', 'Singular Values Plotted on a Log Scale for YF', 'IntegerHandle', 'off')
semilogy(YFsing_val, '.')
title('Logarithmic Comparison of Singular Values for YF')
xlabel('Log Value')
ylabel('YF Singular Modes')
YFsing_val_percent = YFsing_val * 100 / sum(YFsing_val);

for i = 2:length(YFsing_val)
  YFsing_val_percent(i) = YFsing_val_percent(i) + YFsing_val_percent(i-1);
end

figure('Name', 'Cumulative Accuracy for YF', 'IntegerHandle', 'off')
plot(YFsing_val_percent)
title('Cumulative Percentages of Accuracy with Increasing Singular Modes for YF')
xlabel('YF Singular Modes')
ylabel('Percentage')
grid on

%%
figure(3)
subplot(2,1,1), plot(YF_U(:,1:3))
legend('Mode 1', 'Mode 2', 'Mode 3')
title('Modes of U')
xlabel('Image Pixels')
ylabel('U Values')
subplot(2,1,2), plot(YF_V(:,1:3))
legend('Mode 1', 'Mode 2', 'Mode 3')
title('Modes of V')
xlabel('Range of Images')
ylabel('V Values')
suptitle('Covariance of YF Modes 1, 2 and 3 Over Images')

%%
YF_modes = [1 1 5 10 20 50 100 150 165];
YF_pic = 1;
figure('Name', strcat('Face ', int2str(YF_pic)), 'IntegerHandle', 'off')
for i = 2:length(YF_modes)
  YF_m_num = YF_modes(i);
  YF_A1 = YF_U(:,1:YF_m_num)*YF_S(1:YF_m_num,1:YF_m_num)*YF_V(:,1:YF_m_num).';
  figure_title = strcat(int2str(YF_modes(i-1)), ' Modes');
  figure_title = strcat(figure_title, ' (', num2str(YFsing_val_percent(YF_modes(i-1))), ' % Accuracy)');
  title(figure_title)
  subplot(2, 4, i-1)
  image(reshape(YF_A1(:,YF_pic),243,320));
end
title(strcat(int2str(165), ' Modes', ' (', '100% Accuracy)'));
suptitle(strcat('Face (', int2str(YF_pic), ')'))