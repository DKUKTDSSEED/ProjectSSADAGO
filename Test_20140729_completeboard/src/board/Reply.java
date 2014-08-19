package board;

import java.io.Serializable;
import java.sql.Timestamp;

public class Reply implements Serializable
{
	private static final long serialVersionUID = -4275292237204361330L;
	private long num, board_num;
	private String writer, content;
	private Timestamp reg_date;
	public Reply()
	{
		reg_date = new Timestamp(System.currentTimeMillis());
	}
	public long getNum() {
		return num;
	}
	public void setNum(long num) {
		this.num = num;
	}
	public long getBoard_num() {
		return board_num;
	}
	public void setBoard_num(long board_num) {
		this.board_num = board_num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
}
