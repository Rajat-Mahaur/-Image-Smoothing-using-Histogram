clc;
clear;
close;

a=imread('women.jpg');

b=size(a);
a=double(a);
hist1=zeros(1,256);

for i=1:b(1)
    for j=1:b(2)
        for k=0:255
            if a(i,j)==k
                hist1(k+1)=hist1(k+1)+1;
            end
        end
    end
end

pdf=(1/(b(1)*b(2)))*hist1;
cdf=zeros(1,256);
cdf(1)=pdf(1);
for i=2:256
    cdf(i)=cdf(i-1)+pdf(i);
end
cdf=round(255*cdf);

ep=zeros(b);
for i=1:b(1)
    for j=1:b(2)
        t=(a(i,j)+1);
        ep(i,j)=cdf(t);
    end
end



hist2=zeros(1,256);

for i=1:b(1)
    for j=1:b(2)
        for k=0:255
            if ep(i,j)==k
                hist2(k+1)=hist2(k+1)+1;
            end
        end
    end
end



subplot(2,2,1);
imshow(uint8(a));
subplot(2,2,3);
imshow(uint8(ep));
subplot(2,2,2);
plot(hist1);
subplot(2,2,4);
plot(hist2);


[m,n]=size(a);
output=zeros(m,n);
output=uint8(ep);
for i=1:m
    for j=1:n
        rmin=max(1,i-1);
        rmax=min(m,i+1);
        cmin=max(1,j-1);
        cmax=min(n,j+1);
        temp=a(rmin:rmax,cmin:cmax);
        output(i,j)=mean(temp(:));
    end
end






subplot(122),imshow(output),title('output image');
