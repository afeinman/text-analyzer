#!/usr/bin/perl -w
#
# Usage: wordfollow.pl filename.txt
#
$text = join ' ',<>;
$text =~ s/[^'A-Za-z0-9 ]//g;
$text =~ tr/A-Z/a-z/;

@words = split ' ',$text;

while (@words > 1) {
  $freq{$words[0]}++;
  $seq{$words[0]}->{$words[1]}++;
#print "$words[0] > $words[1] = $seq{$words[0]}->{$words[1]}\n";

  shift @words;
}
$freq{$words[0]}++;

push @output, "Sequence | Freq1 Freq2 | Fraction | Phrase\n";
foreach $w1 (keys %seq) {
  foreach $w2 (keys %{$seq{$w1}}) {
    $s = $seq{$w1}{$w2};
    if ($s > 1) {
      $s *= $s;
      $s /= $freq{$w1};
      $s /= $freq{$w2};
      push @output, sprintf(
        "%8d | %5d %5d | %3.4f%% | %s %s\n",
        $seq{$w1}{$w2},
        $freq{$w1}, $freq{$w2},
        $s*100,
        $w1,$w2);
    }
  }
}

print sort {
  ($a1) = split ' ',$a;
  ($b1) = split ' ',$b;
  return $a1 <=> $b1;
} @output;	


