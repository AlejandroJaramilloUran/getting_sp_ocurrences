library(rgbif)
library(dplyr)
taxon_key <- name_backbone_checklist(sp_list)

#the object taxon_key has several columns including scientific name and the code
# gbif uses to identify the species (usageKey)
usage_key <- taxon_key$usageKey

###rgbif package has a useful function called occ_download that let you 
### obtain sp occurrences and filter those. 
### you can filter to occurrences with coordinates, without geo spatial issues,
### the source of the occurrence (I choose only those in herbariums) and the countries
### of your interest.
occ_download(
  type="and",
  pred_in("taxonKey", usage_key),
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_in("basisOfRecord","PRESERVED SPECIMEN"),
  pred_in("country", c("PE", "CO", "EC", "BO")),
  format = "SIMPLE_CSV"
)

#finally you obtain a code you can use to retrieve the data in a csv format
