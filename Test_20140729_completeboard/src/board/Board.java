package board;

import java.io.Serializable;
import java.sql.Timestamp;

public class Board implements Serializable
{
	private static final long serialVersionUID = 45966791005084535L;
	private String writer, subjects, content;
	private long num, readcount;
	private Timestamp reg_date;
	public Board()
	{
		
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
	
}
