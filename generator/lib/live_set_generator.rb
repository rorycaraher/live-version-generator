require 'nokogiri'

class LiveSetGenerator
    attr_accessor :seed, :parameter_map
    
    def initialize
        @seed = File.open("xml/seed.als") { |f| Nokogiri::XML(f) }
        @parameter_map = {
            send_a: {
                path: "DeviceChain/Mixer/Sends/TrackSendHolder[@Id='0']/Send/Manual",
                low: 0.0003162277571,
                high: 1.0
            },
            send_b: {
                path: "DeviceChain/Mixer/Sends/TrackSendHolder[@Id='1']/Send/Manual",
                low: 0.0003162277571,
                high: 1.0
            },
            volume: {
                path: 'DeviceChain/Mixer/Volume/Manual',
                low: 0.2818383276,
                high: 0.6760830283
            },
            pan: {
                path: 'DeviceChain/Mixer/Pan/Manual',
                low: -1.0,
                high: 1.0
            }
        }
    end

    def get_midi_tracks
        @seed.xpath("//Tracks/MidiTrack")
    end

    def randomise_parameter(tracks, parameter)
        tracks.each do |node|
            node.at_xpath(@parameter_map[parameter][:path])["Value"] = rand(@parameter_map[parameter][:low]..@parameter_map[parameter][:high]).to_s
        end
    end

    def export_version
        File.write("output/version_#{Time.now.strftime("%Y-%m-%d_%H:%M:%S")}.als", @seed.to_xml)
    end
end


