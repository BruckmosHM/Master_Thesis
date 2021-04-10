
namespace GUI_CSharp
{
    partial class Motor_Control_GUI
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.disconnectBtn = new System.Windows.Forms.Button();
            this.connectBtn = new System.Windows.Forms.Button();
            this.comboBox1 = new System.Windows.Forms.ComboBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.posAcc1 = new System.Windows.Forms.Button();
            this.rotateBtn = new System.Windows.Forms.Button();
            this.multiControlBtn = new System.Windows.Forms.Button();
            this.resetBtn = new System.Windows.Forms.Button();
            this.liftButton = new System.Windows.Forms.Button();
            this.stretch = new System.Windows.Forms.Button();
            this.releaseBtn = new System.Windows.Forms.Button();
            this.moveBtn = new System.Windows.Forms.Button();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.setAccelBtn = new System.Windows.Forms.Button();
            this.accelTxtBox = new System.Windows.Forms.TextBox();
            this.setSteptypeBtn = new System.Windows.Forms.Button();
            this.stepTypeComboBox = new System.Windows.Forms.ComboBox();
            this.setSpeedBtn = new System.Windows.Forms.Button();
            this.speedTxtBox = new System.Windows.Forms.TextBox();
            this.richTextBox1 = new System.Windows.Forms.RichTextBox();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.groupBox5 = new System.Windows.Forms.GroupBox();
            this.steptypeLabel = new System.Windows.Forms.Label();
            this.accelLabel = new System.Windows.Forms.Label();
            this.speedLabel = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox6 = new System.Windows.Forms.GroupBox();
            this.sendDegreeBtn = new System.Windows.Forms.Button();
            this.sendMotorSteps = new System.Windows.Forms.Button();
            this.motor5Steps = new System.Windows.Forms.TextBox();
            this.motor4Steps = new System.Windows.Forms.TextBox();
            this.motor3Steps = new System.Windows.Forms.TextBox();
            this.motor2Steps = new System.Windows.Forms.TextBox();
            this.motor1Steps = new System.Windows.Forms.TextBox();
            this.groupBox7 = new System.Windows.Forms.GroupBox();
            this.m5degLabel = new System.Windows.Forms.Label();
            this.m4degLabel = new System.Windows.Forms.Label();
            this.m3degLabel = new System.Windows.Forms.Label();
            this.m2degLabel = new System.Windows.Forms.Label();
            this.m1degLabel = new System.Windows.Forms.Label();
            this.label11 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.m5PosLabel = new System.Windows.Forms.Label();
            this.m4PosLabel = new System.Windows.Forms.Label();
            this.m3PosLabel = new System.Windows.Forms.Label();
            this.m2PosLabel = new System.Windows.Forms.Label();
            this.m1PosLabel = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.ToolTip = new System.Windows.Forms.ToolTip(this.components);
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox4.SuspendLayout();
            this.groupBox5.SuspendLayout();
            this.groupBox6.SuspendLayout();
            this.groupBox7.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.disconnectBtn);
            this.groupBox1.Controls.Add(this.connectBtn);
            this.groupBox1.Controls.Add(this.comboBox1);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(130, 119);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Com Port Selection";
            // 
            // disconnectBtn
            // 
            this.disconnectBtn.Location = new System.Drawing.Point(45, 82);
            this.disconnectBtn.Name = "disconnectBtn";
            this.disconnectBtn.Size = new System.Drawing.Size(75, 23);
            this.disconnectBtn.TabIndex = 2;
            this.disconnectBtn.Text = "Disconnect";
            this.disconnectBtn.UseVisualStyleBackColor = true;
            this.disconnectBtn.Click += new System.EventHandler(this.disconnectBtn_Click);
            // 
            // connectBtn
            // 
            this.connectBtn.Location = new System.Drawing.Point(45, 53);
            this.connectBtn.Name = "connectBtn";
            this.connectBtn.Size = new System.Drawing.Size(75, 23);
            this.connectBtn.TabIndex = 1;
            this.connectBtn.Text = "Connect";
            this.connectBtn.UseVisualStyleBackColor = true;
            this.connectBtn.Click += new System.EventHandler(this.connectBtn_Click);
            // 
            // comboBox1
            // 
            this.comboBox1.FormattingEnabled = true;
            this.comboBox1.Location = new System.Drawing.Point(6, 22);
            this.comboBox1.Name = "comboBox1";
            this.comboBox1.Size = new System.Drawing.Size(114, 23);
            this.comboBox1.TabIndex = 0;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.posAcc1);
            this.groupBox2.Controls.Add(this.rotateBtn);
            this.groupBox2.Controls.Add(this.multiControlBtn);
            this.groupBox2.Controls.Add(this.resetBtn);
            this.groupBox2.Controls.Add(this.liftButton);
            this.groupBox2.Controls.Add(this.stretch);
            this.groupBox2.Controls.Add(this.releaseBtn);
            this.groupBox2.Controls.Add(this.moveBtn);
            this.groupBox2.Location = new System.Drawing.Point(12, 137);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(305, 140);
            this.groupBox2.TabIndex = 2;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Motion Sequences";
            // 
            // posAcc1
            // 
            this.posAcc1.Location = new System.Drawing.Point(87, 80);
            this.posAcc1.Name = "posAcc1";
            this.posAcc1.Size = new System.Drawing.Size(100, 23);
            this.posAcc1.TabIndex = 7;
            this.posAcc1.Text = "Accuracy Test";
            this.ToolTip.SetToolTip(this.posAcc1, "Motion Sequence to test Position/Repeatability of the Arm.\r\nStart from Test Posit" +
        "ion.\r\n");
            this.posAcc1.UseVisualStyleBackColor = true;
            this.posAcc1.Click += new System.EventHandler(this.posAcc1_Click);
            // 
            // rotateBtn
            // 
            this.rotateBtn.Location = new System.Drawing.Point(151, 21);
            this.rotateBtn.Name = "rotateBtn";
            this.rotateBtn.Size = new System.Drawing.Size(58, 23);
            this.rotateBtn.TabIndex = 6;
            this.rotateBtn.Text = "Rotate";
            this.ToolTip.SetToolTip(this.rotateBtn, "Rotate the arm after \"Lift\" sequence.\r\nControls Joint 1-4.");
            this.rotateBtn.UseVisualStyleBackColor = true;
            this.rotateBtn.Click += new System.EventHandler(this.rotateBtn_Click);
            // 
            // multiControlBtn
            // 
            this.multiControlBtn.Location = new System.Drawing.Point(87, 51);
            this.multiControlBtn.Name = "multiControlBtn";
            this.multiControlBtn.Size = new System.Drawing.Size(100, 23);
            this.multiControlBtn.TabIndex = 5;
            this.multiControlBtn.Text = "Multi Control";
            this.ToolTip.SetToolTip(this.multiControlBtn, "Control All Motors at Once. \r\nMove every motor a 20 degrees.\r\n");
            this.multiControlBtn.UseVisualStyleBackColor = true;
            this.multiControlBtn.Click += new System.EventHandler(this.multiControlBtn_Click);
            // 
            // resetBtn
            // 
            this.resetBtn.Location = new System.Drawing.Point(6, 109);
            this.resetBtn.Name = "resetBtn";
            this.resetBtn.Size = new System.Drawing.Size(75, 23);
            this.resetBtn.TabIndex = 4;
            this.resetBtn.Text = "Reset";
            this.ToolTip.SetToolTip(this.resetBtn, "Reset the position to 0.");
            this.resetBtn.UseVisualStyleBackColor = true;
            this.resetBtn.Click += new System.EventHandler(this.resetBtn_Click);
            // 
            // liftButton
            // 
            this.liftButton.Location = new System.Drawing.Point(87, 22);
            this.liftButton.Name = "liftButton";
            this.liftButton.Size = new System.Drawing.Size(58, 23);
            this.liftButton.TabIndex = 3;
            this.liftButton.Text = "Lift";
            this.ToolTip.SetToolTip(this.liftButton, "Motion Sequence to lift the end effector.\r\nControls Joint 2 and 3. Start from Pos" +
        "ition 0\r\nEnd effector at lowest point.");
            this.liftButton.UseVisualStyleBackColor = true;
            this.liftButton.Click += new System.EventHandler(this.liftButton_Click);
            // 
            // stretch
            // 
            this.stretch.Location = new System.Drawing.Point(6, 51);
            this.stretch.Name = "stretch";
            this.stretch.Size = new System.Drawing.Size(75, 23);
            this.stretch.TabIndex = 2;
            this.stretch.Text = "Stretch";
            this.ToolTip.SetToolTip(this.stretch, "Release Al");
            this.stretch.UseVisualStyleBackColor = true;
            this.stretch.Click += new System.EventHandler(this.stretch_Click);
            // 
            // releaseBtn
            // 
            this.releaseBtn.Location = new System.Drawing.Point(6, 80);
            this.releaseBtn.Name = "releaseBtn";
            this.releaseBtn.Size = new System.Drawing.Size(75, 23);
            this.releaseBtn.TabIndex = 1;
            this.releaseBtn.Text = "Release";
            this.ToolTip.SetToolTip(this.releaseBtn, "Release all motors and reset the position to 0.\r\n");
            this.releaseBtn.UseVisualStyleBackColor = true;
            this.releaseBtn.Click += new System.EventHandler(this.releaseBtn_Click);
            // 
            // moveBtn
            // 
            this.moveBtn.Location = new System.Drawing.Point(6, 22);
            this.moveBtn.Name = "moveBtn";
            this.moveBtn.Size = new System.Drawing.Size(75, 23);
            this.moveBtn.TabIndex = 0;
            this.moveBtn.Text = "Crouch";
            this.moveBtn.UseVisualStyleBackColor = true;
            this.moveBtn.Click += new System.EventHandler(this.moveBtn_Click);
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.setAccelBtn);
            this.groupBox3.Controls.Add(this.accelTxtBox);
            this.groupBox3.Controls.Add(this.setSteptypeBtn);
            this.groupBox3.Controls.Add(this.stepTypeComboBox);
            this.groupBox3.Controls.Add(this.setSpeedBtn);
            this.groupBox3.Controls.Add(this.speedTxtBox);
            this.groupBox3.Location = new System.Drawing.Point(323, 12);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(243, 119);
            this.groupBox3.TabIndex = 3;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Change Stepper Settings";
            // 
            // setAccelBtn
            // 
            this.setAccelBtn.Location = new System.Drawing.Point(133, 53);
            this.setAccelBtn.Name = "setAccelBtn";
            this.setAccelBtn.Size = new System.Drawing.Size(100, 23);
            this.setAccelBtn.TabIndex = 5;
            this.setAccelBtn.Text = "Set Acceleration";
            this.setAccelBtn.UseVisualStyleBackColor = true;
            this.setAccelBtn.Click += new System.EventHandler(this.setAccelBtn_Click);
            // 
            // accelTxtBox
            // 
            this.accelTxtBox.Location = new System.Drawing.Point(6, 53);
            this.accelTxtBox.Name = "accelTxtBox";
            this.accelTxtBox.Size = new System.Drawing.Size(121, 23);
            this.accelTxtBox.TabIndex = 4;
            // 
            // setSteptypeBtn
            // 
            this.setSteptypeBtn.Location = new System.Drawing.Point(133, 81);
            this.setSteptypeBtn.Name = "setSteptypeBtn";
            this.setSteptypeBtn.Size = new System.Drawing.Size(100, 23);
            this.setSteptypeBtn.TabIndex = 3;
            this.setSteptypeBtn.Text = "Set Steptype";
            this.setSteptypeBtn.UseVisualStyleBackColor = true;
            this.setSteptypeBtn.Click += new System.EventHandler(this.setSteptypeBtn_Click);
            // 
            // stepTypeComboBox
            // 
            this.stepTypeComboBox.FormattingEnabled = true;
            this.stepTypeComboBox.Items.AddRange(new object[] {
            "Single",
            "Double",
            "Interleave",
            "Microstep"});
            this.stepTypeComboBox.Location = new System.Drawing.Point(6, 82);
            this.stepTypeComboBox.Name = "stepTypeComboBox";
            this.stepTypeComboBox.Size = new System.Drawing.Size(121, 23);
            this.stepTypeComboBox.TabIndex = 2;
            // 
            // setSpeedBtn
            // 
            this.setSpeedBtn.Location = new System.Drawing.Point(133, 22);
            this.setSpeedBtn.Name = "setSpeedBtn";
            this.setSpeedBtn.Size = new System.Drawing.Size(100, 23);
            this.setSpeedBtn.TabIndex = 1;
            this.setSpeedBtn.Text = "Set Speed";
            this.setSpeedBtn.UseVisualStyleBackColor = true;
            this.setSpeedBtn.Click += new System.EventHandler(this.setSpeedBtn_Click);
            // 
            // speedTxtBox
            // 
            this.speedTxtBox.Location = new System.Drawing.Point(6, 22);
            this.speedTxtBox.Name = "speedTxtBox";
            this.speedTxtBox.Size = new System.Drawing.Size(121, 23);
            this.speedTxtBox.TabIndex = 0;
            // 
            // richTextBox1
            // 
            this.richTextBox1.Location = new System.Drawing.Point(6, 22);
            this.richTextBox1.Name = "richTextBox1";
            this.richTextBox1.Size = new System.Drawing.Size(748, 137);
            this.richTextBox1.TabIndex = 4;
            this.richTextBox1.Text = "";
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.richTextBox1);
            this.groupBox4.Location = new System.Drawing.Point(12, 283);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(760, 165);
            this.groupBox4.TabIndex = 5;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Console";
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add(this.steptypeLabel);
            this.groupBox5.Controls.Add(this.accelLabel);
            this.groupBox5.Controls.Add(this.speedLabel);
            this.groupBox5.Controls.Add(this.label3);
            this.groupBox5.Controls.Add(this.label2);
            this.groupBox5.Controls.Add(this.label1);
            this.groupBox5.Location = new System.Drawing.Point(148, 12);
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Size = new System.Drawing.Size(169, 119);
            this.groupBox5.TabIndex = 6;
            this.groupBox5.TabStop = false;
            this.groupBox5.Text = "Stepper Settings";
            // 
            // steptypeLabel
            // 
            this.steptypeLabel.Location = new System.Drawing.Point(88, 49);
            this.steptypeLabel.Name = "steptypeLabel";
            this.steptypeLabel.Size = new System.Drawing.Size(75, 15);
            this.steptypeLabel.TabIndex = 1;
            this.steptypeLabel.Text = "Double";
            this.steptypeLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // accelLabel
            // 
            this.accelLabel.Location = new System.Drawing.Point(88, 34);
            this.accelLabel.Name = "accelLabel";
            this.accelLabel.Size = new System.Drawing.Size(75, 15);
            this.accelLabel.TabIndex = 3;
            this.accelLabel.Text = "60";
            this.accelLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // speedLabel
            // 
            this.speedLabel.Location = new System.Drawing.Point(88, 19);
            this.speedLabel.Name = "speedLabel";
            this.speedLabel.Size = new System.Drawing.Size(75, 15);
            this.speedLabel.TabIndex = 2;
            this.speedLabel.Text = "150";
            this.speedLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(6, 49);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(56, 15);
            this.label3.TabIndex = 1;
            this.label3.Text = "Steptype:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(6, 34);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(76, 15);
            this.label2.TabIndex = 1;
            this.label2.Text = "Acceleration:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(45, 15);
            this.label1.TabIndex = 0;
            this.label1.Text = "Speed: ";
            // 
            // groupBox6
            // 
            this.groupBox6.Controls.Add(this.sendDegreeBtn);
            this.groupBox6.Controls.Add(this.sendMotorSteps);
            this.groupBox6.Controls.Add(this.motor5Steps);
            this.groupBox6.Controls.Add(this.motor4Steps);
            this.groupBox6.Controls.Add(this.motor3Steps);
            this.groupBox6.Controls.Add(this.motor2Steps);
            this.groupBox6.Controls.Add(this.motor1Steps);
            this.groupBox6.Location = new System.Drawing.Point(323, 140);
            this.groupBox6.Name = "groupBox6";
            this.groupBox6.Size = new System.Drawing.Size(450, 137);
            this.groupBox6.TabIndex = 7;
            this.groupBox6.TabStop = false;
            this.groupBox6.Text = "Manual Motor Control";
            // 
            // sendDegreeBtn
            // 
            this.sendDegreeBtn.Location = new System.Drawing.Point(361, 48);
            this.sendDegreeBtn.Name = "sendDegreeBtn";
            this.sendDegreeBtn.Size = new System.Drawing.Size(82, 23);
            this.sendDegreeBtn.TabIndex = 6;
            this.sendDegreeBtn.Text = "Degree";
            this.sendDegreeBtn.UseVisualStyleBackColor = true;
            this.sendDegreeBtn.Click += new System.EventHandler(this.sendDegreeBtn_Click);
            // 
            // sendMotorSteps
            // 
            this.sendMotorSteps.Location = new System.Drawing.Point(361, 19);
            this.sendMotorSteps.Name = "sendMotorSteps";
            this.sendMotorSteps.Size = new System.Drawing.Size(82, 23);
            this.sendMotorSteps.TabIndex = 5;
            this.sendMotorSteps.Text = "Steps";
            this.sendMotorSteps.UseVisualStyleBackColor = true;
            this.sendMotorSteps.Click += new System.EventHandler(this.sendMotorSteps_Click);
            // 
            // motor5Steps
            // 
            this.motor5Steps.Location = new System.Drawing.Point(290, 19);
            this.motor5Steps.Name = "motor5Steps";
            this.motor5Steps.Size = new System.Drawing.Size(65, 23);
            this.motor5Steps.TabIndex = 4;
            // 
            // motor4Steps
            // 
            this.motor4Steps.Location = new System.Drawing.Point(219, 19);
            this.motor4Steps.Name = "motor4Steps";
            this.motor4Steps.Size = new System.Drawing.Size(65, 23);
            this.motor4Steps.TabIndex = 3;
            // 
            // motor3Steps
            // 
            this.motor3Steps.Location = new System.Drawing.Point(148, 19);
            this.motor3Steps.Name = "motor3Steps";
            this.motor3Steps.Size = new System.Drawing.Size(65, 23);
            this.motor3Steps.TabIndex = 2;
            // 
            // motor2Steps
            // 
            this.motor2Steps.Location = new System.Drawing.Point(77, 19);
            this.motor2Steps.Name = "motor2Steps";
            this.motor2Steps.Size = new System.Drawing.Size(65, 23);
            this.motor2Steps.TabIndex = 1;
            // 
            // motor1Steps
            // 
            this.motor1Steps.Location = new System.Drawing.Point(6, 19);
            this.motor1Steps.Name = "motor1Steps";
            this.motor1Steps.Size = new System.Drawing.Size(65, 23);
            this.motor1Steps.TabIndex = 0;
            // 
            // groupBox7
            // 
            this.groupBox7.Controls.Add(this.m5degLabel);
            this.groupBox7.Controls.Add(this.m4degLabel);
            this.groupBox7.Controls.Add(this.m3degLabel);
            this.groupBox7.Controls.Add(this.m2degLabel);
            this.groupBox7.Controls.Add(this.m1degLabel);
            this.groupBox7.Controls.Add(this.label11);
            this.groupBox7.Controls.Add(this.label10);
            this.groupBox7.Controls.Add(this.m5PosLabel);
            this.groupBox7.Controls.Add(this.m4PosLabel);
            this.groupBox7.Controls.Add(this.m3PosLabel);
            this.groupBox7.Controls.Add(this.m2PosLabel);
            this.groupBox7.Controls.Add(this.m1PosLabel);
            this.groupBox7.Controls.Add(this.label9);
            this.groupBox7.Controls.Add(this.label8);
            this.groupBox7.Controls.Add(this.label7);
            this.groupBox7.Controls.Add(this.label5);
            this.groupBox7.Controls.Add(this.label6);
            this.groupBox7.Location = new System.Drawing.Point(572, 12);
            this.groupBox7.Name = "groupBox7";
            this.groupBox7.Size = new System.Drawing.Size(201, 119);
            this.groupBox7.TabIndex = 8;
            this.groupBox7.TabStop = false;
            this.groupBox7.Text = "Motor Positions";
            // 
            // m5degLabel
            // 
            this.m5degLabel.Location = new System.Drawing.Point(104, 89);
            this.m5degLabel.Name = "m5degLabel";
            this.m5degLabel.Size = new System.Drawing.Size(50, 15);
            this.m5degLabel.TabIndex = 17;
            this.m5degLabel.Text = "0";
            this.m5degLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m4degLabel
            // 
            this.m4degLabel.Location = new System.Drawing.Point(104, 74);
            this.m4degLabel.Name = "m4degLabel";
            this.m4degLabel.Size = new System.Drawing.Size(50, 15);
            this.m4degLabel.TabIndex = 16;
            this.m4degLabel.Text = "0";
            this.m4degLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m3degLabel
            // 
            this.m3degLabel.Location = new System.Drawing.Point(104, 59);
            this.m3degLabel.Name = "m3degLabel";
            this.m3degLabel.Size = new System.Drawing.Size(50, 15);
            this.m3degLabel.TabIndex = 15;
            this.m3degLabel.Text = "0";
            this.m3degLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m2degLabel
            // 
            this.m2degLabel.Location = new System.Drawing.Point(104, 44);
            this.m2degLabel.Name = "m2degLabel";
            this.m2degLabel.Size = new System.Drawing.Size(50, 15);
            this.m2degLabel.TabIndex = 14;
            this.m2degLabel.Text = "0";
            this.m2degLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m1degLabel
            // 
            this.m1degLabel.Location = new System.Drawing.Point(104, 29);
            this.m1degLabel.Name = "m1degLabel";
            this.m1degLabel.Size = new System.Drawing.Size(50, 15);
            this.m1degLabel.TabIndex = 13;
            this.m1degLabel.Text = "0";
            this.m1degLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(105, 14);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(49, 15);
            this.label11.TabIndex = 12;
            this.label11.Text = "Degrees";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(64, 14);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(35, 15);
            this.label10.TabIndex = 11;
            this.label10.Text = "Steps";
            // 
            // m5PosLabel
            // 
            this.m5PosLabel.Location = new System.Drawing.Point(49, 89);
            this.m5PosLabel.Name = "m5PosLabel";
            this.m5PosLabel.Size = new System.Drawing.Size(50, 15);
            this.m5PosLabel.TabIndex = 10;
            this.m5PosLabel.Text = "0";
            this.m5PosLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m4PosLabel
            // 
            this.m4PosLabel.Location = new System.Drawing.Point(49, 74);
            this.m4PosLabel.Name = "m4PosLabel";
            this.m4PosLabel.Size = new System.Drawing.Size(50, 15);
            this.m4PosLabel.TabIndex = 9;
            this.m4PosLabel.Text = "0";
            this.m4PosLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m3PosLabel
            // 
            this.m3PosLabel.Location = new System.Drawing.Point(49, 59);
            this.m3PosLabel.Name = "m3PosLabel";
            this.m3PosLabel.Size = new System.Drawing.Size(50, 15);
            this.m3PosLabel.TabIndex = 8;
            this.m3PosLabel.Text = "0";
            this.m3PosLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m2PosLabel
            // 
            this.m2PosLabel.Location = new System.Drawing.Point(49, 44);
            this.m2PosLabel.Name = "m2PosLabel";
            this.m2PosLabel.Size = new System.Drawing.Size(50, 15);
            this.m2PosLabel.TabIndex = 7;
            this.m2PosLabel.Text = "0";
            this.m2PosLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // m1PosLabel
            // 
            this.m1PosLabel.Location = new System.Drawing.Point(49, 29);
            this.m1PosLabel.Name = "m1PosLabel";
            this.m1PosLabel.Size = new System.Drawing.Size(50, 15);
            this.m1PosLabel.TabIndex = 6;
            this.m1PosLabel.Text = "0";
            this.m1PosLabel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(3, 90);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(41, 15);
            this.label9.TabIndex = 5;
            this.label9.Text = "Joint 5";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(2, 74);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(41, 15);
            this.label8.TabIndex = 4;
            this.label8.Text = "Joint 4";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(2, 59);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(41, 15);
            this.label7.TabIndex = 3;
            this.label7.Text = "Joint 3";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(2, 44);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(41, 15);
            this.label5.TabIndex = 2;
            this.label5.Text = "Joint 2";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(2, 29);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(41, 15);
            this.label6.TabIndex = 1;
            this.label6.Text = "Joint 1";
            // 
            // ToolTip
            // 
            this.ToolTip.Popup += new System.Windows.Forms.PopupEventHandler(this.toolTip1_Popup);
            // 
            // Motor_Control_GUI
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.Window;
            this.ClientSize = new System.Drawing.Size(782, 454);
            this.Controls.Add(this.groupBox7);
            this.Controls.Add(this.groupBox6);
            this.Controls.Add(this.groupBox5);
            this.Controls.Add(this.groupBox4);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Name = "Motor_Control_GUI";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox2.ResumeLayout(false);
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.groupBox4.ResumeLayout(false);
            this.groupBox5.ResumeLayout(false);
            this.groupBox5.PerformLayout();
            this.groupBox6.ResumeLayout(false);
            this.groupBox6.PerformLayout();
            this.groupBox7.ResumeLayout(false);
            this.groupBox7.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button disconnectBtn;
        private System.Windows.Forms.Button connectBtn;
        private System.Windows.Forms.ComboBox comboBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.TextBox speedTxtBox;
        private System.Windows.Forms.Button setSpeedBtn;
        private System.Windows.Forms.Button moveBtn;
        private System.Windows.Forms.RichTextBox richTextBox1;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.Button setAccelBtn;
        private System.Windows.Forms.TextBox accelTxtBox;
        private System.Windows.Forms.Button setSteptypeBtn;
        private System.Windows.Forms.ComboBox stepTypeComboBox;
        private System.Windows.Forms.GroupBox groupBox5;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label steptypeLabel;
        private System.Windows.Forms.Label accelLabel;
        private System.Windows.Forms.Label speedLabel;
        private System.Windows.Forms.Button releaseBtn;
        private System.Windows.Forms.Button stretch;
        private System.Windows.Forms.GroupBox groupBox6;
        private System.Windows.Forms.Button sendMotorSteps;
        private System.Windows.Forms.TextBox motor5Steps;
        private System.Windows.Forms.TextBox motor4Steps;
        private System.Windows.Forms.TextBox motor3Steps;
        private System.Windows.Forms.TextBox motor2Steps;
        private System.Windows.Forms.TextBox motor1Steps;
        private System.Windows.Forms.GroupBox groupBox7;
        private System.Windows.Forms.Button liftButton;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label m5PosLabel;
        private System.Windows.Forms.Label m4PosLabel;
        private System.Windows.Forms.Label m3PosLabel;
        private System.Windows.Forms.Label m2PosLabel;
        private System.Windows.Forms.Label m1PosLabel;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Button resetBtn;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Button sendDegreeBtn;
        private System.Windows.Forms.Label m5degLabel;
        private System.Windows.Forms.Label m4degLabel;
        private System.Windows.Forms.Label m3degLabel;
        private System.Windows.Forms.Label m2degLabel;
        private System.Windows.Forms.Label m1degLabel;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.Button multiControlBtn;
        private System.Windows.Forms.Button rotateBtn;
        private System.Windows.Forms.Button posAcc1;
        private System.Windows.Forms.ToolTip ToolTip;
    }
}

