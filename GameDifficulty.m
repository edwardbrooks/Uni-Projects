clc

% Read in the data for the FIS
filename = ('GameDifficultyExcel.xlsx');
testData = xlsread(filename)

% Declare a new FIS
a = newfis('GameDifficulty','sugeno', 'min', 'max', 'prod', 'sum', 'wtaver');

% Input variable: Ambient Lighting
a = addvar(a, 'input', 'UserChallengeRating', [0 100]);
a = addmf(a, 'input', 1, 'VeryEasy', 'trapmf', [-8 0 12 20]);
a = addmf(a, 'input', 1, 'Easy', 'trimf', [0 30 60]);
a = addmf(a, 'input', 1, 'Medium', 'trimf', [30 50 70]);
a = addmf(a, 'input', 1, 'Hard', 'trimf', [40 70 100]);
a = addmf(a, 'input', 1, 'VeryHard', 'trapmf', [80 88 100 110]);

% Input variable: Session Playtime
a = addvar(a, 'input', 'SessionPlaytime', [0 24]);
a = addmf(a, 'input', 2, 'VeryShort', 'trapmf', [-1 0 0.15 1]); 
a = addmf(a, 'input', 2, 'Short', 'gaussmf', [2 2]); 
a = addmf(a, 'input', 2, 'Medium', 'gaussmf', [3 8]); 
a = addmf(a, 'input', 2, 'Long', 'gaussmf', [4 12]);
a = addmf(a, 'input', 2, 'VeryLong', 'trapmf', [8 20 24 30]);

% Input variable: Deaths per Hour
a = addvar(a, 'input', 'DeathsPerHour', [0 30]);
a = addmf(a, 'input', 3, 'None', 'trapmf', [0 0 0 0]);
a = addmf(a, 'input', 3, 'Few', 'gaussmf', [3 0.5]);
a = addmf(a, 'input', 3, 'Some', 'gaussmf', [2 5]);
a = addmf(a, 'input', 3, 'Many', 'gaussmf', [15 30]);

% Output variable: Enemies
a=addvar(a,'output','Enemies',[0 1]); 

a = addmf(a,'output',1,'Few', 'constant', [5]);
a = addmf(a,'output',1,'Some', 'constant', [12.5]);
a = addmf(a,'output',1,'Many', 'constant', [20]);

% Create rules for the FIS, the last value is for AND or OR
rule1 = [1 0 0 1 1 2];
rule2 = [5 0 0 3 1 2];

rule3 = [2 1 0 1 0.8 1];
rule4 = [4 1 0 3 0.8 1];
rule5 = [3 1 0 2 0.8 1];

rule6 = [2 2 0 1 0.75 1];
rule7 = [3 2 0 2 0.75 1];
rule8 = [4 2 0 3 0.75 1];

rule9 = [2 0 3 1 0.6 1];
rule10 = [3 0 3 2 0.6 1];
rule11 = [4 0 3 3 0.6 1];

rule12 = [2 0 4 1 0.2 2];
rule13 = [4 0 2 3 0.6 2];
rule14 = [4 0 1 3 0.8 1];
rule15 = [2 0 1 2 0.6 1];

rule16 = [4 5 0 3 0.8 1];
rule17 = [2 5 1 3 0.2 1];
rule18 = [2 3 0 1 0.5 1];

rule19 = [3 3 0 2 0.5 1];
rule20 = [4 3 0 3 0.5 1];

rule21 = [2 4 0 1 0.3 1];
rule22 = [3 4 0 2 0.3 1];
rule23 = [4 4 0 3 0.3 1];

rule24 = [5 5 -4 3 1 1];
rule25 = [1 5 4 1 1 1];

rule26 = [3 3 4 1 0.2 1];
rule27 = [3 3 -4 2 0.2 1];

% Pass the rules to an array
%ruleList = [rule1;rule2;rule3;rule4;rule5;rule6;rule7;rule8;rule9];
ruleList = [rule1;rule2;rule3;rule4;rule5;rule6;rule7;rule8;rule9;rule10;rule11;rule12;rule13;rule14;rule15;rule16;rule17;rule18;rule19;rule20;rule21;rule22;rule23;rule24;rule25;rule26;rule27];

% Add the rules to the FIS
a = addrule(a,ruleList);

% Print the rules to the workspace
rules = showrule(a)

% Set the defuzzification method
%a.defuzzMethod = 'centroid';
%a.defuzzMethod = 'bisector';
%a.defuzzMethod = 'mom';
%a.defuzzMethod = 'som';
%a.defuzzMethod = 'lom';

for i=1:size(testData,1)
        eval = evalfis([testData(i, 1), testData(i, 2), testData(i, 3) ], a);
        fprintf('%d) In(1): %.2f, In(2) %.2f, In(3) %.2f => Out: %.2f \n\n',i,testData(i, 1),testData(i, 2),testData(i, 3), eval);  
end

figure(1)
subplot(4,1,1), plotmf(a, 'input', 1)
subplot(4,1,2), plotmf(a, 'input', 2)
subplot(4,1,3), plotmf(a, 'input', 3)
subplot(4,1,4), gensurf(a)
%subplot(4,1,4), plotmf(a, 'output', 1)