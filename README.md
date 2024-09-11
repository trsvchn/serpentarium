# [WIP] Serpentarium

_Yet Another Python Versions/Environments Management "Tool"._

---

## Concepts

The idea is to use GNU Make and tools provided by Python standard library, such as pip, venv, for
managing packages, orchestrating Python virtual environments, and installing (compiling) Python interpreters.

-- TODO

## Usage

> [!IMPORTANT]  
> The API and command list are provisional and subject to change.

Python project dir has the following structure: 

```sh
.
├── Makefile
├── pysrc             # User code.
│   ├── __init__.py
│   └── lib.py
├── requirements.txt  # Optional.
└── ...
    └── ...
```

After invoking `make python` two more directories are created `.Python` and `.venv`:

```sh
.
├── Makefile
├── pysrc             # User code.
│   ├── __init__.py
│   └── lib.py
├── requirements.txt  # Optional.
├── .Python           # Python source code.
│   └── ...
└── .venv             # Python "build" dir.
    ├── bin
    ├── include
    ├── lib
    └── share
```

Install `python` and `pip` to default location `.venv`.

```sh
make python
```

Helper command for "health checking".

```sh
make ping
```

Install packages from the `requirements.txt`.

```sh
make pip_install
```

Clean virtual env by removing `.venv` dir.

```sh
make clean_venv
```

Remove installed and previously cloned Python source.

```sh
make clean
```

## Contribution

The project is still in the WIP stage, so the [Discussions](https://github.com/trsvchn/serpentarium/discussions) are the right place to start.
 
- [Discussions](https://github.com/trsvchn/serpentarium/discussions) for feedback, questions, ideas.
- [Issues](https://github.com/trsvchn/serpentarium/issues) for bug reports.
- [Pull Requests](https://github.com/trsvchn/serpentarium/pulls) for bug fixes, enhancements etc.  
