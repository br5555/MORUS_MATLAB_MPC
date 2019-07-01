figure();
plot(my_vel_ref.time, my_vel_ref.signals.values, 'LineWidth', 3)
hold on;
plot(my_vel.time, my_vel.signals.values, 'LineWidth', 3)
legend('referenca', 'odziv');
xlabel('Vrijeme [s]');
ylabel('Brzina [m/s]')
title('Brzina letjelice u x smjeru')


figure();
plot(roll_ref.time, roll_ref.signals.values * (180/pi), 'LineWidth', 3)
hold on;
plot(my_roll.time, my_roll.signals.values * (180/pi), 'LineWidth', 3)
legend('referenca', 'odziv');
xlabel('Vrijeme [s]');
 ylabel(['Kut [' char(176) ' ]'])
title('Kut poniranja')