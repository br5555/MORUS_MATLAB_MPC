clc
clear
close all
x = load('AdaGrad_workspace.mat');
names = fieldnames(x)
for iname = 1:length(names)
  x.(['AdaGrad_', names{iname}]) = x.(names{iname});
  x = rmfield(x, names{iname});
end
save('AdaGrad_workspace.mat', '-struct', 'x');