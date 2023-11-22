function bin_seq = huffman_enc(sym_seq, dict)
    bin_seq = '';
    for i = 1:length(sym_seq)
        for j = 1:length(dict)
            if strcmp(sym_seq{i}, dict{j, 1})
                bin_seq = strcat(bin_seq, dict{j, 5});
                break;
            end
        end
    end
    
end
