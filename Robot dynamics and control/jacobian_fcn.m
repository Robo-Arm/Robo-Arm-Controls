function Jacobi_camera = jacobian_fcn(q_1,q_2,q_3,q_4,q_5)
%JACOBIAN_FCN
%    Jacobi_camera = JACOBIAN_FCN(Q_1,Q_2,Q_3,Q_4,Q_5)

%    This function was generated by the Symbolic Math Toolbox version 9.0.
%    21-Jun-2022 12:53:05

t2 = cos(q_1);
t3 = cos(q_3);
t4 = cos(q_5);
t5 = sin(q_1);
t6 = sin(q_3);
t7 = sin(q_5);
t8 = q_1+q_5;
t9 = q_2+q_3+q_4;
t10 = -q_1;
t11 = -q_5;
t15 = pi./2.0;
t12 = cos(t9);
t13 = q_1+t9;
t14 = -t2;
t17 = t8+t9;
t19 = q_1+t11;
t20 = -t15;
t21 = t3.*(9.0./5.0e+1);
t22 = t4./2.0e+2;
t23 = t6.*(9.0./5.0e+1);
t26 = t9+t10;
t35 = -t8+t9;
t16 = cos(t13);
t18 = sin(t13);
t24 = q_2+t20;
t25 = q_4+t20;
t29 = cos(t26);
t32 = t11+t13;
t33 = q_5+t26;
t34 = sin(t26);
t58 = t22+9.350000000000001e-2;
t27 = cos(t24);
t28 = cos(t25);
t30 = sin(t24);
t31 = sin(t25);
t36 = t27.*(3.0./1.0e+1);
t37 = t30.*(3.0./1.0e+1);
t38 = t22.*t28;
t39 = t22.*t31;
t40 = (t7.*t28)./2.0e+2;
t41 = (t7.*t31)./2.0e+2;
t42 = t4.*t28.*3.061616997868383e-19;
t43 = t4.*t31.*3.061616997868383e-19;
t44 = t7.*t28.*3.061616997868383e-19;
t45 = t7.*t31.*3.061616997868383e-19;
t48 = t28.*1.354e-1;
t49 = t31.*1.354e-1;
t46 = -t42;
t47 = -t45;
t50 = t39+t44;
t51 = -t49;
t52 = t38+t47;
t53 = t3.*t50;
t54 = t6.*t50;
t59 = t41+t46+t48;
t60 = t40+t43+t51;
t55 = t3.*t52;
t56 = t6.*t52;
t57 = -t54;
t61 = t3.*t59;
t62 = t3.*t60;
t63 = t6.*t59;
t64 = t6.*t60;
t65 = -t63;
t66 = t53+t56;
t67 = t55+t57;
t70 = -t27.*(t54-t55);
t71 = -t30.*(t54-t55);
t73 = t61+t64;
t68 = t27.*t66;
t69 = t30.*t66;
t74 = t62+t65;
t75 = t23+t73;
t77 = t27.*t73;
t78 = t30.*t73;
t72 = -t69;
t76 = t21+t74;
t79 = t27.*t74;
t80 = t30.*t74;
t81 = -t78;
t82 = t27.*t75;
t83 = t30.*t75;
t88 = t68+t71;
t84 = t27.*t76;
t85 = t30.*t76;
t86 = -t83;
t89 = t70+t72;
t90 = t77+t80;
t91 = t79+t81;
t87 = -t84;
t92 = t82+t85;
t93 = t84+t86;
t94 = t37+t92;
t95 = t36+t93;
et1 = t5.*3.749399456654644e-33;
et2 = t18.*(-3.061616997868383e-17);
et3 = t34.*(-3.061616997868383e-17)+sin(t8)./2.0;
et4 = sin(t17).*2.5e-1+sin(t19)./2.0;
et5 = sin(t32).*(-2.5e-1);
et6 = sin(t33).*2.5e-1;
et7 = sin(t35).*(-2.5e-1);
et8 = t2.*(-3.749399456654644e-33);
et9 = t16.*3.061616997868383e-17;
et10 = t29.*(-3.061616997868383e-17)-cos(t8)./2.0;
et11 = cos(t17).*(-2.5e-1)-cos(t19)./2.0;
et12 = cos(t32).*2.5e-1;
et13 = cos(t33).*2.5e-1;
et14 = cos(t35).*(-2.5e-1);
et15 = t4.*6.123233995736766e-17+t12.*6.123233995736766e-17-cos(q_5+t9).*5.0e-1;
et16 = cos(t9+t11).*5.0e-1;
et17 = 2.295845021658468e-49;
mt1 = [t2.*t58+t2.*t94.*6.123233995736766e-17+t5.*t95,t5.*t58+t5.*t94.*6.123233995736766e-17+t14.*t95,0.0,t5,t14,6.123233995736766e-17];
mt2 = [t2.*t94+t5.*t95.*6.123233995736766e-17,t2.*t95.*(-6.123233995736766e-17)+t5.*t94,-t36+t83+t87,t5,t14,6.123233995736766e-17];
mt3 = [t5.*(t83+t87).*(-6.123233995736766e-17)+t2.*t92,t2.*(t83+t87).*6.123233995736766e-17+t5.*t92,t83+t87,t5,t14,6.123233995736766e-17];
mt4 = [-t14.*t90-t5.*(t78-t79).*6.123233995736766e-17,t5.*t90+t2.*(t78-t79).*6.123233995736766e-17,t78-t79];
mt5 = [t5.*6.123233995736766e-17-t18.*5.0e-1-t34.*5.0e-1];
mt6 = [t2.*(-6.123233995736766e-17)+t16.*5.0e-1-t29.*5.0e-1];
mt7 = [t12+3.749399456654644e-33,-t14.*(t69+t27.*(t54-t55))-(t5.*t7)./2.0e+2+t5.*t88.*6.123233995736766e-17];
mt8 = [t5.*(t69+t27.*(t54-t55))+(t2.*t7)./2.0e+2-t2.*t88.*6.123233995736766e-17,t7.*(-3.061616997868383e-19)-t68+t30.*(t54-t55),et1+et2+et3+et4+et5+et6+et7,et8+et9+et10+et11+et12+et13+et14,et15+et16+et17,0.0,0.0,0.0,0.0,0.0,0.0];
Jacobi_camera = reshape([mt1,mt2,mt3,mt4,mt5,mt6,mt7,mt8],6,6);
