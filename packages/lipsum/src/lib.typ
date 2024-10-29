#let lipsum(
  len,
  lang,
  topic,
  format,
  offset,
) = {

}

#let _zh_CN(len) = {
  read("./sample.txt").slice(0, count: len * 3)
}
#let _en_fox = "the quick brown fox jumps over the lazy dog"
#let _en_fox_upper = upper(_en_fox)

#_zh_CN(100)

