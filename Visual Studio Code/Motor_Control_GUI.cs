using System;
using System.Linq;
using System.Windows.Forms;
using System.IO.Ports;
using System.Threading;

namespace GUI_CSharp
{
    public partial class Motor_Control_GUI : Form
    {
        // Variables
        private SerialPort serialPort = new SerialPort();
        private delegate void d1(string indata);
        private event SerialDataReceivedEventHandler myHandle;
        private int[] jointPos = new int[] { 0, 0, 0, 0, 0 };     // current positions of the motor


        // Form Intitialization
        public Motor_Control_GUI()
        {
            InitializeComponent();
            getAvailablePorts();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            
        }

        // Help Functions
        private void getAvailablePorts()
        {
            // Search for available ports and save them to ports dropdown list
            String[] ports = SerialPort.GetPortNames();
            comboBox1.Items.AddRange(ports);
        }

        private void toConsole(String instring)
        {
            // write the incoming string to the richTextBox which acts as a Console
            richTextBox1.AppendText(instring);
            richTextBox1.ScrollToCaret();
        }

        private void serialDataReceived(object sender, System.IO.Ports.SerialDataReceivedEventArgs e)
        {
            // This function is triggered when serial data has arrived. Reads the incoming String until "\n" and parses it to the form            
            SerialPort sp = (SerialPort)sender;
            string indata = sp.ReadLine();

            d1 writeit = new d1(write2Form);
            Invoke(writeit, indata);
        }

        private void toArduino(String command)
        {
            if (serialPort.IsOpen)
            {
                // Send the command to the Arduino
                serialPort.WriteLine(command);

            } else
            {
                toConsole("Error: Serial Port not connected!\n");
            }
        }

        private void write2Form(string indata)
        {
            // Incoming Feedback from arduino is sent over Serial and is parsed by the serialDataReceived function
            // The incoming Serial String is displayed in the console and special events are handeled
            toConsole(indata);

            // Echo from Positions of the Motors, format "Echo: Positions 20 20 20 20 20"
            if (indata.Length > 6 && indata[6] == 'P')
            {
                // Strip Front of Message "Echo: Positions " and "\n" at the end
                String _allPositions = indata.Substring(16, indata.Length - 1 - 16);
                String[] _splitStringPositions = { "", "", "", "", "" };
                int stringStart = 0;
                int arrayIndex = 0;

                // split positions
                for (int i = 0; i < _allPositions.Length; i++)
                {
                    // check current character if it's the split character
                    if (_allPositions[i] == ' ')
                    {
                        // clear previous value from array
                        _splitStringPositions[arrayIndex] = "";

                        // save substring into array
                        _splitStringPositions[arrayIndex] = _allPositions.Substring(stringStart, i - stringStart);

                        // set new string starting point
                        stringStart = (i + 1);
                        arrayIndex++;
                    }
                }
                _splitStringPositions[arrayIndex] = _allPositions.Substring(stringStart, _allPositions.Length - stringStart);

                // save the positions as integer in the motor position array
                for (int i = 0; i < 5; i++)
                {
                    jointPos[i] = Int16.Parse(_splitStringPositions[i]);
                }

                // update the GUI - Steps
                m1PosLabel.Text = _splitStringPositions[0];
                m2PosLabel.Text = _splitStringPositions[1];
                m3PosLabel.Text = _splitStringPositions[2];
                m4PosLabel.Text = _splitStringPositions[3];
                m5PosLabel.Text = _splitStringPositions[4];

                // Degree
                m1degLabel.Text = ((int) Math.Floor(jointPos[0] * 1.8 / 30)).ToString();
                m2degLabel.Text = ((int) Math.Floor(jointPos[1] * 1.8 / 43)).ToString();
                m3degLabel.Text = ((int) Math.Floor(jointPos[2] * 1.8 / 30)).ToString();
                m4degLabel.Text = ((int) Math.Floor(jointPos[3] * 1.8 / 30)).ToString();
                m5degLabel.Text = ((int) Math.Floor(jointPos[4] * 1.8 / 30)).ToString();
            }
        }


