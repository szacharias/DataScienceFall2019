

pic1 = "UB.png";
pic2 = "futurama.png";
pic3 = "square.png";

pic_list = [pic1, pic2 , pic3];

round_size = size(pic_list, 2);

for i = 1 : round_size

    img_filename = imread(pic_list(i));   

    [m , n , c ] = size(img_filename);
    
    base_number = min(m , n );
 
     
end

p_value_pic1 = [1, 5 , 10 , 50 , 100 , 200, 300 ];
p_value_pic2 = [1 ,5 ,  10 , 50,  100, 200 ,  300, 500 , 1000 ] ;
p_value_pic3 = [1 , 2 , 5 ,7 , 10  ] ;
p_value_list = [p_value_pic1 , p_value_pic2 , p_value_pic3];

figure('Name',pic1,'NumberTitle','off');
msah_hw6_p4b(pic1, p_value_pic1) 
% % 50
     
figure('Name',pic2,'NumberTitle','off');
msah_hw6_p4b(pic2, p_value_pic2) 
% % 100


figure('Name',pic3,'NumberTitle','off');
msah_hw6_p4b(pic3, p_value_pic3) 
% % > 1 
