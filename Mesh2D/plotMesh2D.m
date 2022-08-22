function plotMesh2D(FeCoord,FeTopo)
% function for 2D visualization of mesh
%
%-----------------inputs:
%                FeCoord: FE nodal coordinates
%                 FeTopo: FE connectivity matrix
%
%
%% step-1: set plotting properties
se = 'm-';
hold on

%% step-2: set element local ordering
elem_order = [1 2 3 4 1];

%% step-3: loop over number of elements
for el = 1:size(FeTopo,1)
    
   % get elemental coordinates (x, y) 
   xpt = FeCoord(FeTopo(el,elem_order),1);
   ypt = FeCoord(FeTopo(el,elem_order),2);
   
   % plot the current element using fill function
   h = fill(xpt,ypt,se);
   set(h,'LineWidth',1)
end

% set axis properties
axis equal
xlabel('x') 
ylabel('y')
hold off;

end