class Custom < RuiGen

    def open
        @fh = File.open( "tokens.rb", "w" )
    end

    def tokens( tokens )
        tokens.each do |i|
            @fh.puts "#{i.idstr} = #{i.id}"
        end
    end

    def token_ids( tokens )
        tokens.each do |k,v|
            @fh.puts "#{k} : #{v}"
        end
    end

    def close
        @fh.close
    end

end

Custom.new
