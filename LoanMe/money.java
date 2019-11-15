import java.awt.List;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Scanner;

/**
 * @author Divyansh
 *
 */

public class money {
	public static void main(String args[]) throws FileNotFoundException {
		Map<String, Integer> customer = new HashMap<>();
		Map<String, Integer> bank = new HashMap<>();
		ArrayList<bank> bank_list = new ArrayList<>();
		ArrayList<customer> customer_list = new ArrayList<>();
		int customers = 0;
		
		File file = new File("src\\customers.txt"); //please change the location accordingly
		Scanner sc = new Scanner(file); 
		while (sc.hasNextLine()) {
			String data = sc.nextLine();
			String[] key_value;
			data = data.replace(".", "");
			data = data.replace("{", "");
			data = data.replace("}", "");
			key_value = data.split(",");
			customer.put(key_value[0], Integer.parseInt(key_value[1]));
		}
		File file1 = new File("src\\banks.txt"); //please change the location accordingly
		Scanner sc1 = new Scanner(file1); 
		while (sc1.hasNextLine()) {
			String data = sc1.nextLine();
			String[] key_value;
			data = data.replace(".", "");
			data = data.replace("{", "");
			data = data.replace("}", "");
			key_value = data.split(",");
			bank.put(key_value[0], Integer.parseInt(key_value[1]));
			
		}
		System.out.println("** Customers and loan objectives **");
		for(Map.Entry<String, Integer> entry : customer.entrySet()) {
			System.out.println(entry.getKey()+": "+entry.getValue());
			customers++;
		}
		System.out.println("\n** Banks and financial resources **");
		for(Map.Entry<String, Integer> entry : bank.entrySet()) {
			System.out.println(entry.getKey()+": "+entry.getValue());
		}
		System.out.println("");
		for(Map.Entry<String, Integer> entry : bank.entrySet()) {
			bank b = new bank(entry.getKey(), entry.getValue(), customers);
			bank_list.add(b);
			try {
				Thread.sleep(100);
			} catch (Exception e) {
				// TODO: handle exception
			}
		}

		for(Map.Entry<String, Integer> entry : customer.entrySet()) {
			customer c = new customer(entry.getKey(), entry.getValue(), bank_list);
			customer_list.add(c);
			try {
				Thread.sleep(100);
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
	}
}
