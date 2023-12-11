function [maxima, minima] = localMaxMin(v)
    flag= 0;
    % Initialize empty arrays for maxima and minima
    maxima = [];
    minima = [];
    
    % Iterate over the vector, excluding the first and last element
    for i = 2:length(v)-1
        % Check if current element is greater than its neighbors (local maxima)
        if v(i) > v(i-1) && v(i) > v(i+1) && flag== 0 && v(i)> 0
            maxima = [maxima, v(i)];
            flag= 1;
        % Check if current element is less than its neighbors (local minima)
        elseif v(i) < v(i-1) && v(i) < v(i+1) && flag== 1 && v(i)< 0
            minima = [minima, v(i)];
            flag= 0;
        end
    end

end
