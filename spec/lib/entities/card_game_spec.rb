describe Entities::CardGame do

  let(:player1_input) do
    <<~EOF
9
2
6
3
1
    EOF
  end

  let(:player2_input) do
    <<~EOF
5
8
4
7
10
    EOF
  end

  it { expect(described_class.new(player1_input, player2_input).call).to eq(306) }

  let(:player1_real_input) do
    <<~EOF
40
26
44
14
3
17
36
43
47
38
39
41
23
28
49
27
18
2
13
32
29
11
25
24
35
    EOF
  end

  let(:player2_real_input) do
    <<~EOF
19
15
48
37
6
34
8
50
22
46
20
21
10
1
33
30
4
5
7
31
12
9
45
42
16
    EOF
  end
  it { expect(described_class.new(player1_real_input, player2_real_input).call).to eq(32401) }
end
