clc, clear all, close all;

media_url='C:\Users\pegah\Desktop\Result\paches_dif\dif_patches\';
files = dir(strcat(media_url,'Ground_truth\*.tiff'));
TargetImage = (imread(strcat(media_url,'7.tiff')));
output_url=media_url;

%% Display results of each method
verbose = 0;

n=0;
tic;
for file = files'
    
    %     if(n==3)
    %         break;
    %     end
    %
    
    file_name=file.name;
    n = n +1;
    
    
    fprintf('staining  %s.\n',file_name);
    %     src_url=strcat(media_url,'/unstained/tumor/',file_name)
    SourceImage = (imread(strcat(media_url,'Ground_truth\',file_name)));
    
    disp('Stain Normalisation using Reinhard''s Method');
    
    [ NormRH ] = Norm( SourceImage, TargetImage, 'Reinhard', verbose );
    
    imwrite(NormRH,strcat(output_url,'Reinhard\',file_name));
    
    
    %     imshow(SourceImage)
    %             try
    [ NormSM ] = Norm(SourceImage, TargetImage, 'SCD', [], 0);
    imwrite(NormSM,strcat(output_url,'Khan\',file_name));
    
    %% Stain Normalisation using Macenko's Method
    %
    [ NormMM ] = Norm(SourceImage, TargetImage, 'Macenko', 255, 0.15, 1, verbose);
    %
    imwrite(NormMM,strcat(output_url,'Macenko\',file_name));
    %
    %         catch
    %             warning('Problem using function.  Assigning a value of 0.');
    %         end
end


toc;