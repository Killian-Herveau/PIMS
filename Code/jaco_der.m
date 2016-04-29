function [ resultat ] = jaco_der( k,offset,A,mu1,mu2,s,x,y,e )
%derivée par rapport à chaque variable de :
% f(x,y) =offset + A*exp( -( ( x-mu1).^2+(y-mu2).^2 ) /(2*s^2) )
%%

if k==1%offset
    resultat=ones(size(x,1),1);
elseif k==2%A
    resultat=e;
elseif k==3%mu1
    resultat= A*( x-mu1 ).*e/s^2;
elseif k==4%mu2
    resultat=A*( y-mu2 ).*e/s^2;
elseif k==5%sigma
    resultat=(1/s^3)*e.*( (x-mu1).^2+(y-mu2).^2 );
end
end