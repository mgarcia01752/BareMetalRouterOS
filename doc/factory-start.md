# Factory Start

## Default Login

When you first boot up the system, the default username is `root`, and there is no password set. However, as a security measure, once you create a new username, the `root` account is automatically removed. Follow the steps below to create a new user account and secure your router.


### Step-by-Step Instructions

1. **Login as `root`**: On initial boot, you will be prompted to login. Enter `root` as the username. Since no password is set initially, you will proceed to the next step directly.
   
   ```shell
   Router login: root
   ```

2. **Create a New User**: You will be prompted to create a new username. Enter your desired username. For example, `dev01`.

   ```shell
   Enter the new username: dev01
   ```

3. **Set a Password**: After entering the new username, you will need to set a password for this new account. The password must be at least 5 characters long and should include a combination of upper and lower case letters, as well as numbers for enhanced security.

   ```shell
   Enter the new password (minimum of 5 characters)
   Please use a combination of upper and lower case letters and numbers.
   New password:
   ```

4. **Confirm the Password**: Re-enter the password to confirm it. If the passwords match, the new password will be set, and the `root` account will be disabled for security reasons.

   ```shell
   Re-enter new password: 
   passwd: password changed.
   ```

### Important Security Notes

- **Password Strength**: Always use a strong password to ensure the security of your router. A strong password typically includes a mix of upper and lower case letters, numbers, and special characters.
  
- **User Management**: Once the `root` account is removed, manage user accounts carefully. Ensure that you create accounts with the least privilege necessary for users to perform their tasks.

- **System Access**: After the initial setup, you will use the newly created username and password to access the router. Keep your credentials secure and do not share them with unauthorized individuals.

By following these steps, you can ensure that your router is set up securely from the start, minimizing the risk of unauthorized access.