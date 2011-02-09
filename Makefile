TEMPLATES := templates
RESULTS := targets

TARGETS :=	Rifle_2_50.ps \
		Rifle_1_100.ps \
		Rifle_2_100.ps \
		Rifle_1_200.ps

NAME_FROM_FNAME = $(word 1,$(subst _, ,$(basename $(notdir $1))))
MOA_FROM_FNAME = $(word 2,$(subst _, ,$(basename $(notdir $1))))
DIST_FROM_FNAME = $(word 3,$(subst _, ,$(basename $(notdir $1))))

# default all rule
all : $(addprefix $(RESULTS)/,$(TARGETS))

# rifle rule
$(RESULTS)/Rifle_%.ps : $(TEMPLATES)/rifle.ps
	sed \
		-e 's/%%%TITLE%%%/$(call NAME_FROM_FNAME,$@)/g' \
		-e 's/%%%DISTANCE%%%/$(call DIST_FROM_FNAME,$@)/g' \
		-e 's/%%%MOASPACING%%%/$(call MOA_FROM_FNAME,$@)/g' \
		$^ > $@

.PHONY : clean
clean :
	rm -f $(RESULTS)/*.ps
