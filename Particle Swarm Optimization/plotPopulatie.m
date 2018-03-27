function [] = plotPopulatie(fun,bereik,populatiematrix)

fig=figure;
set(fig,'Position',[50 50 800 800]);
ax=axes;
axis([bereik(1,1) bereik(1,2) bereik(2,1) bereik(2,2) 0 1]);
view([0 90]);
a = size(populatiematrix);

for t = 1:1:a(3)
    
    xbereik=bereik(1,1):0.2:bereik(1,2);
    ybereik=bereik(2,1):0.2:bereik(2,2);
    [Xbereik,Ybereik]=meshgrid(xbereik,ybereik);
    Zbereik=zeros(size(Xbereik));
    Zbereik(:)=fun([Xbereik(:) Ybereik(:)]);
    surf(ax,Xbereik,Ybereik,Zbereik,'EdgeColor','none');
    colormap(bone);
    
    view(0,90);
    hold on;
    
    x = populatiematrix(:,:,t);
    
    for k=1:size(x,1)
        plot3(x(k,1),x(k,2),fun(k)+1,'.','MarkerSize',10,'MarkerEdgeColor','r');
    end
    hold off;
    M(t)=getframe(fig);
    
    if t == 1
        Ani(1) = getframe;
        im = frame2im(Ani(1)); 
        [imind,cm] = rgb2ind(im,256); 
        imwrite(imind,cm,'ParticleSwarm.gif','gif', 'Loopcount',inf);
    end
    
    Ani(1) = getframe;
    im = frame2im(Ani(1)); 
    [imind,cm] = rgb2ind(im,256); 
    imwrite(imind,cm,'ParticleSwarm.gif','gif','WriteMode','append'); 
    
    end


end


