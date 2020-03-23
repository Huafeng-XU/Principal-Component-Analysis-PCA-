clear all;
%row 1 represent x in coordinate system.
%row 2 represent y in coordinate system.
X1=[2 3 3 4 5 5 6 6
   6 4 5 3 2 4 0 1];
X1_x = X1(1,:);
X1_y = X1(2,:);

X2=[6 6 7 8 8 9 9 10
   4 5 3 2 4 0 2 1];
X2_x = X2(1,:);
X2_y = X2(2,:);

%Plot X1 and X2 Training data in coordinate system.
figure('Name','X1 and X2 Training data in coordinate system')
scatter(X1_x,X1_y,'filled','red')
hold on
scatter(X2_x,X2_y,'filled','green')
scatter(4,6,'filled','black')
grid on
axis([0 12 -2 8])
xlabel('X');
ylabel('Y');

%combine X1 and X1 together
X(1:2,1:8) = X1;
X(1:2,9:16) = X2;
%X =[2 3 3 4 5 5 6 6 6 6 7 8 8 9 9 10
%   6 4 5 3 2 4 0 1 4 5 3 2 4 0 2 1];

%Calculate the mean value of X
mean = (1/16 * sum(X'))';

%Calculate XP
XP = X - mean;
%XP(1,:) = X(1,:)- mean(1,1);
%XP(2,:) = X(2,:) - mean(1,2);

R = [0 0
      0 0];
for i = 1:16
    R = R + XP(:,i) * XP(:,i)';
end
R = 1/16 * (R);

% Find the eigenvalues and eigenvector
[U,D] = eig(R)
e1 = U(:,1);
e2 = U(:,2);

%The projection value
Y = e2' * XP;
Y1 = Y(1,1:8);
Y2 = Y(1,9:16);

%Calculate the mean of the projected samples of each class
meanY1 = 1/8 * sum(Y1);
meanY2 = 1/8 * sum(Y2);

%Find the accuracy 
%For X1
X1D1 = abs(Y1-meanY1);
X1D2 = abs(Y1-meanY2);
X1count = size(find((X1D1-X1D2)<0),2);
%For X2
X2D1 = abs(Y2-meanY1);
X2D2 = abs(Y2-meanY2);
X2count = size(find((X2D1-X2D2)>0),2);
%The PCA accuracy.
PCA_accuracy = (X1count + X2count)/size(Y,2)

%Find out the query input q=(4,6) belongs to which class
q = [4 6]';
yq = e2' * (q-mean);
%the distance to class1
qD1 = abs(yq-meanY1);
%the distance to class2
qD2 = abs(yq-meanY2);
if qD1 < qD2
    class =  1;
else
    class = 2;
end
class