        // GUI Callbacks
        private void connectBtn_Click(object sender, EventArgs e)
        {
            // connect the application to the selected Port from the dropdown menu
            try
            {
                if (comboBox1.Text == "")
                {
                    toConsole("COM Connection: Please select viable Port\n");
                }
                else
                {
                    serialPort.PortName = comboBox1.Text;
                    serialPort.BaudRate = 9600;
                    
                    myHandle = new SerialDataReceivedEventHandler(serialDataReceived);
                    serialPort.DataReceived += myHandle;
                    serialPort.Open();
                    toConsole("COM Connection: Port opened on " + comboBox1.Text + "\n");
                }
            }
            catch (UnauthorizedAccessException)
            {
                toConsole("COM Connection: Unauthorized Access\n");
            }
        }

        private void disconnectBtn_Click(object sender, EventArgs e)
        {
            // disconnet from the port
            serialPort.DataReceived -= myHandle;
            serialPort.Close();
            toConsole("COM Connection: Serial Connection Closed\n");
        }

        private void setSpeedBtn_Click(object sender, EventArgs e)
        {
            // Send new Speed Command to Arduino
            toArduino("S S " + speedTxtBox.Text);
            speedLabel.Text = speedTxtBox.Text;
            speedTxtBox.Text = "";

        }

        private void moveBtn_Click(object sender, EventArgs e)
        {
            // Send new target positions to the Arduino
            toArduino("M 50 50 50 50 50");  
            
        }

        private void setAccelBtn_Click(object sender, EventArgs e)
        {
            // Send new Acceleration Command to Arduino
            toArduino("S A " + accelTxtBox.Text);
            accelLabel.Text = accelTxtBox.Text;
            accelTxtBox.Text = "";
            
        }

        private void setSteptypeBtn_Click(object sender, EventArgs e)
        {
            // Send new Steptype command to Arduino
            char s = stepTypeComboBox.Text[0];
            string p = "1";
            switch (s) { 
            case 'S':
                p = "1";
                break;
            case 'D':
                p = "2";
                break;
            case 'I':
                p = "3";
                break;
            case 'M':
                p = "4";
                break;
            default:
                break;
            }
            toArduino("S T " + p);
            steptypeLabel.Text = stepTypeComboBox.Text;
            
        }

        private void releaseBtn_Click(object sender, EventArgs e)
        {
            // Send release Command to Arduino
            toArduino("S R 0");            
        }

        private void stretch_Click(object sender, EventArgs e)
        {
            // Send new target positions to the Arduino
            toArduino("M -100 -100 -100 -100 -100");
            
        }

        private void sendMotorSteps_Click(object sender, EventArgs e)
        {
            // Send new manual defined target positions to the Arduino
            String[] steps = { "", "", "", "", "" };

            steps[0] = motor1Steps.Text;
            steps[1] = motor2Steps.Text;
            steps[2] = motor3Steps.Text;
            steps[3] = motor4Steps.Text;
            steps[4] = motor5Steps.Text;

            // check if the input is empty and replace it with 0
            for (int i = 0; i < 5; i++)
            {
                if (steps[i].Equals(""))
                {
                    steps[i] = "0";
                }
            }

            // send over Serial to the Arduino - "M pos1 pos2 pos3 pos4 pos5" - relative Movement
            toArduino("M " + steps[0] + " " + steps[1] + " " + steps[2] + " " + steps[3] + " " + steps[4]);

            // clear input fields
            motor1Steps.Text = "";
            motor2Steps.Text = "";
            motor3Steps.Text = "";
            motor4Steps.Text = "";
            motor5Steps.Text = "";
        }

        private void liftButton_Click(object sender, EventArgs e)
        {
            // Beginning From a Low Position, Lift until Link2 is horizontal and keep Link 3 vertical
            if (jointPos.SequenceEqual(new int[] { 0, 0, 0, 0, 0 }))
            {
                // Motors are in start position and movement can start

                // Joint 2: 70°/1.8°*43 = 1672
                // Joint 3: 70°/1.8°*30 = 1167
                if (steptypeLabel.Text.Equals("Microstep"))
                {
                    // Microsteps are smaller
                    // 1672*16 = 26752
                    // 1167*16 = 18672
                    toArduino("M 0 -26752 -18672 0 0");
                } else
                {
                    toArduino("M 0 -1672 -1167 0 0");
                }
                
            }
            else
            {
                // Motors are in the wrong position
                toConsole("Error: Motors are not in the right position!\n");
            }

        }

