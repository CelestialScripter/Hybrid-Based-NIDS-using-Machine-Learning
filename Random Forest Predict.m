function pred = randomForestPredict(model, X)
% RANDOMFORESTPREDICT returns a vector of predictions using a trained random forest model.
%   pred = RANDOMFORESTPREDICT(model, X) returns a vector of predictions using a
%   trained random forest model. X is an m x n matrix where each example is a row.
%   model is a random forest model returned from the training process.
%   The predictions pred is an m x 1 column of predicted class labels.

% Check if we are getting a column vector, if so, then assume that we only
% need to do prediction for a single example
if (size(X, 2) == 1)
    % Examples should be in rows
    X = X';
end

% Dataset
m = size(X, 1);
pred = zeros(m, 1);

% Make predictions using the random forest model
for i = 1:m
    example = X(i, :);
    treePredictions = zeros(model.numTrees, 1);
    for j = 1:model.numTrees
        tree = model.trees{j};
        treePredictions(j) = predictTree(tree, example);
    end
    pred(i) = mode(treePredictions);
end

end

function prediction = predictTree(tree, example)
% PREDICTTREE returns the predicted class label for a given example using a decision tree.
%   prediction = PREDICTTREE(tree, example) returns the predicted class label
%   for a given example using a decision tree. tree is a trained decision tree
%   structure, and example is a vector representing a single example.

node = tree;
while ~isempty(node.children)
    feature = node.feature;
    if example(feature) <= node.threshold
        node = node.children{1};
    else
        node = node.children{2};
    end
end
prediction = node.classLabel;

end 

