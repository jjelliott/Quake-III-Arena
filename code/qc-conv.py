#!/usr/bin/env python3
import re
import sys

def parse_frames(qc_text):
    """Parse $frame lines and return a mapping from frame name -> enum name (uppercase, no underscores)"""
    frame_enum_map = {}
    frame_list = []
    for line in qc_text.splitlines():
        line = line.strip()
        if line.startswith("$frame"):
            parts = line.split()[1:]  # skip $frame keyword
            for frame_name in parts:
                enum_name = frame_name.upper().replace("_", "")
                frame_enum_map[frame_name] = enum_name
                frame_list.append(frame_name)
    return frame_enum_map, frame_list

def parse_functions(qc_text, frame_enum_map, namespace_from=None, namespace_to=None):
    """Parse QC functions using [$frameName, nextFunc] and output FRAME() macros with bodies commented."""
    frame_pattern = re.compile(
        r'void\(\)\s*(\w+)\s*=\s*\[\s*\$?(\w+)\s*,\s*(\w+)\s*\]\s*\{(.*?)\};',
        re.DOTALL
    )

    output = []
    for match in frame_pattern.finditer(qc_text):
        func_name, frame_name, next_func, body = match.groups()

        # Namespace replacement
        if namespace_from and namespace_to:
            if func_name.startswith(namespace_from):
                func_name = namespace_to + func_name[len(namespace_from):]
            if next_func.startswith(namespace_from):
                next_func = namespace_to + next_func[len(namespace_from):]

        if frame_name not in frame_enum_map:
            continue  # skip frames not declared

        enum_name = frame_enum_map[frame_name]
        # Wrap body in comment
        body_lines = body.strip().replace("\n", " ").replace("\r", " ")
        body_lines = re.sub(r'\s+', ' ', body_lines).strip()
        if body_lines:
            commented_body = f"/*{body_lines}*/"
        else:
            commented_body = ""
        output.append(f'FRAME({func_name}, {enum_name}, {next_func}, {{ {commented_body} }})')
    return output

def main():
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} input.qc [namespace_from namespace_to]")
        sys.exit(1)

    qc_file = sys.argv[1]
    namespace_from = sys.argv[2] if len(sys.argv) > 2 else None
    namespace_to = sys.argv[3] if len(sys.argv) > 3 else None

    with open(qc_file, "r") as f:
        qc_text = f.read()

    frame_enum_map, frame_list = parse_frames(qc_text)
    frame_output = parse_functions(qc_text, frame_enum_map, namespace_from, namespace_to)

    # Output enum first
    print("typedef enum {")
    for frame_name in frame_list:
        enum_name = frame_enum_map[frame_name]
        print(f"    {enum_name},")
    print("} frame_t;\n")

    # Output FRAME() calls
    for line in frame_output:
        print(line)

if __name__ == "__main__":
    main()

