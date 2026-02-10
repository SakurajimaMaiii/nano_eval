Eval mmlu


First, download mmlu
```python
import pandas as pd
import json

url = "https://openaipublic.blob.core.windows.net/simple-evals/mmlu.csv"
save_path = "mmlu_test.jsonl"
df = pd.read_csv(url)
examples = [row.to_dict() for _, row in df.iterrows()]

results = []
for example in examples:
    question = example["Question"]
    choices = [example["A"],example["B"],example["C"],example["D"]]
    answer = example["Answer"]
    subject = example["Subject"]
    results.append({"question":question,
                    "choices":choices,
                   "answer":answer,
                   "subject":subject})

print(len(results))
with open(save_path, "w", encoding="utf-8") as f:
    for sample in results:
        f.write(json.dumps(sample, ensure_ascii=False) + "\n")
print("Saved to", save_path)

test = []
with open(save_path, "r", encoding="utf-8") as f:
    for line in f:
        test.append(json.loads(line))
print(len(test))
```



