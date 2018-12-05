require 'cgi'

def parse_dungeonkey(str)
  Hash[str.each_line.map{| line |
    line.chomp.split(nil, 2)
  }]
end

# dkey1,dkey2, x, y : String(hex)
def make_label(dkey1, dkey2, x, y)
  make_link = lambda{| name, mapkey, aklass |
    "<a href='#{mapkey}.html?#{x}-#{y}' class='#{aklass}'>#{CGI.escapeHTML(name)}</a>"
  }

  if x == 'ff' and y == 'ff' then
    klass = 'without-coord'
  else
    klass = 'with-coord'
  end

  case dkey1
  when '0a'
    dkey2_i = dkey2.to_i(16)
    if dkey2_i >= 0x80 then
      mapkey = '%02x' % (dkey2_i - 0x7F)
      fixed = true
    else
      mapkey = dkey2
      fixed = false
    end
    name = (DungeonKey2[dkey2] || "##{dkey2}") + (fixed ? '*' : '')
    make_link[name, mapkey, klass]
  when '0b'
    name = DungeonKey1[dkey1]
    make_link[name, 'debug', klass]
  else
    DungeonKey1[dkey1]
  end
end

def main
  puts <<-EOT
<!DOCTYPE html>
<head>
  <title>transitions</title>
  <link rel="stylesheet" href="map.css">
  <script type="application/javascript" src="transitions.js"></script>
  <meta charset="utf-8">
</head><body>
  <ul>
  EOT
  transitions = Transitions.each_line.with_index.map{| line,i |
    line = line.chomp
    codes = line.split
    from,to = codes[0..3], codes[4..7]
    from_label = make_label(*from)
    to_label = make_label(*to)
    puts "<li>#{i} [#{from.join(' ')}] [#{to.join(' ')}] #{from_label} -> #{to_label}</li>"
  }
  puts <<-EOT
  </ul>
</body></html>
  EOT
end


DungeonKey1 = Hash[parse_dungeonkey(<<-EOT)]
00 ダンジョン0
01 こばみ谷
02 食神のほこら
03 掛軸裏の洞窟
04 フェイの最終問題
08 フェイの問題
09 単色ダンジョン
0a シャッフル
0b デバッグフロア
0c 二面地蔵の谷
EOT

