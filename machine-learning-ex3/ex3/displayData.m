function [h, display_array] = displayData(X, example_width)
%DISPLAYDATA Display 2D data in a nice grid
%   [h, display_array] = DISPLAYDATA(X, example_width) displays 2D data
%   stored in X in a nice grid. It returns the figure handle h and the 
%   displayed array if requested.

% Set example_width automatically if not passed in
% 对结果取非运算，判断值/数组是否为空
if ~exist('example_width', 'var') || isempty(example_width) 
	example_width = round(sqrt(size(X, 2))); % sqrt平方根 round 四舍五入 20像素
end

% Gray Image
colormap(gray);

% Compute rows, cols
[m n] = size(X); % (100 * 400)
example_height = (n / example_width);  % 20像素

% Compute number of items to display
% floor 朝负无穷方向取整 ceil 朝正无穷方向取整 10组*10组
display_rows = floor(sqrt(m));
display_cols = ceil(m / display_rows);

% Between images padding 内边距
pad = 1;

% Setup blank display
% 1+10*(20+1)=211 像素 全图长宽各211个像素点
display_array = - ones(pad + display_rows * (example_height + pad), ...
                       pad + display_cols * (example_width + pad)); 

% Copy each example into a patch on the display array
% 像素数组赋值操作
curr_ex = 1;
for j = 1:display_rows
	for i = 1:display_cols
		if curr_ex > m, 
			break; 
		end
		% Copy the patch
		
		% Get the max value of the patch
		max_val = max(abs(X(curr_ex, :)));
		display_array(pad + (j - 1) * (example_height + pad) + (1:example_height), ...
		              pad + (i - 1) * (example_width + pad) + (1:example_width)) = ...
						reshape(X(curr_ex, :), example_height, example_width) / max_val;
						% reshape(A,m,n)将A排列成m*n，按列取，然后规约到(0,1)区间内，区域赋值
		curr_ex = curr_ex + 1;
	end
	if curr_ex > m, 
		break; 
	end
end

% Display Image
h = imagesc(display_array, [-1 1]); %(-1~1灰度范围)

% Do not show axis
axis image off

drawnow;

end
