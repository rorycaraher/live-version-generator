require_relative '../lib/live_set_generator.rb'

describe LiveSetGenerator do
  context "creating" do 
    context "when generator is initialized" do
      generator = LiveSetGenerator.new
      it "has map for Ableton parameters" do
        expect(generator.parameter_map).to be_kind_of(Hash)
      end

      it "has XML seed to work on" do
        expect(generator.seed).to be_kind_of(Nokogiri::XML::Document)
      end

      it "gets midi tracks from seed" do
        expect(generator.get_midi_tracks).to be_kind_of(Nokogiri::XML::NodeSet)
      end

      it "works on MIDI Tracks NodeSet when changing parameters" do
        expect(generator.randomise_volumes(generator.get_midi_tracks)).to be_kind_of(Nokogiri::XML::NodeSet)
        expect(generator.randomise_sends(generator.get_midi_tracks)).to be_kind_of(Nokogiri::XML::NodeSet)
        expect(generator.randomise_pans(generator.get_midi_tracks)).to be_kind_of(Nokogiri::XML::NodeSet)
      end

      it "can randomise arbitrary parameters" do
        expect(generator.randomise_parameter(generator.get_midi_tracks, :volume)).to be_kind_of(Nokogiri::XML::NodeSet)
        expect(generator.randomise_parameter(generator.get_midi_tracks, :pan)).to be_kind_of(Nokogiri::XML::NodeSet)
        expect(generator.randomise_parameter(generator.get_midi_tracks, :send)).to be_kind_of(Nokogiri::XML::NodeSet)
      end
      
      # it "exports a new version file" do

      # end
    end
  end
end
