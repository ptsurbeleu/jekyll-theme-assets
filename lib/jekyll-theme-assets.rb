require 'jekyll-assets'
require 'theme'

# Jekyll Assets hook to discover and register assets of a gem-based Jekyll theme.
Jekyll::Assets::Hook.register :env, :init do
  # Nothing to do if there is no theme
  return unless jekyll.theme
  # fetch from theme's "assets" folder
  fetch_theme_assets(jekyll.theme.public_assets_path)
  # fetch from theme's "_assets" folder
  fetch_theme_assets(jekyll.theme.private_assets_path)
end

private

# Simple helper to fetch assets from theme
def fetch_theme_assets(base_path)
  # Base path is resolved to nil unless it does exists
  return unless base_path
  # Similar snippets could be found in Jekyll's code base (namely reader.rb)
  dot_sources = Dir.chdir(base_path) { filter_entries(Dir.entries("."), base_path) }
  dot_sources.each do |source|
    # TODO: Replace with the link to the original thread on Github on the subject...
    jekyll.sprockets.append_path(File.join(base_path, source))
  end
end

# TODO: This snippet is taken as is from Jekyll with a little tweak
# to accomodate slight difference in naming convention between Jekyll
# and Jekyll Assets gem. It would be great to find out a way to reuse
# this snippet from Jekyll without the need to copy it.

# Filter out any files/directories that are hidden or backup files (start
# with "." or "#" or end with "~"), or contain site content (start with "_"),
# or are excluded in the site configuration, unless they are web server
# files such as '.htaccess'.
#
# entries - The Array of String file/directory entries to filter.
# base_directory - The string representing the optional base directory.
#
# Returns the Array of filtered entries.
def filter_entries(entries, base_directory = nil)
  Jekyll::EntryFilter.new(jekyll, base_directory).filter(entries)
end