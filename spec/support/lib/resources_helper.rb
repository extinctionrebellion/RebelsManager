module ResourcesHelper

  def resources_path(*parts)
    Pathname.new(__dir__).join('..', '..', 'support', 'resources', *parts).expand_path
  end

  def resource_content(*parts)
    File.read(resources_path(*parts))
  end

  def resources_file(*parts)
    File.new resources_path(*parts)
  end

end
