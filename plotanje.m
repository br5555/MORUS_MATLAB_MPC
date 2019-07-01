clc
clear all
close all
% 
% load adam_workspace.mat
% load AdaGrad_workspace.mat
% load RMSProp_workspace.mat
% load RMSPropNester_workspace.mat
% 
% figure();
% plot(adam_new_masa1_signal.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), adam_new_masa1_signal.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 3);
% hold on;
% plot(AdaGrad_new_masa1_signal.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), AdaGrad_new_masa1_signal.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 3);
% plot(Nester_new_masa1_signal.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), Nester_new_masa1_signal.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 3);
% plot(Rms_new_masa1_signal.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), Rms_new_masa1_signal.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 3);
% title('Pomica masa 1 referenca');
% legend('Adam', 'AdaGrad', 'RmsProp', 'RmsProp  Nester')
% xlabel('Vrijeme [s]')
% ylabel('Pozicija [m]')
% 
% 
% 
% figure();
% plot(adam_new_rotor1_signal.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), adam_new_rotor1_signal.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 3);
% hold on;
% plot(AdaGrad_new_rotor1_signal.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), AdaGrad_new_rotor1_signal.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 3);
% plot(Nester_new_rotor1_signal.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), Nester_new_rotor1_signal.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 3);
% plot(Rms_new_rotor1_signal.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), Rms_new_rotor1_signal.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 3);
% title('Rotor 1 referenca');
% legend('Adam', 'AdaGrad', 'RmsProp', 'RmsProp  Nester')
% xlabel('Vrijeme [s]')
% ylabel('Kutna brzina [rad/s]')
% 
% 
% figure();
% plot(adam_new_referenca.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), adam_new_referenca.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0)*180/pi, 'LineWidth', 4);
% hold on;
% plot(adam_new_ROLL.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), adam_new_ROLL.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 5);
% plot(AdaGrad_new_ROLL.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), AdaGrad_new_ROLL.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 2);
% plot(Nester_new_ROLL.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), Nester_new_ROLL.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 3);
% plot(Rms_new_ROLL.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), Rms_new_ROLL.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 3);
% title('Kut valjanja');
% legend('Refrenca','Adam', 'AdaGrad', 'RmsProp', 'RmsProp  Nester')
% xlabel('Vrijeme [s]')
% ylabel(['Kut [' char(176) ' ]'])
% 
% 
% figure();
% plot(adam_new_masa_y_2.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), adam_new_masa_y_2.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0) *-1, 'LineWidth', 3);
% hold on;
% plot(AdaGrad_new_masa_y_2.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), AdaGrad_new_masa_y_2.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0)*-1, 'LineWidth', 3);
% plot(Nester_new_masa_y_2.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), Nester_new_masa_y_2.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0)*-1, 'LineWidth', 3);
% plot(Rms_new_masa_y_2.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), Rms_new_masa_y_2.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0)*-1, 'LineWidth', 3);
% title('Pomica masa 1 ');
% legend('Adam', 'AdaGrad', 'RmsProp', 'RmsProp  Nester')
% xlabel('Vrijeme [s]')
% ylabel('Pozicija [m]')
% 
% 
% 
% figure();
% plot(adam_new_ROTOR_2.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), adam_new_ROTOR_2.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 3);
% hold on;
% plot(AdaGrad_new_ROTOR_2.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), AdaGrad_new_ROTOR_2.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 3);
% plot(Nester_new_ROTOR_2.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), Nester_new_ROTOR_2.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 3);
% plot(Rms_new_ROTOR_2.time(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), Rms_new_ROTOR_2.signals.values(adam_new_masa1_signal.time >= 90.0 & adam_new_masa1_signal.time <= 120.0), 'LineWidth', 3);
% title('Rotor 1 ');
% legend('Adam', 'AdaGrad', 'RmsProp', 'RmsProp  Nester')
% xlabel('Vrijeme [s]')
% ylabel('Kutna brzina [rad/s]')


