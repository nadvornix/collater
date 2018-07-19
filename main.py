import sys


def collate(fn):
    print(fn)


def main():
    for fn in sys.argv[1:]:
        collate(fn)


if __name__ == "__main__":
    main()