DungeonKey2 = Hash[parse_dungeonkey(<<-EOT)]
01 渓谷の宿場
02 杉並の旧街道
03 杉並の旧街道
04 山間渓流
05 山間渓流
06 竹林の村
07 天馬峠
08 天馬峠
0a 山頂の町
0b 山頂の町
0c 奇岩谷
0d 山頂の森林
0e 瀑布湿原
0f 地下水脈の村
10 ムゲン幽谷
11 太陽の大地
12 黄金都市
13 虹の根もと
14 滝壺の洞窟
15 黄金都市
16 杉並の旧街道
17 杉並の旧街道
18 杉並の旧街道
19 杉並の旧街道
1a 山間渓流
1b 山間渓流
1c 山間渓流
1d 山間渓流
1e 山間渓流
1f 天馬峠
20 天馬峠
21 天馬峠
22 天馬峠
23 瀑布湿原
24 瀑布湿原
25 瀑布湿原
26 瀑布湿原
27 瀑布湿原
28 ムゲン幽谷
29 ムゲン幽谷
2a ムゲン幽谷
2b ムゲン幽谷
2e 山頂の町
2f 山頂の町
30
31 渓谷の宿場
32 山頂の町
33 天馬峠
34 天馬峠
35 天馬峠
36 天馬峠
37 天馬峠
38 天馬峠
39 天馬峠
3a 天馬峠
3b 天馬峠
3c 天馬峠
3d 天馬峠
3e 天馬峠
3f 天馬峠
40 天馬峠
41 瀑布湿原
42 瀑布湿原
43 瀑布湿原
44 瀑布湿原
45 山間渓流
46 山間渓流
47 山間渓流
48 山間渓流
49 山間渓流
4a 山間渓流
4b 山間渓流
4c 山間渓流
4d 山間渓流
4e 山間渓流
4f 山間渓流
50 山間渓流
51 山間渓流
52 杉並の旧街道
53 杉並の旧街道
54 杉並の旧街道
55 杉並の旧街道
56 杉並の旧街道
57 杉並の旧街道
58 杉並の旧街道
59 杉並の旧街道
5a 杉並の旧街道
5b 杉並の旧街道
5c 杉並の旧街道
5d 杉並の旧街道
5e 杉並の旧街道
5f 杉並の旧街道
60 山頂の森林
61 山頂の森林
62 山頂の森林
63 山頂の森林
64 山頂の森林
65 山頂の森林
66 山頂の森林
67 山頂の森林
68 山頂の森林
69 竹林の村
6a 渓谷の宿場
6b 山頂の町
6c 竹林の村
6d 竹林の村
6e 竹林の村
6f 地下水脈の村
70 地下水脈の村
71 奇岩谷
73 フェイの最終問題
80 渓谷の宿場
81 杉並の旧街道
82 杉並の旧街道
83 山間渓流
84 山間渓流
85 竹林の村
86 天馬峠
87 天馬峠
89 山頂の町
8a 山頂の町
8b 奇岩谷
8c 谷間の森林
8d 瀑布湿原
8e 地下水脈の村
8f ムゲン幽谷
90 太陽の大地
91 黄金都市
92 虹の根もと
93 滝壺の洞窟
94 黄金都市
95 杉並の旧街道
96 杉並の旧街道
97 杉並の旧街道
98 杉並の旧街道
99 山間渓流
9a 山間渓流
9b 山間渓流
9c 山間渓流
9d 山間渓流
9e 天馬峠
9f 天馬峠
a0 天馬峠
a1 天馬峠
a2 瀑布湿原
a3 瀑布湿原
a4 瀑布湿原
a5 瀑布湿原
a6 瀑布湿原
a7 ムゲン幽谷
a8 ムゲン幽谷
a9 ムゲン幽谷
aa ムゲン幽谷
ad 山頂の町
ae 山頂の町
af 滝壺の洞窟
b0 渓谷の宿場
b1 山頂の町
b2 天馬峠
b3 天馬峠
b4 天馬峠
b5 天馬峠
b6 天馬峠
b7 天馬峠
b8 天馬峠
b9 天馬峠
ba 天馬峠
bb 天馬峠
bc 天馬峠
bd 天馬峠
be 天馬峠
bf 天馬峠
c0 瀑布湿原
c1 瀑布湿原
c2 瀑布湿原
c3 瀑布湿原
c4 山間渓流
c5 山間渓流
c6 山間渓流
c7 山間渓流
c8 山間渓流
c9 山間渓流
ca 山間渓流
cb 山間渓流
cc 山間渓流
cd 山間渓流
ce 山間渓流
cf 山間渓流
d0 山間渓流
d1 杉並の旧街道
d2 杉並の旧街道
d3 杉並の旧街道
d4 杉並の旧街道
d5 杉並の旧街道
d6 杉並の旧街道
d7 杉並の旧街道
d8 杉並の旧街道
d9 杉並の旧街道
da 杉並の旧街道
db 杉並の旧街道
dc 杉並の旧街道
dd 杉並の旧街道
de 杉並の旧街道
df 谷間の森林
e0 谷間の森林
e1 谷間の森林
e2 谷間の森林
e3 谷間の森林
e4 谷間の森林
e5 谷間の森林
e6 谷間の森林
e7 谷間の森林
e8 竹林の村
e9 渓谷の宿場
ea 山頂の町
eb 竹林の村
ec 竹林の村
ed 竹林の村
ee 地下水脈の村
ef 地下水脈の村
f0 奇岩谷
f2 フェイの最終問題
EOT


