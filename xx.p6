use v6;

grammar X {
  token location { \w+ }
  token word { \w+ }
  token ws { <!ww> \h* }
  token separator { <ws> }
  rule group { <word><separator><location> \n? }
  rule TOP  { \s*<group>+ }
}
class A {
  has $.file is rw;

  method location($wordd) {

    say "location $wordd";
    spurt $.file, ($wordd.IO.slurp) ~ "\n", :append;

  }
  method word($word) {
      say "word $word";

  }
  method TOP ($n) {
      say "top $n";
  }


};
my $string ='
asdasd f1\n
asdqwe f2
';
my $source=@*ARGS[0];
my $a = A.new(file => @*ARGS[1]);
try X.parse($source.IO.slurp, :actions($a));

if $! {
    say "Parse failed: ", $!.message;

}
elsif $/ {
    say $();

}
else {
    say "Parse failed.";
}
