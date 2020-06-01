package dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import entities.Category;
import entities.Post;
public class PostDao {
	Connection con;
	public PostDao(Connection con) {
		this.con = con;
	}
	public ArrayList<Category> getAllCategories() {
		ArrayList<Category> list = new ArrayList<>();
		
		try {
			String query = "select * from categories";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			while(rs.next()) {
				int cid = rs.getInt("cid");
				String catName = rs.getString("name");
				String catDesc = rs.getString("description");
				Category c = new Category(cid, catName, catDesc);
				list.add(c);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public boolean savePost(Post p) {
        boolean f = false;
        try {

            String q = "insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());
            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
	
	public List<Post> getAllPosts() {

        List<Post> list = new ArrayList<>();
        //fetch all the post
        try {

            PreparedStatement p = con.prepareStatement("select * from posts order by pid desc");

            ResultSet set = p.executeQuery();

            while (set.next()) {

                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int catId = set.getInt("catId");
                int userId = set.getInt("userId");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);

                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
	
	public List<Post> getPostByCatId(int catId) {
        List<Post> list = new ArrayList<>();
        //fetch all post by id
        //fetch all the post
        try {

            PreparedStatement p = con.prepareStatement("select * from posts where catId=?");
            p.setInt(1, catId);
            ResultSet set = p.executeQuery();

            while (set.next()) {

                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");

                int userId = set.getInt("userId");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);

                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
	
	public Post getPostByPostId(int postId) {
        Post post = null;
        //fetch specific post by pid
        try {

            PreparedStatement p = con.prepareStatement("select * from posts where pid=?");
            p.setInt(1, postId);
            ResultSet set = p.executeQuery();

            while (set.next()) {

//                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                int catId = set.getInt("catId");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");

                int userId = set.getInt("userId");
                post = new Post(postId, pTitle, pContent, pCode, pPic, date, catId, userId);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }
	
}