% EXPERIMENT 2 CENTRAL LIMIT THEOREM
% Experiment 2 (CLT)
% Parameters
population_size = 10000;
num_samples = 1000;
sample_size = 30;

% Defining the population array
population = exprnd(2, 1, population_size);
sample_means = zeros(1, num_samples);

% For loop to iteratively compute the sample means and append to the array
for i = 1 : num_samples
    for i = 1 : num_samples
        sample = randsample(population, sample_size, true);
        sample_means(i) = mean(sample);
    end
end

% Plotting the population
figure(1);
subplot(2, 1, 1);
histogram(population, 'Normalization', 'pdf', 'EdgeColor', 'none');
title("Histogram of the population");
xlabel("value");
ylabel("probability density");

subplot(2, 1, 2);
histogram(sample_means, 'Normalization', 'pdf', 'EdgeColor', 'none');
title("Sample means of the population");
xlabel("sample");
ylabel("Sample means");

% Deriving the PDF of the sample means and plotting them
mu_population = mean(population);
sigma_population = std(population);
expected_mean = mean(sample_means);
expected_std = sigma_population / sqrt(num_samples);
x = linspace(min(sample_means), max(sample_means), 100);
y = normpdf(x, expected_mean, expected_std);

figure(2);
plot(x, y, 'r', 'LineWidth', 2);
xlabel("sample mean");
ylabel("probability value");
title("PDF of sample means");
