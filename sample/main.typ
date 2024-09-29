#import "../src/lib.typ": template_minimal_styling

#show: template_minimal_styling
#set page(header: align(right)[Minimal Styling Template])

#let lipsum_fox = "the quick brown fox jumps over the lazy dog"

#outline(depth: 1)

= #link("")[Links]

- #link("")[#lipsum_fox]
- #link("")[#upper(lipsum_fox)]
- #link("")[链接示例]

= Code

This is the sample of ```typ #raw(block: false)``` #lorem(5) #raw(lorem(5)) `sample with space in the end   ` #lorem(5)

```ts
// sample of #raw(block: true)
const arr = [1, 2, 3]

for (let i = 0; i < arr.length; arr += 1) {
  arr[i]
}
```

= Footnotes

#lorem(10)#footnote([one])
#lorem(10)#footnote([two])#footnote([#link("")[link in footnote]])

= Title

== 二级标题 Heading Level 2

#lorem(20)

=== 三级标题 Heading Level 3

#lorem(20)

==== 四级标题 Heading Level 4

#lorem(20)

===== 五级标题 Heading Level 5

#lorem(20)

====== 六级标题 Heading Level 6

#lorem(20)


= Table

#table(
  columns: 3,
  [header 1], [header 2], [header 3],
  [cell 1], [cell 2], [cell 3],
  [cell 1], [cell 2], [cell 3],
)
