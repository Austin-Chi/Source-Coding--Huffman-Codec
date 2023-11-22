function [dict, avg_length]= huffman_dict(symbols, prob)
    if length(symbols) ~= length(prob)
        error('Input vectors must have the same length');
    end
    
    N = length(symbols);
    % Create initial node list
    nodes = struct('name', {}, 'prob', {}, 'left', {}, 'right', {}, 'code', {});
    for i = 1:length(symbols)
        nodes(i).name = symbols(i);
        nodes(i).prob = prob(i);
    end
    
    % Create Huffman tree
    while length(nodes) > 1
        % Sort nodes by probability
        [sorted_prob, sort_idx] = sort([nodes.prob]);
        nodes = nodes(sort_idx);
        
        % Combine the two nodes with lowest probabilities
        %Combine the two nodes' names into a new string
        new_node.name = strcat(nodes(2).name, nodes(1).name);
        new_node.prob = nodes(1).prob + nodes(2).prob;
        new_node.left = nodes(2);
        new_node.right = nodes(1);
        new_node.code = '';
        % new_node
        % new_node.left
        
        % Remove the combined nodes from the list
        nodes = nodes(3:end);
        
        % Add the new combined node to the list
        nodes = [nodes, new_node];
        symbols = [symbols, new_node.name];
        prob = [prob, new_node.prob];
    end

    % Generate Huffman codes
    dict = cell(length(symbols), 5);
    for i = 1:length(symbols)
        dict{i, 1} = symbols{i};
        dict{i, 2} = prob(i);

    end

    % Generate Huffman codes

    nodes(1).code = '';
    while ~isempty(nodes)
        % Get the first node
        node = nodes(1);
        
        % If the node is a leaf, add its code to the dictionary
        if isempty(node.left) && isempty(node.right)
            idx = 0;
            for i = 1:length(symbols)
                if strcmp(symbols{i}, node.name{1})
                    idx = i; 
                    break;  
                end
            end
            
            dict{idx, 5} = node.code;
            
            % Move to the next node
            nodes = nodes(2:end);
        else
            idx = 0;
            for i = 1:length(symbols)
                if strcmp(symbols{i}, node.name{1})
                    idx = i;  
                    break;  
                end
            end
            % symbols
            % node.name{1}
            % idx
            if ~isempty(node.code)
                dict{idx, 5} = node.code;
            end
            idx_left = 0;
            for i = 1:length(symbols)
                if strcmp(symbols{i}, node.left.name{1})
                    idx_left = i;  
                    break;  
                end
            end
            idx_right = 0;
            for i = 1:length(symbols)
                if strcmp(symbols{i}, node.right.name{1})
                    idx_right = i; 
                    break;  
                end
            end
            dict{idx, 3} = idx_left;
            dict{idx, 4} = idx_right;
            
            % Move to the next node
            nodes = nodes(2:end);
            
            % Add the left node to the list
            node.left.code = [node.code, '0'];
            nodes = [nodes, node.left];
            
            % Add the right node to the list
            node.right.code = [node.code, '1'];
            nodes = [nodes, node.right];
        end
    end

    %calculate the average length of the code
    avg_length = 0;
    for i = 1:N
        avg_length = avg_length + dict{i, 2} * length(dict{i, 5});
        % dict{i, 2}
        % length(dict{i, 5})
        % avg_length
    end
    % avg_length
    
    
end
