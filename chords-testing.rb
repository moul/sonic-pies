# Change this:
notes = scale(:C4,:scriabin)

###

use_synth :piano

notes.each do |n|
  play n
  sleep 0.2
end

sleep 1

42.times do
  play notes.sample
  sleep 0.2
end

sleep 1

notes.each do |n|
  play n
end
