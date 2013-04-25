# encoding: utf-8

class ParseSetup

  def university(o={})
    x = create_and_save "University", o.validate_model({
      name: {required: true, validate_class: String}
    },{
      name: "università sconosciuta"
    })
    yield x.pointer if block_given?
    x
  end

  def campus(o={})
    x = create_and_save "Campus", o.validate_model({
      name:     {required: true, validate_class: String},
      university: {required: true, validate_class: Parse::Pointer}
    })
    yield x.pointer if block_given?
    x
  end

  def professor(o={})
    x = create_and_save "Professor", o.validate_model({
      first_name:     {required: false, validate_class: String},
      last_name:      {required: true, validate_class: String},
      university: {required: true, validate_class: Parse::Pointer}
    })
    yield x.pointer if block_given?
    x
  end

end