%% Load Files
data = importfile("acc_exp53_user26.txt");
labels = importlabel("labels.txt");
activities = {'W', 'W\_U', 'W\_D', 'SIT', 'STAND', 'LAY', 'S\_SIT', 'S\_STAND', 'S\_lay', 'L\_SIT', 'S\_lay', 'L\_STAND'};
color = {'r'; 'b'; 'y'; 'w'; 'k'; 'g'; 'm'; 'c';'r'; 'b'; 'y'; 'w'; 'k'; 'g'; 'm'; 'c'};
acc = {'ACC\_X', 'ACC\_Y', 'ACC\_Z'};

user = 25;
exp = 51;

current_label = intersect(find(labels(:, 1) == exp), find(labels(:, 2) == user));
    
[points, eixos] = size(data);

Fs = 50;

t = [0: points - 1]./Fs;

%% Activities
walking_x = [];
walking_y = [];
walking_z = [];

walking_upstairs_x = [];
walking_upstairs_y = [];
walking_upstairs_z = [];

walking_downstairs_x = [];
walking_downstairs_y = [];
walking_downstairs_z = [];

sitting_x = [];
sitting_y = [];
sitting_z = [];

standing_x = [];
standing_y = [];
standing_z = [];

laying_x = [];
laying_y = [];
laying_z = [];

stand_to_sit_x = [];
stand_to_sit_y = [];
stand_to_sit_z = [];

sit_to_stand_x = [];
sit_to_stand_y = [];
sit_to_stand_z = [];

sit_to_lie_x = [];
sit_to_lie_y = [];
sit_to_lie_z = [];

lie_to_sit_x = []; 
lie_to_sit_y = []; 
lie_to_sit_z = [];

stand_to_lie_x = [];
stand_to_lie_y = [];   
stand_to_lie_z = [];   

lie_to_stand_x = [];
lie_to_stand_y = [];
lie_to_stand_z = [];
% Plot Data
figure(1)
for i=1:eixos
        subplot(eixos, 1, i); 
        plot(t./60, data(:, i), 'k--')
        axis([0, t(end)./60 min(data(:, i)) max(data(:, i))])
        xlabel('Time (min)');
        ylabel(acc{i});
        hold on
        for j = 1 : numel(current_label)
            plot(t(labels(current_label(j), 4):labels(current_label(j), 5))./60, data(labels(current_label(j), 4):labels(current_label(j), 5), i));
            if mod(j, 2) == 1
                ypos = min(data(:, i)) - (0.2 * min(data(:, i)));
            else
                ypos = max(data(:, i)) - (0.2 * min(data(:, i)));
            end
            text(t(labels(current_label(j), 4))/60, ypos, activities{labels(current_label(j), 3)});
        end
