# Configuration area

# Full path to Python. For Windows this is typically
# C:\Python27\python.exe; if it is in your path you don't need to change it.
PYTHON=python3

# Full path to main.py in the optimizer. Depends on where it was unpacked.
OPTIMIZER=/opt/pyoptimizer/main.py

# Which preprocessor to use. Use 'gcpp' for GNU cpp (typical on Linux/OSX);
# use 'mcpp' for mcpp.
PREPROC_KIND=gcpp

# Full path to the preprocessor. Depends on where you have downloaded it.
# If the preprocessor is GNU cpp and it is in your path, leave it as cpp.
PREPROC_PATH=cpp

# Full path to the zip program (zip.exe for Windows). Depends on where you
# have downloaded it. If it is in your path you don't need to change it.
ZIP=zip

# Name of the zipped file to generate for SL
SLZIP=AVsitterPlus.zip

# Name of the zipped file to generate for OpenSim
OSZIP=AVsitterPlus-oss.zip

# End of configuration area


# Version being compiled (LSL string)
VERSION="2.3beta"


# Note some of these scripts don't strictly need to be optimized for memory.

OPTIMIZED=AVP_sitA.lslo\
 AVP_sitB.lslo\
 AVP_adjuster.lslo\
 AVP_helperscript.lslo\
 AVP_root-security.lslo\
 AVP_root.lslo\
 AVP_select.lslo\
 Plugins/AVcamera/AVP_camera.lslo\
 Plugins/AVcontrol/Xcite!-Sensations/AVP_Xcite!.lslo\
 Plugins/AVcontrol/AVP_root-RLV-extra.lslo\
 Plugins/AVcontrol/AVP_root-RLV.lslo\
 Plugins/AVcontrol/AVP_root-control.lslo\
 Plugins/AVfaces/AVP_faces.lslo\
 Plugins/AVfavs/AVP_favs.lslo\
 Plugins/AVprop/AVP_menu.lslo\
 Plugins/AVprop/AVP_prop.lslo\
 Plugins/AVprop/AVP_object.lslo\
 Plugins/AVsequence/AVP_sequence.lslo\
 Utilities/AVpos-generator.lslo\
 Utilities/Anim-perm-checker.lslo\
 Utilities/MLP-converter.lslo\
 Utilities/PMAC-Converter.lslo\
 Utilities/Missing-anim-finder.lslo

UNOPTIMIZED=Plugins/AVcontrol/LockGuard/AVP_LockGuard.lsl\
 Plugins/AVcontrol/LockGuard/AVP_LockGuard-object.lsl\
 Utilities/AVpos-shifter.lsl\
 Utilities/Noob-detector.lsl

OPENSIM=AVP_sitA.oss\
 AVP_sitB.oss\
 AVP_adjuster.oss\
 AVP_helperscript.oss\
 AVP_root.oss\
 AVP_root-security.oss\
 AVP_select.oss\
 Plugins/AVcamera/AVP_camera.oss\
 Plugins/AVfaces/AVP_faces.oss\
 Plugins/AVprop/AVP_menu.oss\
 Plugins/AVprop/AVP_object.oss\
 Plugins/AVprop/AVP_prop.oss\
 Plugins/AVsequence/AVP_sequence.oss\
 Utilities/Anim-perm-checker.oss\
 Utilities/AVpos-generator.oss\
 Utilities/AVpos-shifter.oss\
 Utilities/Missing-anim-finder.oss\
 Utilities/MLP-converter.oss\
 Utilities/PMAC-Converter.oss\
 Utilities/Noob-detector.oss

all: $(SLZIP) $(OSZIP)

clean:
	$(PYTHON) build-aux.py rm $(SLZIP) $(OSZIP) $(OPTIMIZED) $(OPENSIM)

optimized: $(OPTIMIZED)

opensim: $(OPENSIM)

$(SLZIP): $(OPTIMIZED) $(UNOPTIMIZED)
	$(PYTHON) build-aux.py rm $@
	$(ZIP) $@ $(OPTIMIZED) $(UNOPTIMIZED)

%.lslo %.lslt: %.lsl
	$(PYTHON) $(OPTIMIZER) -H -O addstrings,shrinknames,-extendedglobalexpr -p $(PREPROC_KIND) --precmd=$(PREPROC_PATH) $(OFLAGS) $< -o $@

$(OSZIP): $(OPENSIM)
	$(PYTHON) build-aux.py rm $@
	$(ZIP) $@ $(OPENSIM)

%.oss: %.lsl
	$(PYTHON) build-aux.py oss-process $< > $@

# Bash only, probably GNU make only
setvars:
	for name in $(addprefix ',$(addsuffix ',$(OPTIMIZED:.lslo=.lsl))) $(addprefix ',$(addsuffix ',$(UNOPTIMIZED))); do $(PYTHON) build-aux.py setvars "$$name" version='$(VERSION)' ; done

release: setvars all

.PHONY : all clean optimized opensim setvars release
