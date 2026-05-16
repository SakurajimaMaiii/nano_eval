import json
import argparse
from collections import defaultdict, Counter


def read_jsonl(file_path):
    data = []
    with open(file_path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line:
                data.append(json.loads(line))
    return data


def group_by_key(data, key):
    grouped = defaultdict(list)
    for item in data:
        if key in item:
            grouped[item[key]].append(item)
    return dict(grouped)


def process_grouped_data(grouped_data, key2):
    result = {}

    for k, items in grouped_data.items():
        key2_values = [item.get(key2) for item in items if key2 in item]
        result[k] = key2_values

    return result


def get_pass(result):
    total = len(result)
    pass_right = 0
    for _, r in result.items():
        rr = [int(s) for s in r]
        if sum(rr) > 0:
            pass_right += 1

    return pass_right, total, pass_right / total * 100


def main(file_path, question_key, answer_key, parsed_answer_key):
    data = read_jsonl(file_path)

    grouped = group_by_key(data, question_key)

    total, right_major, right_pass = 0, 0, 0
    for _, v in grouped.items():
        # k, one question
        total += 1
        answer = v[0][answer_key]
        pred_list = [str(vv[parsed_answer_key]) for vv in v]
        major_pred = Counter(pred_list).most_common(1)[0][0]

        if major_pred == str(answer):
            right_major += 1
        if str(answer) in pred_list:
            right_pass += 1

    acc_major = right_major / total * 100
    acc_pass = right_pass / total * 100
    print(f"Evaluate {file_path}")
    print(
        f"total samples:{total},major correct:{right_major},pass correct:{right_pass}"
    )
    print(f"major acc:{acc_major:.2f}")
    print(f"pass acc:{acc_pass:.2f}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Evaluate model predictions")
    parser.add_argument(
        "--file_path",
        type=str,
        default="eval_res/aime24_bz64.jsonl",
        help="Path to the JSONL file",
    )
    parser.add_argument(
        "--question_key", type=str, default="prompt", help="Key for grouping questions"
    )
    parser.add_argument(
        "--answer_key",
        type=str,
        default="answer",
        help="Key for the ground truth answer",
    )
    parser.add_argument(
        "--parsed_answer_key",
        type=str,
        default="extracted_answer",
        help="Key for the parsed/extracted answer",
    )

    args = parser.parse_args()
    main(args.file_path, args.question_key, args.answer_key, args.parsed_answer_key)
