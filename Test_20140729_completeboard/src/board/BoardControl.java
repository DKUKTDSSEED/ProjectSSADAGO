package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Timestamp;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardControl
{
	private String logined_id;
	private Connection conn = null;
	private List<Board> boards;
	String writer, subjects, content, sql;
	long num, readcount;
	Timestamp reg_date;
	ResultSet result;
	ResultSetMetaData metaData;
	PreparedStatement prepared;
	public static final int SUBJECT = 1;
	public static final int WRITER = 2;
	public BoardControl()
	{
		conn = null;
		boards = new Vector<Board>();
		try
		{
			init();
		}
		catch(Exception e)
		{
			conn = null;
		}		
		
	}
	public int insert(Board board) throws Exception
	{		
		writer = board.getWriter();
		subjects = board.getSubjects();
		content = board.getContent();
		num = board.getNum();
		readcount = board.getReadcount();
		reg_date = board.getReg_date();
		sql = "insert into board(writer, subjects, content) values(?, ?, ?)";
		System.out.println("등록 준비");
		prepared = conn.prepareStatement(sql);
		prepared.setString(1, writer);
		prepared.setString(2, subjects);
		prepared.setString(3, content);
		
		int result = prepared.executeUpdate();
		System.out.println("등록 : "+ subjects + ", 결과 : " + result);
		return result;
	}
	public int insert(Reply reply) throws Exception
	{
		String contents2, writer2;
		contents2 = reply.getContent();
		writer2 = reply.getWriter();
		long num = reply.getBoard_num();
		
		sql = "insert into reply(writer, content, board_num) values(?, ?, ?)";
		System.out.println("등록 준비");
		prepared = conn.prepareStatement(sql);
		prepared.setString(1, writer2);
		prepared.setString(2, contents2);
		prepared.setLong(3, num);
		
		int result = prepared.executeUpdate();
		System.out.println("등록 : "+ contents2 + ", 결과 : " + result);
		return result;
	}
	public int insert(Reply reply, long board_num) throws Exception
	{
		long num = board_num;
		String contents2, writer2;
		contents2 = reply.getContent();
		writer2 = reply.getWriter();
		
		sql = "insert into reply(writer, content, board_num) values(?, ?, ?)";
		System.out.println("등록 준비");
		prepared = conn.prepareStatement(sql);
		prepared.setString(1, writer2);
		prepared.setString(2, contents2);
		prepared.setLong(3, num);
		
		int result = prepared.executeUpdate();
		System.out.println("등록 : "+ contents2 + ", 결과 : " + result);
		return result;
	}
	public int insert(Reply reply, Board board) throws Exception
	{
		return insert(reply, board.getNum());
	}
	public int delete(Board board) throws Exception
	{		
		int results = 0;
		writer = board.getWriter();
		subjects = board.getSubjects();
		content = board.getContent();
		num = board.getNum();
		readcount = board.getReadcount();
		reg_date = board.getReg_date();
		sql = "delete from board where num = ?";
		
		prepared = conn.prepareStatement(sql);
		prepared.setLong(1, num);
		
		results = prepared.executeUpdate();
		
		prepared.close();
		
		sql = "delete from reply where board_num = ?";
		
		prepared = conn.prepareStatement(sql);
		prepared.setLong(1, num);
		
		
		try
		{
			prepared.executeUpdate();
			prepared.close();
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		return results;
	}
	public int deleteReply(long num) throws Exception
	{		
		int results = 0;
		sql = "delete from reply where num = ?";
		
		prepared = conn.prepareStatement(sql);
		prepared.setLong(1, num);
		
		results = prepared.executeUpdate();
		prepared.close();
		return results;
	}
	
	public int delete(Reply reply) throws Exception
	{
		return deleteReply(reply.getNum());
	}
	public int getBoardCount()
	{
		return boards.size();
	}
	public List<Board> getBoardList()
	{
		return boards;
	}
	public Board getOneWithRefreshed(long num) throws Exception
	{
		Board newBoard = null;
		sql = "select * from board where num=?";
		
		try
		{
			prepared = conn.prepareStatement(sql);
			prepared.setLong(1, num);
			result = prepared.executeQuery();
			
			while(result.next())
			{
				newBoard = new Board();
				newBoard.setNum(result.getLong("num"));
				newBoard.setWriter(result.getString("writer"));
				newBoard.setSubjects(result.getString("subjects"));
				newBoard.setContent(result.getString("content"));
				newBoard.setReadcount(result.getLong("readcount"));
				newBoard.setReg_date(result.getTimestamp("reg_date"));
				return newBoard;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return newBoard;
	}
	public Board getOne(long num) throws NullPointerException
	{
		for(Board b : boards)
		{
			if(b.getNum() == num)
			{
				return b;
			}
		}
		return null;
	}
	public Board getOne(String str, int type) throws NullPointerException
	{
		switch(type)
		{
		case WRITER:
			for(Board b : boards)
			{
				if(b.getWriter().equals(str))
				{
					return b;
				}
			}
			break;
		case SUBJECT:
			for(Board b : boards)
			{
				if(b.getSubjects().equals(str))
				{
					return b;
				}
			}
			break;
		}
		
		return null;
	}
	public List<Board> getBoards() {
		return boards;
	}
	public void setBoards(List<Board> boards) {
		this.boards = boards;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getSubjects() {
		return subjects;
	}
	public void setSubjects(String subjects) {
		this.subjects = subjects;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public long getNum() {
		return num;
	}
	public void setNum(long num) {
		this.num = num;
	}
	public long getReadcount() {
		return readcount;
	}
	public void setReadcount(long readcount) {
		this.readcount = readcount;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public List<Board> selectAll() throws Exception
	{
		boards.clear();
		
		Board newBoard;
		sql = "select * from board";
		
		prepared = conn.prepareStatement(sql);
		result = prepared.executeQuery();
		
		while(result.next())
		{
			try 
			{
				newBoard = new Board();
				newBoard.setNum(result.getLong("num"));
				newBoard.setWriter(result.getString("writer"));
				newBoard.setSubjects(result.getString("subjects"));
				newBoard.setContent(result.getString("content"));
				newBoard.setReadcount(result.getLong("readcount"));
				newBoard.setReg_date(result.getTimestamp("reg_date"));
				boards.add(newBoard);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}			
		}
		return boards;
	}
	public List<Reply> selectAllReply() throws Exception
	{
		List<Reply> replyList = new Vector<Reply>();
		
		Reply newReply;
		sql = "select * from reply";
		
		prepared = conn.prepareStatement(sql);
		result = prepared.executeQuery();
		
		while(result.next())
		{
			try 
			{
				newReply = new Reply();
				newReply.setNum(result.getLong("num"));
				newReply.setWriter(result.getString("writer"));
				newReply.setContent(result.getString("content"));
				newReply.setReg_date(result.getTimestamp("reg_date"));
				newReply.setBoard_num(result.getLong("board_num"));
				replyList.add(newReply);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}			
		}
		return replyList;
	}
	public List<Reply> getReplyWithRefresh(long board_num) throws Exception
	{
		List<Reply> replyList = new Vector<Reply>();
		Reply newReply = null;
		sql = "select * from reply where board_num=?";
		
		prepared = conn.prepareStatement(sql);
		prepared.setLong(1, board_num);
		result = prepared.executeQuery();
		
		
		
		System.out.println("댓글을 받아옵니다.");
		
		
		while(result.next())
		{
			try 
			{
				newReply = new Reply();
				//System.out.println("번호를 받아옵니다.");
				newReply.setNum(result.getLong("num"));
				//System.out.println("글쓴이를 받아옵니다.");
				newReply.setWriter(result.getString("writer"));
				//System.out.println("내용을 받아옵니다.");
				newReply.setContent(result.getString("content"));
				//System.out.println("날짜를 받아옵니다.");
				newReply.setReg_date(result.getTimestamp("reg_date"));
				//System.out.println("글번호를 받아옵니다.");				
				newReply.setBoard_num(result.getLong("board_num"));
				replyList.add(newReply);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}			
		}
		
		try
		{
			prepared.close();
		}
		catch(Exception e)
		{
			
		}
		
		return replyList;
	}
	public List<Reply> getReplyWithRefresh(Board board) throws Exception
	{
		return getReplyWithRefresh(board.getNum());
	}
	public int update(Board board) throws Exception
	{		
		writer = board.getWriter();
		subjects = board.getSubjects();
		content = board.getContent();
		num = board.getNum();
		readcount = board.getReadcount();
		reg_date = board.getReg_date();
		sql = "update board set subjects = ?, readcount = ?, content = ? where num = ?";
		
		prepared = conn.prepareStatement(sql);
		prepared.setString(1, subjects);
		prepared.setLong(2, readcount);
		prepared.setString(3, content);		
		prepared.setLong(4, num);
		
		int results = prepared.executeUpdate();		
		
		try
		{
			prepared.close();
		}
		catch(Exception e)
		{
			
		}
		return results;
	}
	public int increaseCount(Board board) throws Exception
	{
		writer = board.getWriter();
		subjects = board.getSubjects();
		content = board.getContent();
		num = board.getNum();
		readcount = board.getReadcount() + 1;
		reg_date = board.getReg_date();
		sql = "update board set readcount = ? where num = ?";
		
		prepared = conn.prepareStatement(sql);
		prepared.setLong(1, readcount);
		prepared.setLong(2, num);
		
		int results = prepared.executeUpdate();
		
		try
		{
			prepared.close();
		}
		catch(Exception e)
		{
			
		}
		
		return results;
	}
	public BoardControl(String logined_id)
	{
		this.logined_id = logined_id;
	}
	public void init() throws Exception
	{
		Context initCtx = new InitialContext();	
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/test");
		conn = ds.getConnection();
	}
	public void close()
	{
		try
		{
			conn.close();
		}
		catch(Exception e)
		{
			
		}
	}
	public String getLogined_id() {
		return logined_id;
	}
	public void setLogined_id(String logined_id) {
		this.logined_id = logined_id;
	}
	public Connection getConn() {
		return conn;
	}
	public void setConn(Connection conn) {
		this.conn = conn;
	}
	public String getSql() {
		return sql;
	}
	public void setSql(String sql) {
		this.sql = sql;
	}
	
	public ResultSet getResult() {
		return result;
	}
	public void setResult(ResultSet result) {
		this.result = result;
	}
	public ResultSetMetaData getMetaData() {
		return metaData;
	}
	public void setMetaData(ResultSetMetaData metaData) {
		this.metaData = metaData;
	}
	public PreparedStatement getPrepared() {
		return prepared;
	}
	public void setPrepared(PreparedStatement prepared) {
		this.prepared = prepared;
	}
	@Override
	public void finalize() throws Throwable
	{
		super.finalize();
		close();
	}
}
