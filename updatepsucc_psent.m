function updatepsucc_psent()
    global lossMat sentMat psucc_psent

    temp = lossMat./sentMat;
    temp = 1-temp;
    for i=1:size(temp,1)
        temp(i,i) = 1;
    end
    
    psucc_psent = temp;

end
