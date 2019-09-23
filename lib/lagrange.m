% Lagrange is a function that calculate equations of motion (Lagrange's
% equations) d/dt(dL/d(dq))- dL/dq=0. It Uses  the Lagrangian that is a function that summarizes the
% dynamics of the system.  Symbolic Math Toolbox is required.
% 
% Equations=Lagrange(Lag,V)
%
% Lag = Lagrange of the system (symbolic).
% V   = System Variables (symbolic) [q1 dq1 ddq1 q2 dq2 ddq2... qn dqn
% ddqn].
% Equations   = [1 X DOF] (Degrees of freedom of the system).

function [M]=lagrange(Lag,V)
syms t;
Var=length(V)/3;
Vt=V;
    for cont0=1:1:Var
        Vt(cont0*3-2)=str2sym(strcat('f',num2str(cont0),'(t)'));
        Vt(cont0*3-1)=diff(Vt((cont0*3)-2),t);
        Vt(cont0*3)=diff(Vt((cont0*3)-2),t,2);
    end
    for cont0=1:1:Var
        L1=simplify(diff(Lag,V(cont0*3-1)));
        L2=simplify(diff(Lag,V(cont0*3-2)));
        Dposx=L1;

        for cont=1:1:Var*3         
             Dposx=subs(Dposx,V(cont),Vt(cont));
        end
        L1=diff(Dposx,t);

        for cont=Var*3:-1:1         %
             L1=subs(L1,Vt(cont),V(cont));
        end
        L1F=L1-L2;
        L1F=simplify(expand(L1F));
        L1F=collect(L1F,Vt(cont0*3)); 
        M(cont0)=L1F;
    end
end