package cloverbean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;




import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CloverDao {
   private Connection con;
   private PreparedStatement stmt;
   private ResultSet rs;
   private DataSource ds;

   public CloverDao(){
      try{
         Context ctx = new InitialContext();
         ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mysqlDB");
      }
      catch(Exception err){
         System.out.println("DB연결 실패 : " + err);
      }
   }

   public void freeCon(){
      if(con != null) try{con.close();}catch(Exception err){}
      if(stmt != null) try{stmt.close();}catch(Exception err){}
      if(rs != null) try{rs.close();}catch(Exception err){}
   }


   // 글 리스트 가져오기(list.jsp)
   public Vector getBoardList(String keyField, String keyWord){
      Vector v = new Vector();
      String sql;
      try{
         con = ds.getConnection();
         if(keyWord == null || keyWord.isEmpty() || keyWord.equals("null")){
            sql = "select * from service order by pos";
         }
         else{
            sql = "select * from service where " + keyField + 
               " like '%" + keyWord + "%' order by pos";
         }


         stmt = con.prepareStatement(sql);
         rs = stmt.executeQuery();


         while(rs.next()){
            CloverDto dto = new CloverDto();
            dto.setBoardUpNo(rs.getInt("boardUpNo"));
            dto.setBoardContent(rs.getString("boardContent"));
            dto.setCount(rs.getInt("count"));
            dto.setDepth(rs.getInt("depth"));
            dto.setId(rs.getString("id"));
            dto.setPos(rs.getInt("pos"));
            dto.setPw(rs.getString("pw"));
            dto.setTitle(rs.getString("title"));
            dto.setUploadDate(rs.getString("uploadDate"));
            
            v.add(dto);
         }
      }
      catch(Exception err){
         System.out.println("getBoardList : " + err);
      }
      finally{
         freeCon();
      }

      return v;
   }

   // 글 저장하기
   public void updatePos(Connection con){
      try{
         String sql = "update service set pos=pos+1";
         stmt = con.prepareStatement(sql);
         stmt.executeUpdate();
      }
      catch(Exception err){
         System.out.println("updatePos : " + err);
      }
   }
   // 공지사항 insert
   public void insertNotice(CloverDto dto){
		String sql = "INSERT INTO service(title, boardContent, uploadDate, count, pos) VALUES(?, ?, now(), 0, 0)";
		try{
			con = ds.getConnection();
			updatePos(con);
			
			stmt = con.prepareStatement(sql);
			stmt.setString(1, dto.getTitle());
			stmt.setString(2, dto.getBoardContent());
			
			stmt.executeUpdate();
			
		}
		catch(Exception err){
			System.out.println("insertBoard : " + err);
		}
	}
   
   // 문의게시판 insert
   public void insertQuestion(CloverDto dto){
      String sql = "insert into service(title, id, boardContent, uploadDate, "
         + "count, pos, depth, pw) "
         + "values(?,?,?,now(),?,?,?,?)";


      try{
         con = ds.getConnection();
         updatePos(con);
         stmt = con.prepareStatement(sql);
         stmt.setString(1, dto.getTitle());
         stmt.setString(2, dto.getId());
         stmt.setString(3, dto.getBoardContent());
         stmt.setInt(4, dto.getCount());
         stmt.setInt(5, dto.getPos());
         stmt.setInt(6, dto.getDepth());
         stmt.setString(7, dto.getPw());

         stmt.executeUpdate();
      }
      catch(Exception err){
         System.out.println("insertBoard : " + err);
      }
      finally{
         freeCon();
      }
   }
   
   
   
   // 글 내용 보기(read.jsp, update.jsp)
   public CloverDto getBoard(int num){
      CloverDto dto = new CloverDto();
      String sql = "";
      try{
         con = ds.getConnection();         
         
         sql = "update service set count=count+1 where boardUpNo = ?";
         stmt = con.prepareStatement(sql);
         stmt.setInt(1, num);
         stmt.executeUpdate();
         
         sql = "select * from service where boardUpNo = ?";
         stmt = con.prepareStatement(sql);
         stmt.setInt(1, num);
         rs = stmt.executeQuery();
         
         if(rs.next()){
        	 dto.setBoardUpNo(rs.getInt("boardUpNo"));
             dto.setBoardContent(rs.getString("boardContent"));
             dto.setCount(rs.getInt("count"));
             dto.setDepth(rs.getInt("depth"));
             dto.setId(rs.getString("id"));
             dto.setPos(rs.getInt("pos"));
             dto.setPw(rs.getString("pw"));
             dto.setTitle(rs.getString("title"));
             dto.setUploadDate(rs.getString("uploadDate"));
         }
      }
      catch(Exception err){
         System.out.println("getBoard : " + err);
      }
      finally{
         freeCon();
      }
      return dto;
   }
   
   // 글 수정(UpdateProc.jsp)
   public void updateBoard(CloverDto dto){
      try{
         String sql = "update service set id=?, title=?, boardContent=? where boardUpNo=?";
         con = ds.getConnection();
         stmt = con.prepareStatement(sql);
         stmt.setString(1, dto.getId());
         stmt.setString(2, dto.getTitle());
         stmt.setString(3, dto.getBoardContent());
         stmt.setInt(4, dto.getBoardUpNo());
         stmt.executeUpdate();
      }
      catch(Exception err){
         System.out.println("updateBoard : " + err);
      }
      finally{
         freeCon();
      }
   }
   
   // 글 삭제
   public void deleteBoard(int num){
      try{
         String sql = "delete from service where boardUpNo=?";
         con = ds.getConnection();
         stmt = con.prepareStatement(sql);
         stmt.setInt(1, num);
         stmt.executeUpdate();
      }
      catch(Exception err){
         System.out.println("deleteBoard : " + err);
      }
      finally{
         freeCon();
      }
   }
   
   // 답변 달기
   // 부모글을 가져오는 메서드
   public void replyUpdatePos(CloverDto dto){
      try{
         String sql = "update service set pos=pos+1 where pos>?";
         con = ds.getConnection();
         stmt = con.prepareStatement(sql);
         stmt.setInt(1, dto.getPos());
         stmt.executeUpdate();
      }
      catch(Exception err){
         System.out.println("replyUpdatePos : " + err);
      }
      finally{
         freeCon();
      }
   }
   
// 실제 저장할 답변글
   public void replyBoard(CloverDto dto) {
      try {
         String sql = "insert into service(title, id, boardContent, uploadDate, "
               + "count, pos, depth, pw) " + "values(?,?,?,now(),?,?,?,?)";
         con = ds.getConnection();
         stmt = con.prepareStatement(sql);

         stmt.setString(1, dto.getTitle());
         stmt.setString(2, dto.getId());
         stmt.setString(3, dto.getBoardContent());
         stmt.setInt(4, dto.getCount());
         stmt.setInt(5, dto.getPos() + 1);
         stmt.setInt(6, dto.getDepth() + 1);
         stmt.setString(7, dto.getPw());
         stmt.executeUpdate();
      } catch (Exception err) {
         System.out.println("replyBoard : " + err);
      } finally {
         freeCon();
      }
   }
   
   // 들여 쓰기
   public String useDepth(int depth){
      String result = "";
      for(int i=0; i<depth*3; i++){
         result += "&nbsp;";
      }
      return result;
   }
}