require_relative 'lib/live_set_generator'
generator = LiveSetGenerator.new

generator.randomise_parameter(generator.get_midi_tracks, :volume)
generator.randomise_parameter(generator.get_midi_tracks, :pan)
generator.randomise_parameter(generator.get_midi_tracks, :send)

generator.export_version
