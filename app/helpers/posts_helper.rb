module PostsHelper

    def render_post_description(post)
      simple_format(post.description)
    end
end
