public class NumberUtility {
    
    public static List<Integer> getPrimeNumbers(Integer limitNumberPrime) {
        if (limitNumberPrime == null || limitNumberPrime < 0) {
            return new List<Integer> ();
        }
        List<Integer> primeList = new List<Integer> ();
        
        for (Integer i = 1; i <= limitNumberPrime; i++) {
            Integer num = 0;
            
            for (Integer j = 1; j <= limitNumberPrime; j++) {
                if (math.mod(i, j) == 0) { 
                    num += 1;
                }
            }
            if (num == 2) { 
                primeList.add(i);
            }
        }
        return primeList; 
    }
    
    public static List<Integer> getFibonacciNumbers(Integer limitNumberFibonacci) {
        if (limitNumberFibonacci == null) {
            return new List<Integer> ();
        }
        List<Integer> fibonacciList = new List<Integer> ();
        Integer n0 = 1;
        Integer n1 = 1;
        Integer n2;
        fibonacciList.add(n0);
        fibonacciList.add(n1);
        
        for (Integer i = 1; i <= limitNumberFibonacci; i++) {
            n2 = n0 + n1;
            if (n2 <= limitNumberFibonacci) {
                fibonacciList.add(n2);
                n0 = n1;
                n1 = n2;
            }
        }
        return fibonacciList;
    }

    public static Boolean isPalindromicityNumbers(Long checkNumber) {
        if (checkNumber == null) {
            return false;
        }
        Long rem = 0;
        Long sum = 0;
        Long temp = checkNumber;
        
        while (checkNumber > 0) {
            rem = math.mod(checkNumber, 10);   
            checkNumber = math.round(checkNumber / 10);   
            sum = sum * 10 + rem;
        }
        return (temp == sum);
    }
}