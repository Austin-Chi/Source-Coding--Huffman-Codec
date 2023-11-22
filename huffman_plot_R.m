function hi = huffman_plot_R(iid)

    R_values = [10, 20, 50, 100, 200, 500, 1000];
    H_X = 2.53214;  
    L_avg = 2.6;  

    n_values = [10, 50, 100];
    
    Ln_values = zeros(length(n_values), length(R_values));
    for i = 1:length(n_values)
        n = n_values(i);
        for j = 1:length(R_values)
            R = R_values(j);
            [Ln_values(i, j), H_X, L_avg] = huffman_sample(n, R, false, iid);
            Ln_values(i, j) = Ln_values(i, j) / n;

        end
    end
    
    % H_X
    % L_avg

    
    semilogx(R_values, H_X * ones(size(R_values)), '--r', 'LineWidth', 1.5, 'DisplayName', 'H[X]');
    hold on;
    semilogx(R_values, L_avg * ones(size(R_values)), '--g', 'LineWidth', 1.5, 'DisplayName', 'L');

    
    colors = {'b', 'm', 'c'};
    for i = 1:length(n_values)
        semilogx(R_values, Ln_values(i, :), 'LineWidth', 1.5, 'Color', colors{i}, 'DisplayName', sprintf('n = %d', n_values(i)));
    end
    

    
    xlabel('Monte–Carlo Runs (R) [log scale]');
    ylabel('Average Codeword Length (Ln) and Entropy (H[X])');
    title('Average Codeword Length vs. Monte–Carlo Runs');
    grid on;
    legend('Location', 'Best');

    
    hold off;

    hi =Ln_values;

end
