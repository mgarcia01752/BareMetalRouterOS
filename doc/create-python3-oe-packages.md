# Adding required Python Packages for RouterShell

In order to enhance the functionality of RouterShell, certain Python packages need to be included. One such package is `jc`, which stands for JSON Convert. This package aids in the transformation of the output from various CLI tools, file-types, and common strings into JSON format, facilitating easier parsing in scripts.

## jc - JSON Convert

jc provides a convenient way to JSONify the output of numerous CLI tools, file-types, and common strings, thereby simplifying the parsing process in scripts. It supports a wide range of commands, file-types, and strings, making it a versatile tool for data manipulation.

### Useful Links

- [GitHub Repository](https://github.com/kellyjonbrazil/jc): Visit the official GitHub repository for jc to explore its source code, contribute to the project, or report issues.
- [PyPi Page](https://pypi.org/project/jc/): Check out the PyPi page for jc to view documentation, installation instructions, and package details.

### Installation Steps

To add the `jc` package to your Yocto Project meta-layer, follow these steps:

```bash
cd yocto-meta-layers/meta-bare-metal-router/recipes-core
mkdir python3-jc
cd python3-jc
pipoe --python python3 --package jc
```

## tabulate - python-tabulate (Not avalaible in dunfell)

Pretty-print tabular data in Python, a library and a command-line utility.

### Useful Links

- [GitHub Repository](https://github.com/astanin/python-tabulate): Visit the official GitHub repository for tabulate to explore its source code, contribute to the project, or report issues.
- [PyPi Page](https://pypi.org/project/tabulate/): Check out the PyPi page for tabulate to view documentation, installation instructions, and package details.

### Installation Steps

```bash
cd yocto-meta-layers/meta-bare-metal-router/recipes-core
mkdir python3-tabulate
cd python3-tabulate
pipoe --python python3 --package tabulate
```

## argcomplete - python3-Argcomplete (Not avalaible in dunfell)

Argcomplete provides easy, extensible command line tab completion of arguments for your Python application.

### Useful Links

- [GitHub Repository](https://github.com/kislyuk/argcomplete): Visit the official GitHub repository for Argcomplete to explore its source code, contribute to the project, or report issues.
- [PyPi Page](https://pypi.org/project/argcomplete/): Check out the PyPi page for Argcomplete to view documentation, installation instructions, and package details.

### Installation Steps

```bash
cd yocto-meta-layers/meta-bare-metal-router/recipes-core
mkdir python3-argcomplete
cd python3-argcomplete
pipoe --python python3 --package argcomplete
```
