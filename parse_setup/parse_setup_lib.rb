# encoding: utf-8

require 'parse-ruby-client'
require 'pp'

class Hash

  def with_defaults(defaults)
    self.merge(defaults) { |key, old, new| old.nil? ? new : old } 
  end

  def with_defaults!(defaults)
    self.merge!(defaults) { |key, old, new| old.nil? ? new : old }
  end

  def validate_model(model, defaults = {})
    # with_defaults! defaults
    model.each_pair do |key, params|
      params.with_defaults!({required: false, validate_class: Object})
      if params[:required] then
        raise(ArgumentError, "required column not present: #{key}") unless keys.include? key
      end
      raise(ArgumentError, "column #{key} not a subclass of #{params[:validate_class]}") unless self[key].class <= params[:validate_class]
    end
    self
  end

end

class ParseSetup

  def initialize
    @batch_count = 0
    @create_in_batches = false
  end

  def init_parse
    require 'JSON'
    config = JSON.parse(File.read("./config.json"))
    Parse.init :application_id => config["application_id"],
               :api_key        => config["api_key"]
    run_and_reset_batch
  end

  def batch_create
    @create_in_batches = true
    yield
    puts "saved #{@batch_count} objects" if @batch_count > 0
    run_and_reset_batch
    @create_in_batches = false
  end

  def clear_parse
    puts "start cleaning..."
    ["University", "Campus", "Professor"].each do |parse_class|
      puts "about to delete all of #{parse_class}"
      Parse::Query.new(parse_class).get.each_slice(20) {|slice|
        batch = Parse::Batch.new
        slice.map {|x| x.parse_delete}
        batch.run!
        puts "deleted #{slice.length} of #{parse_class}"
      }
    end
    puts "end cleaning!"
  end

  private

  def create_and_save(parse_class, obj = {})
    if @create_in_batches
      return create_and_save_batched(parse_class, obj)
    end
    o = Parse::Object.new(parse_class)
    o.merge! obj
    o = o.save
    yield o if block_given?
    o
  end

  def create_and_save_batched(parse_class, obj = {})
    o = Parse::Object.new(parse_class)
    o.merge! obj
    @batch.create_object o
    @batch_count += 1
    if @batch_count == 20 then
      run_and_reset_batch
      puts "saved 20 objects.."
    end
  end

  def run_and_reset_batch
    if @batch_count > 0
      @batch.run!
    end
    @batch = Parse::Batch.new
    @batch_count = 0
  end

  def get_by_id(parse_class, id)
    query = Parse::Query.new(parse_class)
    query.eq("objectId", id)
    o = query.get
    yield o if block_given?
    o
  end

end