% clc
% clear all
% close all
% load Adam_stednja_masa_workspace.mat
% 
% figure();
% plot(Adam_masa1_signal.time(Adam_masa1_signal.time >= 90.0 & Adam_masa1_signal.time <= 120.0), Adam_masa1_signal.signals.values(Adam_masa1_signal.time >= 90.0 & Adam_masa1_signal.time <= 120.0), 'LineWidth', 3);
% 
% title('Pomica masa 1 referenca');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Pozicija [m]')
% 
% 
% 
% figure();
% plot(Adam_rotor1_signal.time(Adam_masa1_signal.time >= 90.0 & Adam_masa1_signal.time <= 120.0), Adam_rotor1_signal.signals.values(Adam_masa1_signal.time >= 90.0 & Adam_masa1_signal.time <= 120.0), 'LineWidth', 3);
% 
% 
% title('Rotor 1 referenca');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Kutna brzina [rad/s]')
% 
% 
% figure();
% plot(Adam_referenca.time(Adam_masa1_signal.time >= 90.0 & Adam_masa1_signal.time <= 120.0), Adam_referenca.signals.values(Adam_masa1_signal.time >= 90.0 & Adam_masa1_signal.time <= 120.0)*180/pi, 'LineWidth', 3);
% hold on;
% plot(Adam_ROLL.time(Adam_masa1_signal.time >= 90.0 & Adam_masa1_signal.time <= 120.0), Adam_ROLL.signals.values(Adam_masa1_signal.time >= 90.0 & Adam_masa1_signal.time <= 120.0), 'LineWidth', 3);
% 
% title('Kut valjanja');
% legend('Refrenca','Adam' )
% xlabel('Vrijeme [s]')
% ylabel(['Kut [' char(176) ' ]'])
% 
% 
% figure();
% plot(Adam_masa_y_2.time(Adam_masa1_signal.time >= 90.0 & Adam_masa1_signal.time <= 120.0), Adam_masa_y_2.signals.values(Adam_masa1_signal.time >= 90.0 & Adam_masa1_signal.time <= 120.0) *-1, 'LineWidth', 3);
% 
% title('Pomica masa 1 ');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Pozicija [m]')
% 
% 
% 
% figure();
% plot(Adam_ROTOR_2.time(Adam_masa1_signal.time >= 90.0 & Adam_masa1_signal.time <= 120.0), Adam_ROTOR_2.signals.values(Adam_masa1_signal.time >= 90.0 & Adam_masa1_signal.time <= 120.0), 'LineWidth', 3);
% 
% title('Rotor 1 ');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Kutna brzina [rad/s]')

% clc
% clear all
% close all
% load nove_varijable_p9_c3.mat
% 
% figure();
% plot(masa1_signal.time(masa1_signal.time >= 90.0 & masa1_signal.time <= 120.0), masa1_signal.signals.values(masa1_signal.time >= 90.0 & masa1_signal.time <= 120.0), 'LineWidth', 3);
% 
% title('Pomica masa 1 referenca');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Pozicija [m]')
% 
% 
% 
% figure();
% plot(rotor1_signal.time(masa1_signal.time >= 90.0 & masa1_signal.time <= 120.0), rotor1_signal.signals.values(masa1_signal.time >= 90.0 & masa1_signal.time <= 120.0), 'LineWidth', 3);
% 
% 
% title('Rotor 1 referenca');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Kutna brzina [rad/s]')
% 
% 
% figure();
% plot(referenca.time(masa1_signal.time >= 90.0 & masa1_signal.time <= 120.0), referenca.signals.values(masa1_signal.time >= 90.0 & masa1_signal.time <= 120.0)*180/pi, 'LineWidth', 3);
% hold on;
% plot(ROLL.time(masa1_signal.time >= 90.0 & masa1_signal.time <= 120.0), ROLL.signals.values(masa1_signal.time >= 90.0 & masa1_signal.time <= 120.0), 'LineWidth', 3);
% 
% title('Kut valjanja');
% legend('Refrenca','Adam' )
% xlabel('Vrijeme [s]')
% ylabel(['Kut [' char(176) ' ]'])
% 
% 
% figure();
% plot(masa_y_2.time(masa1_signal.time >= 90.0 & masa1_signal.time <= 120.0), masa_y_2.signals.values(masa1_signal.time >= 90.0 & masa1_signal.time <= 120.0)*-1, 'LineWidth', 3);
% 
% title('Pomica masa 1 ');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Pozicija [m]')
% 
% 
% 
% figure();
% plot(ROTOR_2.time(masa1_signal.time >= 90.0 & masa1_signal.time <= 120.0), ROTOR_2.signals.values(masa1_signal.time >= 90.0 & masa1_signal.time <= 120.0), 'LineWidth', 3);
% 
% title('Rotor 1 ');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Kutna brzina [rad/s]')


