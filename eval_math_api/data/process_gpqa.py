import random
import json
import pandas as pd

ALL_CHOICES = ["A","B","C","D"]

# reference https://github.com/zai-org/glm-simple-evals/blob/main/evals/gpqa_eval.py

def question_to_prompt(choices):
    prompt = ["Answer the following multiple choice question. The last line of your response should be of the following format: 'ANSWER: $LETTER' (without quotes) where LETTER is one of ABCD. Think step by step before answering."]
    prompt.append(choices["Question"])
    
    for option in ALL_CHOICES:
        prompt.append(f"{option}) " + choices[option])
        
    prompt = "\n".join(prompt)
    return prompt.strip()

df = pd.read_csv("gpqa_diamond.csv")
examples = [row.to_dict() for _, row in df.iterrows()]

rng = random.Random(0)
examples = [
    example | {"permutation": rng.sample(range(4), 4)} for example in examples
]

res = []
for row in examples:
    choices = [
        row["Correct Answer"],
        row["Incorrect Answer 1"],
        row["Incorrect Answer 2"],
        row["Incorrect Answer 3"],
    ]
    choices = [choices[i] for i in row["permutation"]]
    correct_index = choices.index(row["Correct Answer"])
    correct_answer = "ABCD"[correct_index]

    choices_dict = dict(
        A=choices[0], B=choices[1], C=choices[2], D=choices[3], Question=row["Question"]
    )

    prompt = question_to_prompt(choices_dict)
    answer = correct_answer
    tmp = {"prompt": prompt, "answer": answer}

    res.append(tmp)

with open("gpqa_diamond.jsonl", "w", encoding="utf-8") as f:
    for item in res:
        f.write(json.dumps(item, ensure_ascii=False) + "\n")

print(f"Saved {len(res)} examples to gpqa_diamond.jsonl")