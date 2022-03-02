function f_tertiary = simulateBraille(input_char, lateral_inhibition_flag, I)

% Parameters
E_syn = zeros(5*7,1);
A_pp_I = 3;
Stim = zeros(5*7,1)';

% Stimulate Braille character
if input_char == 1
    Stim = simulate_E(Stim, I);
end
if input_char == 2
     Stim =  simulate_J(Stim, I);
end
if input_char == 3
    Stim = simulate_R(Stim, I);
end
if input_char == 4
     Stim =  simulate_U(Stim, I);
end

% If no lateral inhibition, turn back to 0
if ~lateral_inhibition_flag
    E_syn = zeros(5*7,1);
end

% Stimulate second layer
spike_trains = simulateSecondLayer(Stim); 
% Stimulate third layer
f_tertiary = simulateTertiaryLayer(A_pp_I, spike_trains, E_syn);
    function Stim = simulate_E(Stim, I)
        Stim(7) = I;
        Stim(19) = I;
        E_syn = create_E_syn(E_syn,7);
        E_syn = create_E_syn(E_syn,19);
    end
    function Stim = simulate_J(Stim,I)
        Stim(9) = I;
        Stim(19) = I;
        Stim(17) = I;
        E_syn = create_E_syn(E_syn,7);
        E_syn = create_E_syn(E_syn,19);
        E_syn = create_E_syn(E_syn,17);

    end
    function Stim = simulate_R(Stim,I)
        Stim(7) = I;
        Stim(17) = I;
        Stim(27) = I;
        Stim(19) = I;
        E_syn = create_E_syn(E_syn,7);
        E_syn = create_E_syn(E_syn,17);
        E_syn = create_E_syn(E_syn,27);
        E_syn = create_E_syn(E_syn,19);
    end
    function Stim = simulate_U(Stim, I)
        Stim(7) = I;
        Stim(27) = I;
        Stim(29) = I;
        E_syn = create_E_syn(E_syn,7);
        E_syn = create_E_syn(E_syn,19);
        E_syn = create_E_syn(E_syn,27);
    end
end

function E_syn = create_E_syn(E_syn, pos)
    r = [1 4 5 6];
    for i = 1:length(r)
        E_syn(pos+r(i)) = -75;
        E_syn(pos-r(i)) = -75;
    end

end