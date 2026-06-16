library(stringr)

uppercase <- function(letter){
  if(letter %in% LETTERS){
    return(paste0("{", letter, "}"))
  }
  else{
    return(letter)
  }
}

biblio <- readLines("./references.bib")
for(i in 1:length(biblio)){
  line <- biblio[i]
  if(line != ""){
    spl_equal <- strsplit(line, split = " = ")[[1]]
    if(str_detect(string = spl_equal[1], pattern = "\ttitle")){
      ttl <- spl_equal[2]
      ttl_upr <- paste0(sapply(strsplit(ttl, split = "")[[1]],
                               FUN = uppercase), 
                        collapse = "")
      biblio[i] <- paste0(spl_equal[1], " = ", ttl_upr)
    }
  }
}

writeLines(biblio, "./references1.bib")
