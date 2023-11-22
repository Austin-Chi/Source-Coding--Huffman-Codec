function [len, shannon_entropy, avg_length] = huffman_sample(n, R, p, iid)

    symbols = cell(1, n); 
    probabilities = [0.2, 0.05, 0.005, 0.2, 0.3, 0.05, 0.045, 0.15];
    
    % construct i.i.d. probabilities for three symbols
    iid_probs = zeros(1, length(probabilities)*length(probabilities)*length(probabilities));
    syms = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'};
    iid_symbols = cell(1, length(syms)*length(syms)*length(syms));
    for i = 1:length(probabilities)
        for j = 1:length(probabilities)
            for k = 1:length(probabilities)
                iid_probs((i-1)*length(probabilities)*length(probabilities) + (j-1)*length(probabilities) + k) = probabilities(i)*probabilities(j)*probabilities(k);
                iid_symbols{(i-1)*length(probabilities)*length(probabilities) + (j-1)*length(probabilities) + k} = strcat(syms{i}, syms{j}, syms{k});
            end
        end
    end
    if iid == true
        probabilities = iid_probs;
        syms = iid_symbols;
    end
    %calculate the binary shannon entropy
    shannon_entropy = -sum(probabilities.*log2(probabilities));
    [dict, avg_length]= huffman_dict(syms, probabilities);
    % dict
    encoded_len = zeros(1, R);
    
    for j = 1:R
        for i = 1:n
            
            symbol_index = randsample(length(probabilities), 1, true, probabilities);
            
            
            %letters = 'abcdefgh';
            %symbol = letters(symbol_index);
            symbol = syms{symbol_index};
            
            symbols{i} = symbol;
        end
        
        bin_seq = huffman_enc(symbols, dict);
        encoded_len(j) = length(bin_seq);
    end
    
    
    

    bin_seq = huffman_enc(symbols, dict);
    

    %print the length of the binary sequence
    len = length(bin_seq);
    if R == 1
        symbols
        bin_seq
        len
    end
    %calculate the mean of the length of the binary sequence
    mean_len = mean(encoded_len);

    %if p is true, print the histogram
    if p == true
       
        bin_edges = unique(encoded_len);
        histogram(encoded_len, bin_edges, 'Normalization', 'count', 'FaceColor', 'b', 'EdgeColor', 'k');

        
        xlabel('Length');
        ylabel('Count');
        title('Mean: ', mean_len);

        
        grid on;
    end
    if iid == true
        len = mean_len/3;
        shannon_entropy = shannon_entropy/3;
        avg_length = avg_length/3;
    else
        len = mean_len;
    end


end