        private void resetBtn_Click(object sender, EventArgs e)
        {
            // Reset the Current Motor Positions
            toArduino("S E 0");

        }

        private void sendDegreeBtn_Click(object sender, EventArgs e)
        {
            // Send new manual defined target positions expressed in Degree to the Arduino
            String[] steps = { "", "", "", "", "" };
            int[] _pos = { 0, 0, 0, 0, 0 };

            steps[0] = motor1Steps.Text;
            steps[1] = motor2Steps.Text;
            steps[2] = motor3Steps.Text;
            steps[3] = motor4Steps.Text;
            steps[4] = motor5Steps.Text;

            // check if the input is empty and replace it with 0
            for (int i = 0; i < 5; i++)
            {
                if (steps[i].Equals(""))
                {
                    steps[i] = "0";
                }

                // convert to integer for calculations
                _pos[i] = Int32.Parse(steps[i]);

                // calculate steps from degree     
                if (i != 1)
                {
                    _pos[i] = (int) Math.Ceiling(_pos[i] / 1.8 * 30);
                } else
                {
                    _pos[i] = (int) Math.Ceiling(_pos[i] / 1.8 * 43);
                }
            }

            // send over Serial to the Arduino - "M pos1 pos2 pos3 pos4 pos5" - relative Movement
            toArduino("M " + _pos[0] + " " + _pos[1] + " " + _pos[2] + " " + _pos[3] + " " + _pos[4]);

            // clear input fields
            motor1Steps.Text = "";
            motor2Steps.Text = "";
            motor3Steps.Text = "";
            motor4Steps.Text = "";
            motor5Steps.Text = "";
        }

        private void multiControlBtn_Click(object sender, EventArgs e)
        {
            // Control all 4 connected motors to check multiple movement
            if (jointPos.SequenceEqual(new int[] { 0, 0, 0, 0, 0 }))
            {
                // Motors are in start position and movement can start

                // Joint 1: 20°/1.8°*30 = 333
                // Joint 2: 20°/1.8°*43 = 477
                // Joint 3: 20°/1.8°*30 = 333
                // Joint 2: 20°/1.8°*30 = 333
                if (steptypeLabel.Text.Equals("Microstep"))
                {
                    // Microsteps are smaller
                    toConsole("Error: Change to Double or Single Step!");
                }
                else
                {
                    toArduino("M 333 -477 -333 -333 0");
                }

            }
            else
            {
                // Motors are in the wrong position
                toConsole("Error: Motors are not in the right position!\n");
            }


        }

        private void rotateBtn_Click(object sender, EventArgs e)
        {
            // Rotate the Arm 180° clockwise - Arm needs to be lifted at first
            if (jointPos.SequenceEqual(new int[] { 0, -1672, -1167, 0, 0 }))
            {
                // Motors are in start position and movement can start

                // Joint 1: 145°/1.8°*30 = 2416
                // Joint 2: 50°/1.8°*43 = 1194
                // Joint 3: 20°/1.8°*30 = 333
                // Joint 4: 30°/1.8°*30 = 500

                if (steptypeLabel.Text.Equals("Microstep"))
                {
                    // Microsteps are smaller
                    toConsole("Error: Change to Double or Single Step!");
                }
                else
                {
                    toArduino("M 2416 -1194 -333 500 0");
                }

            }
            else
            {
                // Motors are in the wrong position
                toConsole("Error: Lift the Arm at first!\n");
            }
        }

        private void posAcc1_Click(object sender, EventArgs e)
        {
            //Move arm away from Accuracy Position
            //Joint 1/3/4: 10/1.8*30 = 166
            //Joint 2: 10/1.8*43 = 238

            toConsole("Starting Position Repeatability Test..\n");
            for (int i = 0; i < 5; i++)
            {
                toArduino("M 300 -238 200 166 0");
                Thread.Sleep(10000);
                toArduino("M -300 238 -200 -166 0");
                Thread.Sleep(10000);
            }
            toConsole("Repeatability Test done.\n");
        }

        private void toolTip1_Popup(object sender, PopupEventArgs e)
        {

        }
    }
}
