close all
clear all
clc
%% Set initial time
t = 0;

%% Split plots into two adjacent windows
scrsz = get(0,'ScreenSize');
figure('OuterPosition',[1 1 scrsz(3)/2 scrsz(4)/1]);
figure('OuterPosition',[scrsz(3)/2 1 scrsz(3)/2 scrsz(4)/1]);

    Omega = 1.0;
    w0 = 0.036 ;

%% Set for loop, for time increase
for l = 1:50
    A_1 = (cos(Omega/2*t))^2; 
    A_2 = (sin(Omega/2*t))^2; 
    A_3 = sin(Omega*t)*sin(w0*t);

%% Find array theta_q and phi then apply meshgrid
    x = linspace(-pi/4,pi/4);
    y = linspace(0,2*pi);
    [theta,phi] = meshgrid(x,y);

%% Convert to polar coordinates
    J = tan(theta).*(cos(phi));
    K = tan(theta).*(sin(phi));

%% Find q in terms of theta_k   
     q = 2.0*sin(2*theta);  %% theta is the angle between (k,k0)
     display(q)
     w = cos(phi);
     %%w = cos(phi);        %% phi     is the angle between (q,z-axis)
     
%% Apply derived formula with signal function given by p
    f_1 = A_1*16./((q.^2)+4).^2;
    f_2 = A_2*(1+(q.^2)-6*(q.^2).*(w.^2))./(1+(q.^2)).^4;
    f_3 = A_3*6*sqrt(2)*q.*w./((q.^2)+(3/2)).^3;
    p = abs((f_1 + f_2).^2 + (f_3).^2);

%% Convert t to fs    
    t_2 = t*2.418884326502*10^-2;

%% Set interference plot to figure 1    
   figure(1);
    surf(J,K,p);
    h = surf(J,K,p);
    set(h, 'edgecolor','none')
    xlabel('Y - axis')
    ylabel('Z - axis')
    zlabel('Density Function')
    title(['Time delay  = ', num2str(t_2), 'fs'])
    az = 0;
    el = 90;
    view(az, el);
    pause(.75)


%% Set diffraction pattern to figure 2
    figure(2);
    surf(x,y,p);
    az = 180;
    el = 0;
    view(az,el);
    xlabel('Fq (radians)')
    ylabel('Phi(radians)')
    zlabel('Density Function')
    title(['Plot with value t = ', num2str(t_2), ' seconds'])
    pause(.75)
      t = t + pi/12;
   
end