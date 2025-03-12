
public class GradeOutput {

	public static void main(String[] args) {
		Grade g1, g2;
		g1 = new Grade();
		g2 = new Grade();
		g1.input_grade(90, 85);
		g2.input_grade(80, 80);
		
		g1.output_grad();
		g2.output_grad();
	}
}
