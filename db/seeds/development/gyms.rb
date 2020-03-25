@gym = Gym.create!(
  name:         "GANVAジム中目黒",
  prefecture:   "東京",
  city:         "目黒区",
  address:      "中目黒０−０−０",
  introduction: "【未経験歓迎】中目黒にあるかもしれないアットホームなボルダリングジムです。",
  latitude:     35.6441631,
  longitude:    139.6988444,
)
@gym.create_level_name(
  level0: "VB",
  level1: "V0",
  level2: "V1",
  level3: "V2",
  level4: "V3",
  level5: "V4",
  level6: "V5",
  level7: "V6",
  level8: "V7",
  level9: "V8+",
)

names = %w{ G A N V A }

5.times do |n|
  @gym = Gym.create!(
    name:          names[n - 1] + 'ジム',
    prefecture:    "東京",
    city:          "目黒区",
    address:       "中目黒#{n}0-0-0",
    introduction:  "テスト用のジムです。",
    latitude:      35.6 + (n * 0.01),
    longitude:     139.6 + (n * 0.01),
  )
  @gym.create_level_name(
    level0: "V#{n}-B",
    level1: "V#{n}-1",
    level2: "V#{n}-2",
    level3: "V#{n}-3",
    level4: "V#{n}-4",
    level5: "V#{n}-5",
    level6: "V#{n}-6",
    level7: "V#{n}-7",
    level8: "V#{n}-8",
    level9: null,
  )
end