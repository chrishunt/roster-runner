module ApplicationHelper
  def download_dialog
    haml_tag :p do
      haml_concat "Customize the prefix for this team's generated roster snippets."
    end
    haml_tag :form do
      haml_tag :input, 
        :type => "text", 
        :name => "download_dialog_prefix", 
        :id => "download_dialog_prefix",
        :value => ""
      haml_tag :input, 
        :type => "hidden", 
        :name => "download_dialog_team_id",
        :id => "download_dialog_team_id",
        :value => ""
      haml_tag :input, 
        :type => "hidden", 
        :name => "download_dialog_form",
        :id => "download_dialog_form",
        :value => ""
    end
  end

  def header
    menu_items = {}
    # Add leagues to menu
    @leagues.each do |league|
      menu_items["#{league.short_name}"] = league_path(league)
    end
    # Add additional menu items
    menu_items["custom"] = custom_team_path
    menu_items["about"] = about_path
    # Display menu items and highlight current
    menu_items.each do |name, url|
      controller_name = controller.controller_name.to_s.downcase
      name = name.to_s.downcase
      if @league.nil?
        case name
        when "custom"
          controller_name == "teams" ? header_active_item(name,url) : header_item(name,url)
        when "about"
          controller_name == "about" ? header_active_item(name,url) : header_item(name,url)
        else
          header_item(name,url)
        end
      else
        if @league.short_name.downcase == name
          header_active_item(name,url)
        else
          header_item(name,url)
        end
      end
    end
  end

  private 

  # used for menu item
  def header_item(name, url)
    haml_tag :div do
      haml_tag :a, :href => url do
        haml_concat name
      end
    end
  end

  # used for menu item
  def header_active_item(name, url)
    haml_tag :div, :class => 'selected' do
      haml_tag :a, :href => url do
        haml_concat name
      end
    end
  end
end
