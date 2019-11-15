import java.util.HashMap;
import java.util.Map;

/**
 * @author Divyansh
 *
 */
public class bank extends Thread{
	String bank_name;
	int balance, customers;
	private volatile boolean flag = true;
	
	public bank(String bank_name, int balance, int customers) {
		this.bank_name = bank_name;
		this.balance = balance;
		this.customers = customers;
		start();
	}
	
	public void run() {
		while(flag) {
			
		}
	}
	
	synchronized public String request(int amount) {
		if((balance-amount)>=0) {
			balance = balance - amount;
			return "approve";
		}
		else {
			return "deny";
		}
		
	}
	
	public void exitThread() {
		flag = false;
	}
	
	public void stopThread() {
		customers = customers - 1;
		if(customers==0) {
			System.out.println(bank_name+" has "+balance+" dollar(s) remaining.");
			exitThread();
		}
	}
}
