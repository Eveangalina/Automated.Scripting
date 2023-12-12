import psutil
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# Fetch system information
user_time = psutil.cpu_times().user
kernel_time = psutil.cpu_times().system
idle_time = psutil.cpu_times().idle
priority_user_time = psutil.cpu_times().nice
io_wait_time = psutil.cpu_times().iowait
hardware_interrupt_time = psutil.cpu_times().irq
software_interrupt_time = psutil.cpu_times().softirq
virtual_env_time = psutil.cpu_times().steal
virtual_cpu_time = psutil.cpu_times().guest

# Save information to a .txt file
with open('system_info.txt', 'w') as file:
    file.write(f"User time: {user_time}\n")
    file.write(f"Kernel time: {kernel_time}\n")
    file.write(f"Idle time: {idle_time}\n")
    file.write(f"Priority user time: {priority_user_time}\n")
    file.write(f"I/O wait time: {io_wait_time}\n")
    file.write(f"Hardware interrupt time: {hardware_interrupt_time}\n")
    file.write(f"Software interrupt time: {software_interrupt_time}\n")
    file.write(f"Virtualized OS time: {virtual_env_time}\n")
    file.write(f"Virtual CPU time: {virtual_cpu_time}\n")

print("System information saved to system_info.txt")

# Email configuration
email_sender = 'eveangalinascampos@gmail.com'  # Replace with your Gmail address
email_receiver = 'vshreene@gmail.com'  # Receiver's email address
password = 'mmbf jckw lnod kgqw'  # Replace with your Gmail password

# Email content
subject = 'System Information'
body = 'Please find the system information attached.'

# Set up the MIME
message = MIMEMultipart()
message['From'] = email_sender
message['To'] = email_receiver
message['Subject'] = subject

# Attach the file
attachment = MIMEText(open('system_info.txt', 'r').read())
attachment.add_header('Content-Disposition', 'attachment', filename='system_info.txt')
message.attach(attachment)

# Connect to Gmail's SMTP server and send the email
try:
    server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    server.login(email_sender, password)
    server.sendmail(email_sender, email_receiver, message.as_string())
    server.quit()
    print("Email sent successfully!")
except Exception as e:
    print(f"Error sending email: {str(e)}")
# resources [ChatGPT] (https://chat.openai.com/share/19054c8c-49ac-4de9-a6e2-caeb8ea7c3d4)