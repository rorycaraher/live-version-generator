require 'nokogiri'

class LiveSetGenerator
    attr_accessor :seed, :parameter_map
    
    def initialize
        @seed = File.open("xml-01/seed.als") { |f| Nokogiri::XML(f) }
        @parameter_map = {
            send: {
                path: 'DeviceChain/Mixer/Sends/TrackSendHolder/Send/Manual',
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

    def randomise_sends(tracks)
        tracks.each do |node|
            node.at_xpath("DeviceChain/Mixer/Sends/TrackSendHolder/Send/Manual")["Value"] = rand(0.0003162277571..1.0).to_s
        end
    end

    def randomise_pans(tracks)
        tracks.each do |node|
            node.at_xpath("DeviceChain/Mixer/Pan/Manual")["Value"] = rand(-1.0..1.0).to_s
        end
    end

    def randomise_volumes(tracks)
        tracks.each do |node|
            node.at_xpath("DeviceChain/Mixer/Volume/Manual")["Value"] =  rand(0.2818383276..0.6760830283).to_s
        end
    end

    def export_version
        File.write("output/version_#{Time.now.strftime("%Y-%m-%d_%H:%M:%S")}.als", @seed.to_xml)
    end
end