end
%% Create windows to apply dft
for i=1:numel(current_label)
    activity = labels((current_label(i)),3);
    switch(activity)
        
        case 1 %{'W'}
            walking_x = cat(1, walking_x, data(labels(current_label(i),4): labels(current_label(i),5),1));
            walking_y = cat(1, walking_y, data(labels(current_label(i),4): labels(current_label(i),5),2));
            walking_z = cat(1, walking_z, data(labels(current_label(i),4): labels(current_label(i),5),3));
        case 2 %{'W\_U'}
            walking_upstairs_x = cat(1, walking_upstairs_x, data(labels(current_label(i),4): labels(current_label(i),5),1));
            walking_upstairs_y = cat(1, walking_upstairs_y, data(labels(current_label(i),4): labels(current_label(i),5),2));
            walking_upstairs_z = cat(1, walking_upstairs_z, data(labels(current_label(i),4): labels(current_label(i),5),3));
        
        case 3 %{'W\_D'}
            walking_downstairs_x = cat(1, walking_downstairs_x, data(labels(current_label(i),4): labels(current_label(i),5),1));
            walking_downstairs_y = cat(1, walking_downstairs_y, data(labels(current_label(i),4): labels(current_label(i),5),2));
            walking_downstairs_z = cat(1, walking_downstairs_z, data(labels(current_label(i),4): labels(current_label(i),5),3));
        
        case 4 %{'SIT'}
            sitting_x = cat(1, sitting_x, data(labels(current_label(i),4): labels(current_label(i),5),1));
            sitting_y = cat(1, sitting_y, data(labels(current_label(i),4): labels(current_label(i),5),2));
            sitting_z = cat(1, sitting_z, data(labels(current_label(i),4): labels(current_label(i),5),3));
          
        case 5 %{'STAND'}
            standing_x = cat(1, standing_x, data(labels(current_label(i),4): labels(current_label(i),5),1));
            standing_y = cat(1, standing_y, data(labels(current_label(i),4): labels(current_label(i),5),2));
            standing_z = cat(1, standing_z, data(labels(current_label(i),4): labels(current_label(i),5),3));
        
        case 6 %{'LAY'}
            laying_x = cat(1, laying_x, data(labels(current_label(i),4): labels(current_label(i),5),1));
            laying_y = cat(1, laying_y, data(labels(current_label(i),4): labels(current_label(i),5),2));
            laying_z = cat(1, laying_z, data(labels(current_label(i),4): labels(current_label(i),5),3));
        
        case 7 %{'S\_SIT'}
            stand_to_sit_x = cat(1, stand_to_sit_x, data(labels(current_label(i),4): labels(current_label(i),5),1));
            stand_to_sit_y = cat(1, stand_to_sit_y, data(labels(current_label(i),4): labels(current_label(i),5),2));
            stand_to_sit_z = cat(1, stand_to_sit_z, data(labels(current_label(i),4): labels(current_label(i),5),3));
        
        case 8 %{'S\_STAND'}
            sit_to_stand_x = cat(1, sit_to_stand_x, data(labels(current_label(i),4): labels(current_label(i),5),1));
            sit_to_stand_y = cat(1, sit_to_stand_y, data(labels(current_label(i),4): labels(current_label(i),5),2));
            sit_to_stand_z = cat(1, sit_to_stand_z, data(labels(current_label(i),4): labels(current_label(i),5),3));
        
        case 9 %{'S\_lay'}
            sit_to_lie_x = cat(1, sit_to_lie_x, data(labels(current_label(i),4): labels(current_label(i),5),1));
            sit_to_lie_y = cat(1, sit_to_lie_y, data(labels(current_label(i),4): labels(current_label(i),5),2));
            sit_to_lie_z = cat(1, sit_to_lie_z, data(labels(current_label(i),4): labels(current_label(i),5),3));
        
        case 10 %{'L\_SIT'}
            lie_to_sit_x = cat(1, lie_to_sit_x, data(labels(current_label(i),4): labels(current_label(i),5),1));
            lie_to_sit_y = cat(1, lie_to_sit_y, data(labels(current_label(i),4): labels(current_label(i),5),2));
            lie_to_sit_z = cat(1, lie_to_sit_z, data(labels(current_label(i),4): labels(current_label(i),5),3));   
        
        case 11 %{'S\_lay'}
            stand_to_lie_x = cat(1, stand_to_lie_x, data(labels(current_label(i),4): labels(current_label(i),5),1));
            stand_to_lie_y = cat(1, stand_to_lie_y, data(labels(current_label(i),4): labels(current_label(i),5),2));
            stand_to_lie_z = cat(1, stand_to_lie_z, data(labels(current_label(i),4): labels(current_label(i),5),3));
        
        case 12%{'L\_STAND'}
            lie_to_stand_x = cat(1, lie_to_stand_x, data(labels(current_label(i),4): labels(current_label(i),5),1));
            lie_to_stand_y = cat(1, lie_to_stand_y, data(labels(current_label(i),4): labels(current_label(i),5),2));
            lie_to_stand_z = cat(1, lie_to_stand_z, data(labels(current_label(i),4): labels(current_label(i),5),3));
            
    end    
