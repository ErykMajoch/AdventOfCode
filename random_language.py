import random

def main() -> None:
    languages: list[str] = [
        "C", "C++", "C#", "Python", "Rust", "Java", "Ruby", "Javascript",
        "Haskell", "Go", "Julia", "Zig"
    ]

    print(f"Your random language for this challenge is {random.choice(languages)}!")

if __name__ == "__main__":
    main()

