import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * @author Divyansh
 *
 */
public class customer extends Thread{
	String customer_name;
	ArrayList<bank> potential_lenders;
	Random r = new Random();
	int random_amount, amount, actual_amount;
	bank random_bank; 
	
	public customer(String customer_name, int amount, ArrayList<bank> bank_list) {
		this.customer_name = customer_name;
		this.amount = amount;
		this.potential_lenders = new ArrayList<>(bank_list);
		this.actual_amount = amount;
		start();
	}
	
	public void run() {
		do {
				random_amount = r.nextInt(50);
				if(potential_lenders.size()>1) {
					int random = r.nextInt(potential_lenders.size());
					random_bank = potential_lenders.get(random);
				}
				else if(potential_lenders.size()==1){
					random_bank = potential_lenders.get(0);
				}
				else {
					break;
				}
			if(random_amount<=amount && random_amount>0) {
				int low = 10;
				int high = 100;
				int result = r.nextInt(high-low) + low;
				
				try {
					Thread.sleep(result);
				} catch (Exception e) {
					// TODO: handle exception
				}
				String response = random_bank.request(random_amount);
				System.out.println(customer_name+" requests a loan of "+random_amount+" dollar(s) from "+random_bank.bank_name);
				
				if(response=="approve") {
					amount = amount - random_amount;
					System.out.println(random_bank.bank_name+" approves a loan of "+random_amount+" dollar(s) from "+customer_name);
					
					if(amount==0) {
						for(int i=0;i<potential_lenders.size();i++) {
							potential_lenders.get(i).stopThread();
						}
						break;
					}
				}
				else if(response=="deny") {
					random_bank.stopThread();
					potential_lenders.remove(random_bank);
					System.out.println(random_bank.bank_name+" denies a loan of "+random_amount+" dollar(s) from "+customer_name);
				}
				
			}
		} while (amount!=0 || potential_lenders.size()!=0);
		if(amount==0) {
			System.out.println(customer_name+" has reached the objective of "+actual_amount+" dollar(s). Woo Hoo!");
		}
		else if(amount>0){
			System.out.println(customer_name+" was only able to borrow "+(actual_amount-amount)+" dollar(s). Boo Hoo!");
		}
		
	}
	
}
