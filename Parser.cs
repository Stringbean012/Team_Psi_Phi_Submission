/*
    This code is used to convert the Hexadecimal files in data folder in single precision floating-point values (IEEE 754) and
    save the new files in parsed folder.
*/

using System;
using System.IO;

class Program
{
    static float HexToFloat(string hex)
    {
        int bits = Convert.ToInt32(hex, 16);
        return BitConverter.Int32BitsToSingle(bits);
    }

    static void Main()
    {
        for (int i = 543; i <= 842; i++)
        {
            string path = "parsed/dsn_capture_1772525" + i + ".txt";
            using (StreamWriter sw = File.CreateText(path))
            {
                string readText = File.ReadAllText("data/dsn_capture_1772525" + i + ".txt");
                string[] hexCodes = readText.Split('\n');
                foreach (string line in hexCodes)
                {
                    if(line == "") break;

                    string[] hexPair = line.Split(",");
                    float valueI = HexToFloat(hexPair[0]);
                    float valueQ = HexToFloat(hexPair[1].TrimStart());
                    //Console.WriteLine(line);

                    sw.WriteLine(valueI + ", " + valueQ);
                }
            }

        }
    }
}