end
%% DRAW WINDOWS DFT
drawDft(walking_x, walking_y, walking_z, 2, 'WALKING');
drawDft(walking_upstairs_x, walking_upstairs_y, walking_upstairs_z, 3, 'WALKING UPSTAIRS');
drawDft(walking_downstairs_x, walking_downstairs_y, walking_downstairs_z, 4, 'WALKING DOWNSTAIRS');
drawDft(sitting_x, sitting_y, sitting_z, 5, 'SITTING');
drawDft(standing_x, standing_y, standing_z, 6, 'STANDING');
drawDft(laying_x, laying_y, laying_z, 7, 'LAYING');
drawDft(stand_to_sit_x, stand_to_sit_y, stand_to_sit_z, 8, 'STAND TO SIT');
drawDft( sit_to_stand_x,  sit_to_stand_y,  sit_to_stand_z, 9, 'SIT TO STAND');
drawDft(sit_to_lie_x, sit_to_lie_y, sit_to_lie_z, 10, 'SIT TO LIE');
drawDft(lie_to_sit_x, lie_to_sit_y, lie_to_sit_z, 11, 'LIE TO SIT');
drawDft(stand_to_lie_x, stand_to_lie_y, stand_to_lie_z, 12, 'STAND TO LIE');
%% GET STEPS
getSteps(walking_x, walking_y, walking_z);
getSteps(walking_upstairs_x, walking_upstairs_y, walking_upstairs_z);
getSteps(walking_downstairs_x, walking_downstairs_y, walking_downstairs_z);
%% FIRST PEAK FREQUENCY
figure(13)
plot3dPeaks(walking_x, walking_y, walking_z, 'o');
plot3dPeaks(walking_upstairs_x, walking_upstairs_y, walking_upstairs_z, 'o');
plot3dPeaks(walking_downstairs_x, walking_downstairs_y, walking_downstairs_z, 'o');
plot3dPeaks(sitting_x, sitting_y, sitting_z, 'x');
plot3dPeaks(standing_x, standing_y, standing_z, 'x');
plot3dPeaks(laying_x, laying_y, laying_z, 'x');
plot3dPeaks(stand_to_sit_x, stand_to_sit_y, stand_to_sit_z, '*');
plot3dPeaks(sit_to_stand_x, sit_to_stand_y, sit_to_stand_z, '*');
plot3dPeaks(sit_to_lie_x, sit_to_lie_y, sit_to_lie_z, '*');
plot3dPeaks(lie_to_sit_x, lie_to_sit_y, lie_to_sit_z, '*');
plot3dPeaks(stand_to_lie_x, stand_to_lie_y, stand_to_lie_z, '*');
plot3dPeaks(lie_to_stand_x, lie_to_stand_y, lie_to_stand_z, '*');
legend('WALKING','WALKING UPSTAIRS', 'WALKING DOWNSTAIRS', 'SITTING ', 'STANDING', 'LAYING','STAND_TO_SIT','SIT_TO_STAND','SIT_TO_LIE','LIE_TO_SIT','STAND_TO_LIE','LIE_TO_STAND');
hold off;
%% POTÊNCIAS DAS ATIVIDADES
figure(14)
plot3dPotency(walking_x, walking_y, walking_z, 'o');
plot3dPotency(walking_upstairs_x, walking_upstairs_y, walking_upstairs_z, 'o');
plot3dPotency(walking_downstairs_x, walking_downstairs_y, walking_downstairs_z, 'o');
plot3dPotency(sitting_x, sitting_y, sitting_z, 'x');
plot3dPotency(standing_x, standing_y, standing_z, 'x');
plot3dPotency(laying_x, laying_y, laying_z, 'x');
plot3dPotency(stand_to_sit_x, stand_to_sit_y, stand_to_sit_z, '*');
plot3dPotency(sit_to_stand_x, sit_to_stand_y, sit_to_stand_z, '*');
plot3dPotency(sit_to_lie_x, sit_to_lie_y, sit_to_lie_z, '*');
plot3dPotency(lie_to_sit_x, lie_to_sit_y, lie_to_sit_z, '*');
plot3dPotency(stand_to_lie_x, stand_to_lie_y, stand_to_lie_z, '*');
plot3dPotency(lie_to_stand_x, lie_to_stand_y, lie_to_stand_z, '*');
legend('WALKING','WALKING UPSTAIRS', 'WALKING DOWNSTAIRS', 'SITTING ', 'STANDING', 'LAYING','STAND_TO_SIT','SIT_TO_STAND','SIT_TO_LIE','LIE_TO_SIT','STAND_TO_LIE','LIE_TO_STAND');
hold off;
%% ENERGIA DAS ATIVIDADES
figure(15)
plot3dEnergy(walking_x, walking_y, walking_z, 'o');
plot3dEnergy(walking_upstairs_x, walking_upstairs_y, walking_upstairs_z, 'o');
plot3dEnergy(walking_downstairs_x, walking_downstairs_y, walking_downstairs_z, 'o');
plot3dEnergy(sitting_x, sitting_y, sitting_z, 'x');
plot3dEnergy(standing_x, standing_y, standing_z, 'x');
plot3dEnergy(laying_x, laying_y, laying_z, 'x');
plot3dEnergy(stand_to_sit_x, stand_to_sit_y, stand_to_sit_z, '*');
plot3dEnergy(sit_to_stand_x, sit_to_stand_y, sit_to_stand_z, '*');
plot3dEnergy(sit_to_lie_x, sit_to_lie_y, sit_to_lie_z, '*');
plot3dEnergy(lie_to_sit_x, lie_to_sit_y, lie_to_sit_z, '*');
plot3dEnergy(stand_to_lie_x, stand_to_lie_y, stand_to_lie_z, '*');
plot3dEnergy(lie_to_stand_x, lie_to_stand_y, lie_to_stand_z, '*');
legend('WALKING','WALKING UPSTAIRS', 'WALKING DOWNSTAIRS', 'SITTING ', 'STANDING', 'LAYING','STAND_TO_SIT','SIT_TO_STAND','SIT_TO_LIE','LIE_TO_SIT','STAND_TO_LIE','LIE_TO_STAND');
hold off;

