import shap
import xgboost
import pandas as pd

# Read cervical cancer data
cerv = pd.read_csv("../../data/cervical.csv")
y = cerv["Biopsy"].values == "Healthy"
X = cerv.drop(["Biopsy"], axis=1)

# Train model, e.g. random forest
mod = xgboost.train({"learning_rate": 0.01}, xgboost.DMatrix(X, label=y), 100)

explainer = shap.TreeExplainer(mod.predict, X, link = "logit")
shap_values = explainer.shap_values(X)

# Explain individual predictions
shap.force_plot(explainer.expected_value, shap_values[4,:], X.iloc[4,:], matplotlib = True, link = "logit")

# Plot feature effect
shap.dependence_plot("Age", shap_values, X, matplotlib = True, link = "logit")

# Plot instance clustering
shap.force_plot(explainer.expected_value, shap_values, X, link = "logit")


# Plot feature interaction

# Plot feature importance
shap.summary_plot(shap_values, X, plot_type = "bar", matplotlib = True)


# Bike data analysis?
