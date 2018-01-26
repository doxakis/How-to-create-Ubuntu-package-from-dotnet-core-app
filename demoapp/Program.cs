using System;

namespace demoapp
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Starting...");
            Console.WriteLine("Arguments:");
            foreach (string arg in args)
            {
                Console.WriteLine("  " + arg);
            }
            Console.WriteLine("End!");
        }
    }
}
