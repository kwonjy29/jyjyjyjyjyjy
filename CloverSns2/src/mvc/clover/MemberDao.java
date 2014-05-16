package mvc.clover;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

public class MemberDao {
	
	private Connection con = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	private DataSource ds = null;
	
	public MemberDao(){
		try{
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql");
		}
		catch(Exception err){
			System.out.println("DB 연결 실패");
		}
		
	}
	
	public void freeCon(){
		if(con != null) try{con.close();} catch(Exception err){}
		if(stmt != null) try{stmt.close();} catch(Exception err){}
		if(rs != null) try{rs.close();} catch(Exception err){}
	}
	
	public void MemberInsert(MemberDto dto){
		try{
			String sql = "INSERT INTO member(mem_id, mem_pw, mem_name, mem_birth, mem_email, mem_gender, mem_regDate) "
					+"VALUES(?,?,?,?,?,?,now())";
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, dto.getMem_id());
			stmt.setString(2, dto.getMem_pw());
			stmt.setString(3, dto.getMem_name());
			stmt.setString(4, dto.getMem_birth());
			stmt.setString(5, dto.getMem_email());
			stmt.setString(6, dto.getMem_gender());
			
			stmt.executeUpdate();
			
			}
		catch(Exception err){
			System.out.println("MemberInsert() : " + err);
		}
		finally{
			freeCon();
		}
		
	}

}
