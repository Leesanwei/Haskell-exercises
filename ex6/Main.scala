import Array._
object Hello extends App {

    // TASK 1
    
    // A
    println("Hello World")
    val x: Array[Int] = Array(1, 2, 3)
    println(s"There are ${x.length} elements")
    
    
    // B
    var y = new Array[Int](50)
    for ( i <- 0 to (y.length - 1)) {
         y(i) = i+1
    }
    
    
    // C 
    var r = range(51,101)
    var z =  y ++ r
    
    
    // D
    def sumArray( a:Array[Int] ) : Int = {
      var sum: Int = 0
      for ( i <- a ) {
       sum = sum + i
      }
      return sum
    }
   
   
    // E
    def sumArrayRec( a:List[Int] ) : Int = a match { 
        case Nil => 0
        case head :: tail => head + sumArrayRec(tail)
    }
    
    
    // F
    def fib( n:Int) : BigInt = n match{
        case 0 => BigInt(0)
        case 1 => BigInt(1)
        case n => fib (n-2) + fib (n-1)
    }
    
    
    
    // TASK 2
    
    // A
    def my_func_lazy(f: () => BigInt, b: Boolean) = {
        lazy val t = f()
        if (b) println (t)
    }
    
    def exampleFunc(): BigInt = {
        return 100
    }
    
    my_func_lazy(exampleFunc, true);
    my_func_lazy(exampleFunc, false);
    
    /*
        my_func return the value of the input function only if the input boolean value is true.
        t is the return value of the input function, but it's a lazy value, so it is not computated until you don't need it.
    */
    
    // B
    def my_func(f: () => BigInt, b: Boolean) = {
        val t = f()
        if (b) println (t)
    }
    
    my_func(exampleFunc, true);
    my_func(exampleFunc, false);
    
    /*
        The difference is that in the first function the t value is not evalueted before we need it,
        instead in the second function, the t value is computated also if we don't need it.
    */
    
    // C
    /*
        Lazy evaluation is useful when you are not sure if you will need a value or not.
    */
    
    
    
    // TASK 3
    
    // A
    def thread(body: () => Unit): Thread = {
        val t = new Thread {
            override def run() = body
        }       
        return t
    }
    
    // B
    def fibFunc( n:Int) : Array[() => Unit] = {
        val a: Array[() => Unit] = Array()
        return fibFuncRec(n,a)
    }
    
     def fibFuncRec( n:Int, a:Array[() => Unit]) : Array[() => Unit] = n match {
        case 0 => a :+ {() =>  println (fib(n))}
        case _ => fibFuncRec(n-1, a :+ {() => println (fib(n))})
    }
    
    // C
    val fibArray = fibFunc(5).map(thread)
    
    // D
    for ( i <- 0 to (fibArray.length - 1)) {
         fibArray(i).start
    }
    
    // E
    /*
        private var counter: Int = 0
        
        def increaseCounter(): Int = {
            counter += 1
            counter
        }
    
        The code is not thread-safe because the function is not atomic and if different threads try to call increaseCounter(),
        thee statements from them can interleave arbitrarily.
        I would change the code adding this.synchronized!
        
        private var counter: Int = 0
        
        def increaseCounter(): Int = this.synchronized {
            counter += 1
            counter
        } 
    */
    
    
    
    // F
    /*
       A deadlock is a general situation in which two or more executions wait for each other to complete
       an action before proceeding with their own action. The reason for waiting is that each of the executions
       obtains an exclusive access to a resource that the other execution needs to proceed.
       The problem discussed before can be avoided by applying a suitable deadlock prevention technique, for example
       a correct use of monitors to better synchronize the processes and a by establishing a total order between resources. 
       
       An example with lazy value could be:
    
        object LazyValsAndBlocking extends App {
    
            lazy val x: Int = {
                val t = thread { println(s"Initializing $x.") }
                t.join()
                1
            }   
            x
        }
        
        The new thread attempts to access x, which is not initialized and on the other hand, the main thread waits for
        the other thread to terminate, so neither thread can progress.
    */
    
    
    
    
    
    
    
    
    
    
    
}

