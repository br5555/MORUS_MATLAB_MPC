load theta.mat
number = 1;
for i = 2:number
    theta_x(i,:) = theta_x(1,:);
end

pomocni = zeros(number*size(theta_x,2),1);

for i = 1:size(theta_x,2)
    for j = 1:number
        pomocni((i-1)*number + j) = theta_x(j,i);
    end
end

theta_x = pomocni;
csvwrite('theta.csv',theta_x);