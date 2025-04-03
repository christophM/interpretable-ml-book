
redirects = {
    "properties.html": "interpretability.html#properties",
    "explanation.html": "interpretability.html#explanation",
    "bike-data.html": "data.html#bike-data",
    "spam-data.html": "data.html#spam-data",
    "cervical.html": "data.html#penguins",
    "terminology.html": "what-is-machine-learning.html",
    "global-methods.html": "overview.html#global-methods",
    "example-based.html": "overview.html#example-based",
    "agnostic.html": "overview.html#agnostic",
    "neural-networks.html": "overview.html#neural-networks",
    "simple.html": "overview.html#simple",
    "preface-by-the-author.html": "index.html",
    "other-interpretable.html": "overview.html",
    "scope-of-interpretability.html": "overview.html",
    "taxonomy-of-interpretability-methods.html": "overview.html",
    "evaluation-of-interpretability.html": "evaluation.html",
    "interpretability-importance.html": "interpretability.html",
}

import os

output_dir = "./_book/"  # Change to "_site" if needed
os.makedirs(output_dir, exist_ok=True)

html_template = """<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="refresh" content="0; url={new}">
    <script>window.location.href = "{new}";</script>
</head>
<body>
    <p>If you are not redirected, <a href="{new}">click here</a>.</p>
</body>
</html>
"""

for old, new in redirects.items():
    with open(os.path.join(output_dir, old), "w") as f:
        f.write(html_template.format(new=new))

print("Redirect pages generated.")
