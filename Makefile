# From https://stackoverflow.com/questions/46848952/makefile-to-render-all-targets-of-all-rmd-files-in-directory?rq=1
SOURCES=$(shell find . -name "*.Rmd")
TARGET = $(SOURCES:%.Rmd=%.pdf) $(SOURCES:%.Rmd=%.html) $(SOURCES:%.Rmd=%.nb.html) $(SOURCES:%.Rmd=%.docx)


%.docx %.nb.html %.html %.pdf: %.Rmd
	Rscript -e "rmarkdown::render('$<', output_format = 'all')"

default: $(TARGET)

clean:
	rm -rf $(TARGET)
