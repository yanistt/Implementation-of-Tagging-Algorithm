function [C,nb_composantes_FC] = Algomarq(MAT)
%==================================================================%
%Entree :  matrice d'adajence n*n 
%Sortie : vecteur ligne avec l'indice qui correspond au sommet et la case a
% sa composante fortement connexe
%==================================================================%
F=MAT;
L=length(MAT);
T=find(MAT(:,1)~=0); %on commce tout d'abord par vérifier la connexité du graphe
T=[T;1]';
M=sum(MAT(:,T),2);
T1=union(find(M~=0),T);
while length(T1)>length(T)
    T=T1;
    M=sum(MAT(:,T),2);
    T1=union(find(M~=0),T);
end
if length(T)==L
    idx=1; % graphe non connexe
    Group=T;
else
    idx=0;
    Group=T; %graphe connexe
end
if (idx==1)
    disp("il est connexe")
else
    disp("il est pas connexe")
end 
    MAT=F;
    MAT = MAT';  
  [arg1,arg2,nbcomp] = dmperm(MAT+speye(L)); %dmperm pour voir si 
  %le graphe est constitué d'un ou plusieurs composants connectés selon
  %l'adjacence directs et indirect des voisin (fonction prédéfinie de
  %Matlab), speye sert à renvoyer une matrice d'identité n * n, avec des 
  %uns sur la diagonale principale et des zéros ailleurs, ce qui nous
  %permettera d'avoir la distribution des composantes, une matrice carrée
  %en trouvant une permutation de ligne p et une permutation de colonne q de 
  %sorte que A(p,q) soit sous forme de bloc triangulaire supérieur
  C = cumsum(full(sparse(1,nbcomp(1:end-1),1,1,size(MAT,1))));
  %on Crée le vecteur ligne dont l'indice correspond au sommet et la case a
 % sa composante fortement connexe
  C(arg1) = C; 
  Fln=1:L;
  A=setdiff(Fln,C);
  nb_composantes_FC = numel(Fln)-numel(A) 
% S représente le nombre de composante

end