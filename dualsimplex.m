#nv = input("Enter number of variables\n");
#nc = input("enter number fof constraints\n");
#table = zeros(nc+1, nv+2);
#rel = zeros(nc+1, 1);

#disp(nv);
#disp(nc);
#pause;
#for i = 1:nc+1,
#    for j = 1:nv+2,
#        if(j == nv+1)
#            rel(i) = input("operator\n");
#        else
#            table(i,j) = input("value\n");
#            endif;
#        endfor;
#    endfor;
#table(:, nv+1) = [];
#save("data.mat");
load("data2.mat");
[n, m] = size(table);
nv = m - 1;
nc = n - 1;
#for >=2
table(rel==2, :) = -table(rel==2, :);
rel(rel==2) = 1;
#make Z -ve
table(nc+1, :) = - table(nc+1, :);
rel(nc+1) = 1;
#disp(table);
for i = 1:nc
    zero_vec = zeros(nc+1, 1);
    if( rel(i) == 1)
        zero_vec(i) += 1;
        table = [table zero_vec];
    endif;
endfor;
#Adding RHS to the last column
table = [table table(:, nv+1)];
table(:, nv+1) = [];
nv += sum(rel) - 1;
#applying dual simplex
disp(table);
pause;
[valmin, row] = min(table(1:nc, end));
while (valmin < 0)
    disp(table);
    pause;
    
#    temp1 = table(row, :end - 1);
#    temp2 = table(end, :end - 1);
    temp1 = table(row, 1:nv);
    temp2 = table(end, 1:nv);
#    disp("temp2 1");
#    disp(temp2);
    temp2(temp2==0) = 100000;
    temp1(temp1==0) = 1;
#    disp("temp1 2");
#    disp(temp1);
#    disp("temp2 2");
#    disp(temp2);
    res = temp2 ./ temp1;
#    disp("second\n");
#    disp(res);
#    pause;
    [t, col] = min(abs(res));
#    [t, col] = max(abs(res));
#    disp("col = ");
#    disp(col);
#    pause;
    val = table(row, col);
    table(row, :) /= val;
    for i=1:nc+1
        if (i != row)
            table(i, :) -= table(i, col) * table(row, :);
        endif;
    endfor;
    [valmin, row] = min(table(1:nc, end));
#    [valmin, row] = max(table(:, end));
endwhile;
#disp(table);
#disp(nv);
egg = table((table(:, 1) == 1), nv+1);
rice = table((table(:, 2) == 1), nv+1);
dal = table((table(:, 3) == 1), nv+1);
chapati = table((table(:, 4) == 1), nv+1);
disp(egg);
disp(rice);
disp(dal);
disp(chapati);
price = table(end, end);
clf;
array = [egg, rice, dal, chapati];
h = bar(array);
##set(h, 100, [10, 11, 12, 13]);
##set (h, 'r');
#title(h, ' bar() Title');
#legend(h, "hello");
