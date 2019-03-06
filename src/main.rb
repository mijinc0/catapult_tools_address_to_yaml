require "yaml"
require_relative "./output_of_toolsaddress_to_hash"

def read_options( arg )
  options  = {}
  opt_keys = ["in","out"]
  arg.each do |opt|
    key_value = opt.gsub(" ","").split("=")
    # option exist?
    t = opt_keys.index( key_value.first )
    # not found
    raise "#{key_value.first} option not found. #{opt_keys}" if t.nil?
    # no value
    raise "value of #{key_value.first} not found. #{key_value.first}=<value>" if key_value[1].nil?
    # set
    options[ opt_keys[t] ] = key_value[1]
  end
  return options
end

def get_input_from_option( opt_in , io_in )
  # when "in" option not found, try to get input form pipe
  if opt_in.nil? then
    # data from pipe does exist?
    # no data => return :wait_readable
    max_read_len = 24589
    data_form_pipe = io_in.read_nonblock( max_read_len , exception:false )

    # not found
    raise "Input not found." if data_form_pipe == :wait_readable
    # too many input
    raise "Too many data in input.[ max : #{read_len}byte ]" unless io_in.read_nonblock( 1 , exception:false ).nil?

    return data_form_pipe
  else
    # load data from file
    file_path = File.expand_path( opt_in )
    # file not found
    raise "#{file_path} file not found." unless File.exist?( file_path )
    return File.read( file_path )
  end
end

def output_according_to_option( opt_out , s_data , io_out )
  if opt_out.nil? then
    # output data to io_out
    io_out.puts( s_data )
  else
    # output data to file
    output_file_path = File.extname( opt_out ).empty? ? opt_out + ".yml" : opt_out
    File.open( output_file_path , "w" ){ |f| f.puts( s_data ) }
  end
end

def main( argv = ARGV , io_out: $stdout , io_in: $stdin , io_err: $stderr )
  options = read_options( argv )

  input = get_input_from_option( options["in"] , io_in )

  yaml = output_of_toolsaddress_to_struct( input ).to_yaml

  output_according_to_option( options["out"] , yaml , io_out )

  exit 0
rescue => e
  io_err.puts( "Error : #{e.message}" )
  exit 1
end
