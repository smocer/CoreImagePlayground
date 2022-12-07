import json
import sys

with open("test.json", encoding="utf-8") as json_file:
    data = json.load(json_file)
with open("test.json", "w", encoding="utf-8") as json_file:
    data["testTo"] = data["testFrom"]
    json_file.write(json.dumps(data, ensure_ascii=False, sort_keys=False, indent=2, separators=(',', ': ')) + '\n')

sys.exit()
