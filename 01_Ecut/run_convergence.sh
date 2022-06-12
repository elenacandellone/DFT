#!/bin/sh
Ecut="10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100"

for ec in $Ecut
do
er="8"
ecutr=$(($er*$ec))
cat > Pb.scf.in << EOF
&CONTROL
 calculation = 'scf',
 restart_mode='from_scratch',
 prefix = 'Pb',
 pseudo_dir = '/home/elenacandellone/qe-6.8/pseudo',
 outdir = './tmp',
 tprnfor = .true.,
 tstress = .true.,
 verbosity = 'high',
/
&SYSTEM
 ibrav = 2, 
 celldm(1) = 9.355659,
 nat=1, 
 ntyp=1,
 ecutwfc = $ec,
 ecutrho = $ecutr,
 occupations='smearing',
 smearing='mp',
 degauss=0.05
/
&ELECTRONS
 conv_thr = 1.0d-9
/
ATOMIC_SPECIES
 Pb 207.2 Pb.pbesol-dn-kjpaw_psl.1.0.0.UPF

ATOMIC_POSITIONS crystal
Pb 0.00000 0.00000 0.00000

K_POINTS automatic
 2 2 2 0 0 0
EOF

/home/elenacandellone/qe-6.8/bin/pw.x < ./Pb.scf.in > ./Output/Pb_${ec}.scf.out
rm -rf tmp
done

