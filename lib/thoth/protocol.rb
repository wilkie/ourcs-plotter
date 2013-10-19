class Protocol
  require 'net/http'
  require 'net/http/post/multipart'
  require 'json'

  # Make a connection
  def initialize(options = {})
    @host = options[:host] || throw("Host not given.")
    @port = options[:port] || 81

    @http = Net::HTTP.start(@host, @port)
  end

  # Ask for the given interface
  def info_for_interface(interface)
    meh = @http.get("/interfaces/#{interface}",
                    'Accept' => "application/json")
    if meh.code.to_i == 200
      begin
        JSON.parse(meh.body)
      rescue
        nil
      end
    else
      nil
    end
  end

  def interfaces
    meh = @http.get("/interfaces",
                    'Accept' => "application/json")
    if meh.code.to_i == 200
      begin
        JSON.parse(meh.body)
      rescue
        []
      end
    else
      []
    end
  end

  def interface(interface)
    meh = @http.get("/interfaces/#{interface}")
    meh.body
  end

  def implementations(interface)
    meh = @http.get("/implementations/#{interface}",
                    'Accept' => "application/json")
    if meh.code.to_i == 200
      begin
        JSON.parse(meh.body)
      rescue
        []
      end
    else
      []
    end
  end

  def implementation(interface, implementation)
    meh = @http.get("/implementations/#{interface}/#{implementation}")
    meh.body
  end

  def specifications(interface)
    meh = @http.get("/specifications/#{interface}",
                    'Accept' => "application/json")
    if meh.code.to_i == 200
      begin
        JSON.parse(meh.body)
      rescue
        []
      end
    else
      []
    end
  end

  def specification(interface, specification)
    meh = @http.get("/specifications/#{interface}/#{specification}")
    meh.body
  end

  def publish_interface(interface, file)
    req = Net::HTTP::Post::Multipart.new "/interfaces",
                                         "file" => UploadIO.new(file, "text/plain", "#{interface}.rb")
    @http.request(req)
  end

  def publish_implementation(interface, implementation, file)
    req = Net::HTTP::Post::Multipart.new "/implementations/#{interface}",
                                         "file" => UploadIO.new(file, "text/plain", "#{implementation}.rb")
    @http.request(req)
  end

  def push(fn, file)
    req = Net::HTTP::Post::Multipart.new "/#{File.dirname(fn)}",
                                         "file" => UploadIO.new(file, "text/plain", File.basename(fn))
    @http.request(req)
  end
end
