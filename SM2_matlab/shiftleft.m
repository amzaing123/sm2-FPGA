function result = shift(str,l)
% str = '10101010101010101010101010101010';  % 32位比特串
shift = l;  % 左移的位数

% 对比特串进行循环左移
result = [str(shift+1:end) str(1:shift)];