%%
% clc
% clear all
% close all
% load Adam_nelinearni_workspace.mat
% 
% 
% 
% 
% figure();
% plot(Adam_referenca.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_referenca.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% hold on;
% plot(Adam_ROLL.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_ROLL.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% plot(Adam_PITCH.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_PITCH.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% title('Kut valjanja');
% legend('Refrenca','Adam', 'Kut poniranja' )
% xlabel('Vrijeme [s]')
% ylabel(['Kut [' char(176) ' ]'])
% 
% 
% figure();
% plot(Adam_masa_y_2.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_masa_y_2.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0)*-1, 'LineWidth', 3);
% 
% title('Pomica masa 1 ');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Pozicija [m]')
% 
% 
% 
% figure();
% plot(Adam_ROTOR_2.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_ROTOR_2.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% 
% title('Rotor 1 ');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Kutna brzina [rad/s]')

% %%
% clc
% clear all
% close all
% load Adam_nelinearni_poremecaj_workspace.mat
% 
% 
% 
% 
% figure();
% plot(Adam_referenca.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_referenca.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% hold on;
% plot(Adam_ROLL.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_ROLL.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% plot(Adam_PITCH.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_PITCH.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% title('Kut valjanja');
% legend('Refrenca','Adam', 'Kut poniranja' )
% xlabel('Vrijeme [s]')
% ylabel(['Kut [' char(176) ' ]'])
% 
% 
% figure();
% plot(Adam_masa_y_2.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_masa_y_2.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0)*-1, 'LineWidth', 3);
% 
% title('Pomica masa 1 ');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Pozicija [m]')
% 
% 
% 
% figure();
% plot(Adam_ROTOR_2.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_ROTOR_2.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% 
% title('Rotor 1 ');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Kutna brzina [rad/s]')

%%
% clc
% clear all
% close all
% load Adam_polunelinearni_workspace.mat
% 
% 
% 
% 
% figure();
% plot(Adam_referenca.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_referenca.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% hold on;
% plot(Adam_ROLL.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_ROLL.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% plot(Adam_PITCH.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_PITCH.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% title('Kut valjanja');
% legend('Refrenca','Adam', 'Kut poniranja' )
% xlabel('Vrijeme [s]')
% ylabel(['Kut [' char(176) ' ]'])
% 
% 
% figure();
% plot(Adam_masa_y_2.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_masa_y_2.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0) *-1, 'LineWidth', 3);
% 
% title('Pomica masa 1 ');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Pozicija [m]')
% 
% 
% 
% figure();
% plot(Adam_ROTOR_2.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_ROTOR_2.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% 
% title('Rotor 1 ');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Kutna brzina [rad/s]')

%%
% clc
% clear all
% close all
% load Adam_polunelinearni_poremecaj_workspace.mat
% 
% 
% 
% 
% figure();
% plot(Adam_referenca.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_referenca.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% hold on;
% plot(Adam_ROLL.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_ROLL.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% plot(Adam_PITCH.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_PITCH.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% title('Kut valjanja');
% legend('Refrenca','Adam', 'Kut poniranja' )
% xlabel('Vrijeme [s]')
% ylabel(['Kut [' char(176) ' ]'])
% 
% 
% figure();
% plot(Adam_masa_y_2.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_masa_y_2.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0) *-1, 'LineWidth', 3);
% 
% title('Pomica masa 1 ');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Pozicija [m]')
% 
% 
% 
% figure();
% plot(Adam_ROTOR_2.time(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), Adam_ROTOR_2.signals.values(Adam_referenca.time >= 90.0 & Adam_referenca.time <= 120.0), 'LineWidth', 3);
% 
% title('Rotor 1 ');
% legend('Adam')
% xlabel('Vrijeme [s]')
% ylabel('Kutna brzina [rad/s]')


%%
% figure();
% plot(referenca_Z.time, referenca_Z.signals.values, 'LineWidth', 3);
% hold on;
% plot(ScopeData3.time, ScopeData3.signals.values, 'LineWidth', 3);
% title('pozicija Z');
% legend('refrenca', 'pozicija Z')
% xlabel('Vrijeme [s]')
% ylabel('Pozicija [m]')