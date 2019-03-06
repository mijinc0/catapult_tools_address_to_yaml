require "rspec"
require_relative "../src/#{File.basename(__FILE__).gsub( /_spec/ , "" )}"

RSpec.describe "output to hash" do
  describe "#output_of_tools-address_to_struct" do
    before do
      @output = <<-EOS
        Address Tool
        Copyright (c) Jaguar0625, gimre, BloodyRookie, Tech Bureau, Corp.
        catapult version: 0.3.0.1 8467be1 [master]

        Address Tool Initializing Logging...

        --- generating 10 keys ---
                   private key: C013BE16F29BD6056C31B25793F02EA7DBE33CB72D49D924372D3FBFC80C780D
                    public key: C82AB07A07479EAB9321A7C5E58AF01CC3F9EE53B886D32DC5676DFEA5A15F94
          address (mijin-test): SDI7NF52462T37Q7Z2P2NAZAUGP66QIJSZREQST6

                   private key: 576808683B8509061AB9DEC9E5F03AE97A8A121E9181EE20B3D73444EC65B81F
                    public key: 99BB38B1E7D677F4C9E3EFFA0D00CA8BBAE128AF9ACC86CA774F6674824EA4EF
          address (mijin-test): SDCSZFUVUOYDVVCNBCC6D5FBQGYYI3IQZPSFIOFV
      EOS

      @expected = [
        { "private_key" => "C013BE16F29BD6056C31B25793F02EA7DBE33CB72D49D924372D3FBFC80C780D",
          "public_key"  => "C82AB07A07479EAB9321A7C5E58AF01CC3F9EE53B886D32DC5676DFEA5A15F94",
          "address"     => "SDI7NF52462T37Q7Z2P2NAZAUGP66QIJSZREQST6" },
        { "private_key" => "576808683B8509061AB9DEC9E5F03AE97A8A121E9181EE20B3D73444EC65B81F",
          "public_key"  => "99BB38B1E7D677F4C9E3EFFA0D00CA8BBAE128AF9ACC86CA774F6674824EA4EF",
          "address"     => "SDCSZFUVUOYDVVCNBCC6D5FBQGYYI3IQZPSFIOFV" } ]
    end
    it{ expect( output_of_toolsaddress_to_struct( @output ) ).to eq @expected }
  end
end