Transitions = <<-EOT
0b 01 ff 20 0a 01 19 24
0a 01 19 11 0a 31 3a 12
0a 31 3a 13 0a 01 19 12
0a 01 13 11 0a 31 06 0a
0a 31 06 0b 0a 01 13 12
0a 01 0d 11 0a 6a 39 23
0a 6a 39 24 0a 01 0d 12
0a 01 1d 0f 0a 72 06 24
0a 72 06 25 0a 01 1d 10
0a 01 19 26 0b 01 2f 1d
0a 01 ff ff 0a 02 00 00
0a 31 ff ff 0a 02 00 00
0a 6a ff ff 0a 02 00 00
0a 72 ff ff 0a 02 00 00
0a 02 ff ff 0a 03 00 00
0a 03 ff ff 0a 04 00 00
0a 04 ff ff 0a 05 00 00
0a 05 ff ff 0a 06 04 13
0a 06 1c 10 0a 69 07 0d
0a 69 07 0e 0a 06 1c 11
0a 06 33 10 0a 6c 34 23
0a 6c 34 24 0a 06 33 11
0a 06 29 1e 0a 6d 25 08
0a 6d 25 09 0a 06 29 1f
0a 06 16 10 0a 6d 39 08
0a 6d 39 09 0a 06 16 11
0a 06 1b 19 0a 6d 06 24
0a 6d 06 25 0a 06 1b 1a
0a 06 0f 10 0a 6e 30 08
0a 6e 30 09 0a 06 0f 11
0a 06 13 06 02 01 00 00
0a 06 ff ff 0a 07 00 00
0a 69 ff ff 0a 07 00 00
0a 6c ff ff 0a 07 00 00
0a 6d ff ff 0a 07 00 00
0a 6e ff ff 0a 07 00 00
0a 07 ff ff 0a 08 00 00
0a 08 ff ff 0a 0d 00 00
0a 0d ff ff 0a 0a 06 16
0a 0a 1c 21 0a 0b 28 24
0a 0b 28 25 0a 0a 1c 22
0a 0b 26 20 03 01 00 00
0a 0a 18 1b 0a 2e 25 10
0a 2e 25 11 0a 0a 18 1c
0a 0a 1f 24 0a 2e 2c 07
0a 2e 2c 08 0a 0a 1f 25
0a 0a 08 21 0a 2e 2f 24
0a 2e 2f 25 0a 0a 08 22
0a 0a 08 14 0a 2f 38 24
0a 2f 38 25 0a 0a 08 15
0a 0a 17 14 0a 2f 25 07
0a 2f 25 08 0a 0a 17 15
0a 0a 0d 21 0a 32 06 0d
0a 32 06 0e 0a 0a 0d 22
0a 0a 0d 14 0a 6b 0e 0b
0a 6b 0e 0c 0a 0a 0d 15
0a 0a 38 05 0a 6b 19 0c
0a 6b 19 0d 0a 0a 38 06
0a 0a ff ff 01 01 00 00
0a 0b ff ff 01 01 00 00
0a 2e ff ff 01 01 00 00
0a 2f ff ff 01 01 00 00
0a 32 ff ff 01 01 00 00
0a 6b ff ff 01 01 00 00
01 02 ff ff 0c 01 0f 0d
0c 01 ff ff 01 03 00 00
01 07 ff ff 0a 0c 04 18
0a 0c 12 05 0a 71 08 0c
0a 71 08 0d 0a 0c 12 06
0a 0c 14 18 0a 71 07 24
0a 71 07 25 0a 0c 14 19
0a 0c 31 0a 0a 71 2d 20
0a 71 2d 21 0a 0c 31 0b
0a 0c 1e 0a 0a 71 38 1a
0a 71 38 1b 0a 0c 1e 0b
0a 71 39 16 0a 71 3a 25
0a 71 39 25 0a 71 38 16
0a 0c ff ff 0a 0e 00 00
0a 71 ff ff 0a 0e 00 00
0a 0e ff ff 0a 23 00 00
0a 23 ff ff 01 08 00 00
01 0c ff ff 0a 0f 04 25
01 0c ff ff 0a 6f 38 08
01 0c ff ff 0a 70 29 22
0a 0f 0a 10 0a 6f 38 08
0a 6f 38 09 0a 0f 0a 11
0a 0f 1e 0b 0a 6f 38 16
0a 6f 38 17 0a 0f 1e 0c
0a 0f 18 0b 0a 6f 06 08
0a 6f 06 09 0a 0f 18 0c
0a 0f 2a 14 0a 70 29 22
0a 70 29 23 0a 0f 2a 15
0a 0f 12 21 0a 70 34 23
0a 70 34 24 0a 0f 12 22
0a 0f 04 25 01 0d 00 00
0a 0f ff ff 01 0d 00 00
0a 6f ff ff 01 0d 00 00
0a 70 ff ff 01 0d 00 00
01 10 ff ff 0a 10 00 00
0a 10 ff ff 01 11 00 00
01 13 ff ff 0a 11 08 0e
0a 11 ff ff 0a 12 04 0b
0a 12 0b 04 0a 15 37 0d
0a 15 ff ff 0a 12 0b 05
0a 12 ff ff 0a 13 20 20
0a 13 ff ff 0a 14 19 24
0a 14 0f 04 0a 30 17 1b
0a 14 ff ff 0a 14 19 24
0a 30 ff ff 0a 14 19 24
0b 01 1b 1b 02 01 00 00
02 63 ff ff 02 63 00 00
0b 01 1b 1c 03 01 00 00
03 63 ff ff 03 63 00 00
0b 01 1b 1d 04 01 00 00
04 63 ff ff 0a 73 2c 14
0a 73 2f 11 0a 01 19 24
0a 73 ff ff 0a 73 2c 14
0b 01 36 13 0b 01 2f 1d
0b 01 37 0b 00 06 00 00
0b 01 37 0c 00 05 00 00
0b 01 37 0e 00 03 00 00
0b 01 37 0f 00 02 00 00
0b 01 37 10 00 01 00 00
0b 01 38 07 00 0b 00 00
0b 01 38 0c 00 10 00 00
0b 01 38 0e 00 12 00 00
0b 01 38 0f 00 13 00 00
0b 01 38 10 00 14 00 00
0b 01 39 07 00 1e 00 00
0b 01 39 08 00 1d 00 00
0b 01 39 09 00 1c 00 00
0b 01 39 0a 00 1b 00 00
0b 01 39 0b 00 1a 00 00
0b 01 39 0c 00 19 00 00
0b 01 39 0d 00 18 00 00
0b 01 39 0e 00 17 00 00
0b 01 3a 09 00 21 00 00
0b 01 3a 0e 00 26 00 00
00 06 ff ff 0b 01 37 0b
00 05 ff ff 0b 01 37 0c
00 03 ff ff 0b 01 37 0e
00 02 ff ff 0b 01 37 0f
00 01 ff ff 0b 01 37 10
00 0b ff ff 0b 01 38 07
00 10 ff ff 0b 01 38 0c
00 12 ff ff 0b 01 38 0e
00 13 ff ff 0b 01 38 0f
00 14 ff ff 0b 01 38 10
00 1e ff ff 0b 01 39 07
00 1d ff ff 0b 01 39 08
00 1c ff ff 0b 01 39 09
00 1b ff ff 0b 01 39 0a
00 1a ff ff 0b 01 39 0b
00 19 ff ff 0b 01 39 0c
00 18 ff ff 0b 01 39 0d
00 17 ff ff 0b 01 39 0e
00 21 ff ff 0b 01 3a 09
00 26 ff ff 0b 01 3a 0e
00 00 00 00 08 01 06 06
00 00 00 00 08 02 07 06
00 00 00 00 08 03 07 0a
00 00 00 00 08 04 06 07
00 00 00 00 08 05 08 06
00 00 00 00 08 06 08 08
00 00 00 00 08 07 07 0b
00 00 00 00 08 08 0a 07
00 00 00 00 08 09 0c 08
00 00 00 00 08 0a 06 07
00 00 00 00 08 0b 05 08
00 00 00 00 08 0c 09 09
00 00 00 00 08 0d 07 08
00 00 00 00 08 0e 12 07
00 00 00 00 08 0f 0a 06
00 00 00 00 08 10 07 17
00 00 00 00 08 11 07 06
00 00 00 00 08 12 13 07
00 00 00 00 08 13 09 0a
00 00 00 00 08 14 08 05
00 00 00 00 08 15 0a 06
00 00 00 00 08 16 08 05
00 00 00 00 08 17 1d 07
00 00 00 00 08 18 08 06
00 00 00 00 08 19 08 16
00 00 00 00 08 1a 15 07
00 00 00 00 08 1b 0e 0a
00 00 00 00 08 1c 07 09
00 00 00 00 08 1d 07 0a
00 00 00 00 08 1e 08 0f
00 00 00 00 08 1f 07 08
00 00 00 00 08 20 0c 1a
00 00 00 00 08 21 08 09
00 00 00 00 08 22 0a 0b
00 00 00 00 08 23 05 05
00 00 00 00 08 24 06 13
00 00 00 00 08 25 07 15
00 00 00 00 08 26 07 06
00 00 00 00 08 27 07 12
00 00 00 00 08 28 0b 0d
00 00 00 00 08 29 08 1d
00 00 00 00 08 2a 07 15
00 00 00 00 08 2b 10 12
00 00 00 00 08 2c 08 07
00 00 00 00 08 2d 12 10
00 00 00 00 08 2e 19 07
00 00 00 00 08 2f 05 05
00 00 00 00 08 30 08 0b
00 00 00 00 08 31 06 05
00 00 00 00 08 32 17 08
08 01 ff ff 0a 01 19 24
08 02 ff ff 0a 01 19 24
08 03 ff ff 0a 01 19 24
08 04 ff ff 0a 01 19 24
08 05 ff ff 0a 01 19 24
08 06 ff ff 0a 01 19 24
08 07 ff ff 0a 01 19 24
08 08 ff ff 0a 01 19 24
08 09 ff ff 0a 01 19 24
08 0a ff ff 0a 01 19 24
08 0b ff ff 0a 01 19 24
08 0c ff ff 0a 01 19 24
08 0d ff ff 0a 01 19 24
08 0e ff ff 0a 01 19 24
08 0f ff ff 0a 01 19 24
08 10 ff ff 0a 01 19 24
08 11 ff ff 0a 01 19 24
08 12 ff ff 0a 01 19 24
08 13 ff ff 0a 01 19 24
08 14 ff ff 0a 01 19 24
08 15 ff ff 0a 01 19 24
08 16 ff ff 0a 01 19 24
08 17 ff ff 0a 01 19 24
08 18 ff ff 0a 01 19 24
08 19 ff ff 0a 01 19 24
08 1a ff ff 0a 01 19 24
08 1b ff ff 0a 01 19 24
08 1c ff ff 0a 01 19 24
08 1d ff ff 0a 01 19 24
08 1e ff ff 0a 01 19 24
08 1f ff ff 0a 01 19 24
08 20 ff ff 0a 01 19 24
08 21 ff ff 0a 01 19 24
08 22 ff ff 0a 01 19 24
08 23 ff ff 0a 01 19 24
08 24 ff ff 0a 01 19 24
08 25 ff ff 0a 01 19 24
08 26 ff ff 0a 01 19 24
08 27 ff ff 0a 01 19 24
08 28 ff ff 0a 01 19 24
08 29 ff ff 0a 01 19 24
08 2a ff ff 0a 01 19 24
08 2b ff ff 0a 01 19 24
08 2c ff ff 0a 01 19 24
08 2d ff ff 0a 01 19 24
08 2e ff ff 0a 01 19 24
08 2f ff ff 0a 01 19 24
08 30 ff ff 0a 01 19 24
08 31 ff ff 0a 01 19 24
08 32 ff ff 0a 01 19 24
0b 01 1f 13 0a 80 19 24
0a 80 19 11 0a b0 3a 12
0a b0 3a 13 0a 80 19 12
0a 80 13 11 0a b0 06 0a
0a b0 06 0b 0a 80 13 12
0a b0 ff ff 0b 01 1f 13
0a 80 0d 11 0a e9 39 23
0a e9 39 24 0a 80 0d 12
0a e9 ff ff 0b 01 1f 13
0a 80 1d 0f 0a f1 06 24
0a f1 06 25 0a 80 1d 10
0a f1 07 20 0a 80 19 24
0a f1 ff ff 0b 01 1f 13
0a 80 ff ff 0b 01 1f 13
0b 01 20 13 0a 81 00 00
0a 81 ff ff 0b 01 20 13
0b 01 21 13 0a 82 00 00
0a 82 ff ff 0b 01 21 13
0b 01 22 13 0a 83 00 00
0a 83 ff ff 0b 01 22 13
0b 01 23 13 0a 84 00 00
0a 84 ff ff 0b 01 23 13
0b 01 24 13 0a 85 04 13
0a 85 1c 10 0a e8 07 0d
0a e8 07 0e 0a 85 1c 11
0a e8 ff ff 0b 01 24 13
0a 85 33 10 0a eb 34 23
0a eb 34 24 0a 85 33 11
0a eb ff ff 0b 01 24 13
0a 85 29 1e 0a ec 25 08
0a ec 25 09 0a 85 29 1f
0a 85 16 10 0a ec 39 08
0a ec 39 09 0a 85 16 11
0a 85 1b 19 0a ec 06 24
0a ec 06 25 0a 85 1b 1a
0a ec ff ff 0b 01 24 13
0a 85 0f 10 0a ed 30 08
0a ed 30 09 0a 85 0f 11
0a ed ff ff 0b 01 24 13
0a 85 13 06 0a 85 04 13
0a 85 ff ff 0b 01 24 13
0b 01 25 13 0a 86 00 00
0a 86 ff ff 0b 01 25 13
0b 01 26 13 0a 87 00 00
0a 87 ff ff 0b 01 26 13
0b 01 27 13 0a 8c 00 00
0a 8c ff ff 0b 01 27 13
0b 01 27 14 0a 89 06 16
0a 89 1c 21 0a 8a 28 24
0a 8a 28 25 0a 89 1c 22
0a 8a ff ff 0b 01 27 14
0a 89 18 1b 0a ad 25 10
0a ad 25 11 0a 89 18 1c
0a 89 1f 24 0a ad 2c 07
0a ad 2c 08 0a 89 1f 25
0a 89 08 21 0a ad 2f 24
0a ad 2f 25 0a 89 08 22
0a ad ff ff 0b 01 27 14
0a 89 08 14 0a ae 38 24
0a ae 38 25 0a 89 08 15
0a 89 17 14 0a ae 25 07
0a ae 25 08 0a 89 17 15
0a ae ff ff 0b 01 27 14
0a 89 0d 21 0a b1 06 0d
0a b1 06 0e 0a 89 0d 22
0a b1 ff ff 0b 01 27 14
0a 89 0d 14 0a ea 0e 0b
0a ea 0e 0c 0a 89 0d 15
0a 89 38 05 0a ea 19 0c
0a ea 19 0d 0a 89 38 06
0a ea ff ff 0b 01 27 14
0a 89 ff ff 0b 01 27 14
0b 01 25 14 0a 8b 04 18
0a 8b 12 05 0a f0 08 0c
0a f0 08 0d 0a 8b 12 06
0a 8b 14 18 0a f0 07 24
0a f0 07 25 0a 8b 14 19
0a 8b 31 0a 0a f0 2d 20
0a f0 2d 21 0a 8b 31 0b
0a 8b 1e 0a 0a f0 38 1a
0a f0 38 1b 0a 8b 1e 0b
0a f0 39 16 0a f0 3a 25
0a f0 39 25 0a f0 38 16
0a f0 ff ff 0b 01 25 14
0a 8b ff ff 0b 01 25 14
0b 01 24 14 0a 8d 00 00
0a 8d ff ff 0b 01 24 14
0b 01 23 14 0a a2 00 00
0a a2 ff ff 0b 01 23 14
0b 01 22 14 0a 8e 04 25
0a 8e 0a 10 0a ee 38 08
0a ee 38 09 0a 8e 0a 11
0a 8e 1e 0b 0a ee 38 16
0a ee 38 17 0a 8e 1e 0c
0a 8e 18 0b 0a ee 06 08
0a ee 06 09 0a 8e 18 0c
0a ee ff ff 0b 01 22 14
0a 8e 2a 14 0a ef 29 22
0a ef 29 23 0a 8e 2a 15
0a 8e 12 21 0a ef 34 23
0a ef 34 24 0a 8e 12 22
0a ef ff ff 0b 01 22 14
0a 8e ff ff 0b 01 22 14
0b 01 21 14 0a 8f 00 00
0a 8f ff ff 0b 01 21 14
0b 01 20 14 0a 90 08 0e
0a 90 ff ff 0b 01 20 14
0b 01 1f 14 0a 91 04 0b
0a 91 0b 04 0a 94 37 0d
0a 94 ff ff 0a 91 0b 05
0a 91 ff ff 0b 01 1f 14
0b 01 1f 18 0a 92 20 20
0a 92 ff ff 0b 01 1f 18
0b 01 20 18 0a 93 19 24
0a 93 ff ff 0b 01 20 18
0b 01 21 18 0a af 17 1b
0a af ff ff 0b 01 21 18
0b 01 29 08 0a 95 00 00
0a 95 ff ff 0a 96 00 00
0a 96 ff ff 0a 97 00 00
0a 97 ff ff 0a 98 00 00
0a 98 ff ff 0a d1 00 00
0a d1 ff ff 0a d2 00 00
0a d2 ff ff 0a d3 00 00
0a d3 ff ff 0a d4 00 00
0a d4 ff ff 0a d5 00 00
0a d5 ff ff 0a d6 00 00
0a d6 ff ff 0a d7 00 00
0a d7 ff ff 0a d8 00 00
0a d8 ff ff 0a d9 00 00
0a d9 ff ff 0a da 00 00
0a da ff ff 0a db 00 00
0a db ff ff 0a dc 00 00
0a dc ff ff 0a dd 00 00
0a dd ff ff 0a de 00 00
0a de ff ff 0b 01 29 09
0b 01 2a 08 0a 99 00 00
0a 99 ff ff 0a 9a 00 00
0a 9a ff ff 0a 9b 00 00
0a 9b ff ff 0a 9c 00 00
0a 9c ff ff 0a 9d 00 00
0a 9d ff ff 0a c4 00 00
0a c4 ff ff 0a c5 00 00
0a c5 ff ff 0a c6 00 00
0a c6 ff ff 0a c7 00 00
0a c7 ff ff 0a c8 00 00
0a c8 ff ff 0a c9 00 00
0a c9 ff ff 0a ca 00 00
0a ca ff ff 0a cb 00 00
0a cb ff ff 0a cc 00 00
0a cc ff ff 0a cd 00 00
0a cd ff ff 0a ce 00 00
0a ce ff ff 0a cf 00 00
0a cf ff ff 0a d0 00 00
0a d0 ff ff 0b 01 2a 09
0b 01 2b 08 0a 9e 00 00
0a 9e ff ff 0a 9f 00 00
0a 9f ff ff 0a a0 00 00
0a a0 ff ff 0a a1 00 00
0a a1 ff ff 0a b2 00 00
0a b2 ff ff 0a b3 00 00
0a b3 ff ff 0a b4 00 00
0a b4 ff ff 0a b5 00 00
0a b5 ff ff 0a b6 00 00
0a b6 ff ff 0a b7 00 00
0a b7 ff ff 0a b8 00 00
0a b8 ff ff 0a b9 00 00
0a b9 ff ff 0a ba 00 00
0a ba ff ff 0a bb 00 00
0a bb ff ff 0a bc 00 00
0a bc ff ff 0a bd 00 00
0a bd ff ff 0a be 00 00
0a be ff ff 0a bf 00 00
0a bf ff ff 0b 01 2b 09
0b 01 2c 08 0a a3 00 00
0a a3 ff ff 0a a4 00 00
0a a4 ff ff 0a a5 00 00
0a a5 ff ff 0a a6 00 00
0a a6 ff ff 0a c0 00 00
0a c0 ff ff 0a c1 00 00
0a c1 ff ff 0a c2 00 00
0a c2 ff ff 0a c3 00 00
0a c3 ff ff 0b 01 2c 09
0b 01 2d 08 0a a7 00 00
0a a7 ff ff 0a a8 00 00
0a a8 ff ff 0a a9 00 00
0a b3 ff ff 0a aa 00 00
0a aa ff ff 0b 01 2d 09
0b 01 2e 08 0a df 00 00
0a df ff ff 0a e0 00 00
0a e0 ff ff 0a e1 00 00
0a e1 ff ff 0a e2 00 00
0a e2 ff ff 0a e3 00 00
0a e3 ff ff 0a e4 00 00
0a e4 ff ff 0a e5 00 00
0a e5 ff ff 0a e6 00 00
0a e6 ff ff 0a e7 00 00
0a e7 ff ff 0b 01 2e 09
0b 01 29 1a 0a f2 2c 15
0a f2 ff ff 0b 01 29 1a
0b 01 ff ff 0b 01 2f 1d
EOT

main