%% DISTRIBUICAO TEMPO-FREQUENCIA
figure(16)
steps_w = DftTimeFrequency(walking_z, 16, 'WALKING_Z');
steps_w_u = DftTimeFrequency(walking_upstairs_z, 17, 'WALKING UPSTAIRS');
steps_w_d = DftTimeFrequency(walking_downstairs_z, 18, 'WALKING DOWNSTAIRS');
steps_sit = DftTimeFrequency(sitting_z, 19, 'SITTING');
steps_stand = DftTimeFrequency(standing_z, 20, 'STANDING');
steps_lay = DftTimeFrequency(laying_z, 21, 'LAYING');
steps_stand_sit = DftTimeFrequency(stand_to_sit_z, 22, 'STAND TO SIT');
steps_sit_stand = DftTimeFrequency(sit_to_stand_z, 23, 'SIT TO STAND');
steps_sit_lie = DftTimeFrequency(sit_to_lie_z, 24, 'SIT TO LIE');
steps_lie_sit = DftTimeFrequency(lie_to_sit_z, 25, 'LIE TO SIT');
steps_stand_lie = DftTimeFrequency(stand_to_lie_z, 26, 'STAND TO LIE');
hold off;

'W', 'W\_U', 'W\_D', 'SIT', 'STAND', 'LAY', 'S\_SIT', 'S\_STAND', 'S\_lay', 'L\_SIT', 'S\_lay', 'L\_STAND'