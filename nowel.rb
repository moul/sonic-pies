mychords = [
  chord(:C3, :major, num_octaves:5).ring,
  chord(:G3, :minor, num_octaves:4).ring,
  chord(:A3, :minor, num_octaves:4).ring,
  chord(:F3, :major, num_octaves:4).ring,
].ring

i = 0

play_drum = 0
play_bass = 0
play_chords = 0
play_arp = 0
play_arp2 = 0
play_buzz = 1


live_loop :main do
  sleep 4
end


live_loop :counters do
  sync :main
  4.times do
    i += 1
    sleep 2
  end
end


live_loop :bass do
  sync :main
  8.times do
    use_synth :fm
    stop if play_bass < 1
    sleep 0.25
    use_synth_defaults release: 0.2
    play mychords[i][0] - 12, amp: 2
    sleep 0.25
  end
end


live_loop :chords do
  sync :main
  stop if play_chords < 1
  use_synth_defaults cutoff: 70, amp: 4
  use_synth :fm
  5.times do
    play mychords[i]
    sleep 0.75
  end
  play mychords[i]
  sleep 0.25
end


live_loop :toutoupapap do
  sync :main
  stop if play_arp2 < 1
  use_synth_defaults cutoff: 100, amp: 3
  use_synth :piano
  2.times do
    with_fx :bitcrusher, mix: 0.2 do
      2.times do
        play mychords[i][0] + 12
        sleep 0.75/6
        play mychords[i][1] + 12
        sleep 0.75/6
        play mychords[i][2] + 12
        sleep 0.75/6
        play mychords[i][0] + 12 * 2
        sleep 0.75/6 * 3
      end
      play mychords[i][0] + 12
      sleep 0.75/6
      play mychords[i][1] + 12
      sleep 0.75/6
      play mychords[i][2] + 12
      sleep 0.75/6
      play mychords[i][0] + 12 * 2
      sleep 0.75/6
    end
  end
end

live_loop :arp3 do
  sync :main
  stop if play_arp < 1
  use_synth_defaults amp: 0.5
  use_synth :dsaw
  2.times do
    with_fx :panslicer, mix: 0.5 do
      with_fx :bitcrusher, mix: 0.1 do
        16.times do
          play mychords[i].choose + [12, -12].ring.tick, cutoff: line(40, 130, steps: 16 * 64).tick(:arp)
          sleep 0.125
        end
      end
    end
  end
end

live_loop :boomboom do
  sync :main
  stop if play_drum < 1
  8.times do
    sample :drum_heavy_kick, amp: 20
    sleep 0.5
  end
end

live_loop :bimbim do
  sync :main
  4.times do
    stop if play_drum < 1
    7.times do
      sleep 0.5
      sample :drum_snare_hard, amp: 5
      sleep 0.5
    end
    sleep 0.5
    2.times do
      sample :drum_snare_hard, amp: 7
      sleep 0.25
    end
  end
end

live_loop :tchiktchik do
  sync :main
  8.times do
    stop if play_drum < 1
    sleep 0.25
    sample :drum_cymbal_closed, amp: 2
    sleep 0.25
  end
end

live_loop :badaboom do
  sync :main
  stop if play_buzz < 1
  sample :bass_dnb_f, amp: 20
  sleep 16
end
