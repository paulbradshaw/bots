#* @get /stockquote
newGetQuote <- function(thesymbol){
  myresults <- quantmod::getQuote(thesymbol)
  if(is.na(myresults[1,1])){
    mytext <- paste0("A price is not available for ", thesymbol)
  } else {
    mytext <- paste0("Price for ", thesymbol, " is $", myresults[1,2], " as of ", myresults[1,1])
  }
  return(mytext)
}

