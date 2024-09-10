# Python related variables.
PYTHON_VERSION := 3.12.6
PYTHON_SRC_DIR := $(PWD)/.Python
PYTHON_TGT_DIR := $(PWD)/.venv
REQUIREMENTS_FILE := $(PWD)/requirements.txt
PIP_EXTRA := 

VPATH := $(PYTHON_SRC_DIR):$(PYTHON_TGT_DIR)/bin


configure:
	mkdir -p $(PYTHON_SRC_DIR)
	cd $(PYTHON_SRC_DIR); \
	git clone https://github.com/python/cpython.git --branch v$(PYTHON_VERSION) --depth 1 .

# Compile Python.
python pip: configure
	@echo "Creating target dir..."
	mkdir -p $(PYTHON_TGT_DIR)
	@echo "Creating target dir...Done!"

	@echo "Compiling Python..."
	cd $(PYTHON_SRC_DIR); \
	./configure --prefix=$(PYTHON_TGT_DIR); \
	make -s -j; \
	make install
	@echo "Compiling Python...Done!"

	# Create symlinks for python and pip.
	ln -sf $(PYTHON_TGT_DIR)/bin/python3 $(PYTHON_TGT_DIR)/bin/python
	ln -sf $(PYTHON_TGT_DIR)/bin/pip3 $(PYTHON_TGT_DIR)/bin/pip

run: python
	$< $(argv)

.PHONY: ping
ping: python
	@echo "$$(date +'%T.%N') ping!"
	@$< -c "import datetime;print(datetime.datetime.now().strftime('%H:%M:%S.%f'),'pong!')"

.PHONY: pip_install
pip_install: pip
	$< install -r $(REQUIREMENTS_FILE) $(PIP_EXTRA)

.PHONY: install
install: pip
	$< install -e .

.PHONY: clean_venv
clean_venv:
	rm -rf $(PYTHON_TGT_DIR)

.PHONY: clean
clean:
	rm -rf $(PYTHON_SRC_DIR) $(PYTHON_TGT_DIR)
