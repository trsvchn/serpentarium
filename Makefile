# Python related variables.
PYTHON_VERSION := 3.12.6
PYTHON_SRC_DIR := $(PWD)/.Python
PYTHON_TGT_DIR := $(PWD)/.venv
PYTHON_MAKE_FLAGS := -s -j
PYTHON_SRC_REPO := https://github.com/python/cpython.git
# Pip install options.
PIP_REQUIREMENTS_FILE := $(PWD)/requirements.txt
PIP_INSTALL_PACKAGE_INDEX_OPTIONS :=

VPATH := $(PYTHON_SRC_DIR):$(PYTHON_TGT_DIR)/bin


configure:
	mkdir -p $(PYTHON_SRC_DIR)
	cd $(PYTHON_SRC_DIR); \
	git clone $(PYTHON_SRC_REPO) --branch v$(PYTHON_VERSION) --depth 1 .

# Compile Python.
python: configure
	@echo "Creating target dir..."
	mkdir -p $(PYTHON_TGT_DIR)
	@echo "Creating target dir...Done!"

	@echo "Compiling Python..."
	cd $(PYTHON_SRC_DIR); \
	./configure --prefix=$(PYTHON_TGT_DIR); \
	make $(PYTHON_MAKE_FLAGS); \
	make install
	@echo "Compiling Python...Done!"

	# Create symlink for python.
	ln -sf $(PYTHON_TGT_DIR)/bin/python3 $(PYTHON_TGT_DIR)/bin/python

pip: python
	# Create symlink for pip.
	ln -sf $(PYTHON_TGT_DIR)/bin/pip3 $(PYTHON_TGT_DIR)/bin/pip

run: python
	$< $(argv)

.PHONY: ping
ping: python
	@echo "$$(date +'%T.%N') ping!"
	@$< -c "import datetime;print(datetime.datetime.now().strftime('%H:%M:%S.%f'),'pong!')"

.PHONY: pip_install
pip_install: pip
	$< install -r $(PIP_REQUIREMENTS_FILE) $(PIP_INSTALL_PACKAGE_INDEX_OPTIONS)

.PHONY: install
install: pip
	# Install setuptools first.
	$< install setuptools
	$< install -e .

.PHONY: clean_venv
clean_venv:
	rm -rf $(PYTHON_TGT_DIR)

.PHONY: clean
clean:
	rm -rf $(PYTHON_SRC_DIR) $(PYTHON_TGT_DIR)
