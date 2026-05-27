import pandas as pd
import json
# current only https://huggingface.co/datasets/MathArena/hmmt_feb_2025
# nov: https://huggingface.co/datasets/MathArena/hmmt_nov_2025
suffix = """Please reason step by step, and put your final answer within \\boxed{}."""

df = pd.read_parquet("data/train-00000-of-00001.parquet")

output_file = "hmmt25.jsonl"

with open(output_file, "w", encoding="utf-8") as f:
    for _, row in df.iterrows():
        record = row.to_dict()
        question = record["problem"]
        answer = record["answer"]
        tmp = {"prompt":question+"\n"+suffix, "answer": answer}
        f.write(json.dumps(tmp, ensure_ascii=False) + "\n")

print(f"Saved to {output_file}")
print(record)