json.array! @posts, partial: "posts/post", as: :post
<h5>最新の投稿</h5>
 <ul　class="col-lg-3 col-md-6 mb-4 ">
  <% @posts.each do |post| %>
    <p><%= link_to image_tag(post.photo.url), post, size: '300x600' %></p>
  <% end %>
</ul>