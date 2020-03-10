package mailtest;
import javax.mail.*;
public class GoogleAuthentication extends Authenticator{
    PasswordAuthentication passAuth;
    
    public GoogleAuthentication() {
        passAuth = new PasswordAuthentication("dnjsrud3407", "gzyroysijfeyajzm");
    }
    public PasswordAuthentication getPasswordAuthentication() {
        return passAuth;
    }
}