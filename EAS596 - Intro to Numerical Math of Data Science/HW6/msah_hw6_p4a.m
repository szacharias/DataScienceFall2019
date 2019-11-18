function [img ] = msah_hw6_p4a(f,p)

% filename = "UB.png";
filename = f;
rank = p;


img_filename = imread(filename);  
imshow(img_filename)

double_value_filename = double(img_filename);


[m , n , c ] = size(img_filename);
 

R = double_value_filename( : , : , 1 ) ;
G = double_value_filename( : , : , 2 ) ;
B = double_value_filename( : , : , 3 ) ;
 

[ uR ,sR, vR ] = svd(R);
[ uG ,sG, vG ] = svd(G);
[ uB ,sB, vB ] = svd(B);
 
SR = sR;
SB = sB;
SG = sG;


SR( rank+1 : m , : ) = 0 ;
SR( : , rank+1 : n ) = 0 ;

SG(rank+1 : m , : ) = 0 ;
SG( : , rank+1 : n ) = 0 ;

SB(rank+1 : m , : ) = 0 ;
SB( : , rank+1 : n ) = 0 ;


vR = vR';
vG = vG';
vB = vB'; 

output_image_r = uR(:, 1:rank) * SR(1:rank , 1: rank) * vR(1:rank , :);  
output_image_g = uG(:, 1:rank) * SG(1:rank , 1: rank) * vG(1:rank , :) ;
output_image_b = uB(:, 1:rank) * SB(1:rank , 1: rank) * vB(1:rank , :) ;

output_image_r = uint8(output_image_r);
output_image_g = uint8(output_image_g);
output_image_b = uint8(output_image_b);
 
img = cat(3 ,output_image_r , output_image_g, output_image_b); 
imshow(img)

end

