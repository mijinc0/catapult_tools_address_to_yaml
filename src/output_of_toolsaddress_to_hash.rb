# [ expected data structure ]
#      private key : XXXXX
#       public key : XXXXX
# address(nettype) : XXXXX
def squeeze_value_from_line( line )
  return "" if line.nil? || line.empty?
  splitted = line.split(":")
  return splitted.size == 2 ? splitted[1].gsub(/[^0-9a-zA-Z]/, '') : ""
end

def output_of_toolsaddress_to_struct( output_str )
  address_set = []
  output_lines = output_str.lines
  output_lines.each_with_index do |line,index|
    next unless line.include?( "private key" )

    address_data = {}
    [ "private_key" , "public_key" , "address" ].each_with_index do |key,n|
      address_data[ key ] = squeeze_value_from_line( output_lines[ index + n ] )
    end

    address_set.push( address_data )
  end
  return address_set
end
