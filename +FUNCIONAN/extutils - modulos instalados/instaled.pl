use ExtUtils::Installed;
   my ($inst) = ExtUtils::Installed->new();
   my (@modules) = $inst->modules();

#open(F,">C:\\Inst.txt");
print join("\n",@modules);
#close F;

