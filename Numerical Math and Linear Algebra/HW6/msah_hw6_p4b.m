function msah_hw6_p4b(f,p)


file_name = f ;
p_values = p ;

round_times  = size(p_values, 2 )  ;
row_count_prelim = round_times + 1 ;

rows = ceil( row_count_prelim / 3 ) ;

subplot(rows, 3, 1)
imshow(file_name)
title("Original")


for i = 1 : round_times
    current_value = p_values(i);
    img = msah_hw6_p4a(file_name , current_value);
    subplot(rows, 3, i+1)
    imshow(img)
    title(sprintf('Rank = %d', current_value))

end

end

