require 'test_helper'

class AjaxGistTest < ActiveSupport::TestCase
  
  def setup
    github_gist_stubs
  end
  
  test "AjaxGist.base_url should return base gist URL" do
    assert_equal "http://gist.github.com/", AjaxGist.base_url
  end
  
  test "AjaxGist.gist_embed_url_for_id should raise error if not supplied with an id" do
    assert_raises ArgumentError do
      AjaxGist.gist_embed_url_for_id
    end  
  end
  
  test "AjaxGist.gist_embed_url_for_id should return gist embed url" do
    assert_equal "http://gist.github.com/1010.js", AjaxGist.gist_embed_url_for_id(1010)
  end
  
  test "AjaxGist.gist_embed_code should raise error if not supplied with a URL" do
    assert_raises ArgumentError do
     AjaxGist.gist_embed_code
    end
  end
  
  test "AjaxGist.gist_embed_code should return Gist embed code" do
    gist = AjaxGist.gist_embed_code(1010)
    assert gist.include?("document.write"), "Gist embed code did not include 'document.write'"
  end
  
  test "AjaxGist.gist_embed_code for deleted Gist should return deleted." do
    gist = AjaxGist.gist_embed_code(2)
    assert gist.include?('deleted'), "Gist markup did not include deletion message"
  end
  
  test "AjaxGist.gist_markup_for should raise error if not supplied with id" do
    assert_raises ArgumentError do
      AjaxGist.gist_markup_for
    end
  end
  
  test "AjaxGist.gist_markup_for should return treated gist embed code" do
    gist = AjaxGist.gist_markup_for(1010)
    assert gist.include?('<div id=\"gist-'), "Gist markup did not include opening div"
    assert !gist.include?('document.write('), "Gist markup should not include document.write"
  end
  
  test "AjaxGist.gist_markup_for deleted Gist should return notice" do
    gist = AjaxGist.gist_markup_for(2)
    assert gist.include?('deleted'), "Gist markup did not include deletion message"
    assert gist.include?('<span'), "Gist markup did not include deletion message container"
    assert gist.include?('style=\"'), "Gist markup did not include deletion message styling"
  end
  
end
