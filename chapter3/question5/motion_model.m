function [Xt, Pt] = motion_model(Xt_1, ut, Pt_1)

At = 1; Bt = 1;
Anewt = [At 1 0;
         0  1 0;
         0  0 1];
Bnewt = [Bt; 0; 0];

Xt = Anewt*Xt_1 + Bnewt*ut;
Pt = Anewt*Pt_1*Anewt' + R;
end