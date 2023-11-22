function sym_seq = huffman_dec(bin_seq, dict)
    sym_seq = {};  
    current_position = 1;  
    
    while current_position <= length(bin_seq)
        current_node = length(dict);  
        
        
        while ~isempty(dict{current_node, 3})
            if bin_seq(current_position) == '0'
                current_node = dict{current_node, 3};  
            else
                current_node = dict{current_node, 4};  
            end
            % current_node
            current_position = current_position + 1;  
        end
        
        
        sym_seq = [sym_seq, dict{current_node, 1}];
        % sym_seq
    end


    
end
