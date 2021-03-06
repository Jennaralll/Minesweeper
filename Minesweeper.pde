import de.bezier.guido.*;
public static final int NUM_ROWS = 20;
public static final int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
PImage img;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    fill(0);
    buttons = new MSButton[20][20];
    for(int r = 0; r < NUM_ROWS; r ++){
        for(int c = 0; c < NUM_COLS; c ++){
            buttons[r][c] = new MSButton(r, c);
        }
    }
    setBombs();
}
public void setBombs()
{
    bombs = new ArrayList<MSButton>();
    for(int i = 0; i < 20; i ++){
        int r, c;
        r = (int)(Math.random()*20);
        c = (int)(Math.random()*20);
        if(!bombs.contains(buttons[r][c])){
            bombs.add(buttons[r][c]);
        }
    }
}

public void draw ()
{
    // background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    int flagged = 0;
    for(int i =0; i < bombs.size(); i ++){
        if(bombs.get(i).marked == true){
            flagged = flagged + 1;
        }
    }
    if(flagged == 20){
        return true;
    }
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
    if(!isWon()){
        for(int i = 0; i < bombs.size(); i ++){
            bombs.get(i).clicked = true;
        }
    }
    buttons[10][6].setLabel("Y");
    buttons[10][7].setLabel("O");
    buttons[10][8].setLabel("U");
    buttons[10][10].setLabel("L");
    buttons[10][11].setLabel("O");
    buttons[10][12].setLabel("S");
    buttons[10][13].setLabel("E");
    buttons[10][14].setLabel("!");
}
public void displayWinningMessage()
{
    //your code here
 
    buttons[10][6].setLabel("Y");
    buttons[10][7].setLabel("O");
    buttons[10][8].setLabel("U");
    buttons[10][10].setLabel("W");
    buttons[10][11].setLabel("I");
    buttons[10][12].setLabel("N");
    buttons[10][13].setLabel("!");

}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true && key == ' '){
            marked =! marked;
            if(marked == false){
                clicked = false;
            }  
        }
        else if(bombs.contains(this)){
            displayLosingMessage();
        }
        else if(countBombs(r, c) > 0){
            String numBombs = new String(" ");
            numBombs = numBombs + countBombs(r, c);
            setLabel(numBombs);
        }
        else{
          if (isValid(r, c-1) == true && !buttons[r][c-1].isClicked()){
             buttons[r][c-1].mousePressed();
          }
          if(isValid(r-1, c) ==true && !buttons[r-1][c].isClicked()){
             buttons[r-1][c].mousePressed();
          }
          if(isValid(r, c+1) == true && !buttons[r][c+1].isClicked()){
             buttons[r][c+1].mousePressed();
          }
          if(isValid(r+1, c) == true && !buttons[r+1][c].isClicked()){
             buttons[r+1][c].mousePressed();
          }
          if(isValid(r+1, c-1) == true && !buttons[r+1][c-1].isClicked()){
             buttons[r+1][c-1].mousePressed();
          }
          if(isValid(r-1,c-1) == true && !buttons[r-1][c-1].isClicked()){
             buttons[r-1][c-1].mousePressed();
          }
          if(isValid(r+1, c+1) == true && !buttons[r+1][c+1].isClicked()){
             buttons[r+1][c+1].mousePressed();
          }
          if(isValid(r-1, c+1) == true && !buttons[r-1][c+1].isClicked()){
             buttons[r-1][c+1].mousePressed();
          }
        }
    }

    public void draw () 
    {    
        img = loadImage("flag.png");
        img.resize(15, 15);
        if (marked){
            image(img, (c*20), r*20);
            fill(0, 0, 0, 5);
        }
        else if( clicked && bombs.contains(this) ){ 
            fill(255,0,0);
        }
        else if(clicked){
            fill( 200 );
        }
        else{ 
            fill( 100 );
        }
        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here 
        if(r < 20 && r >= 0 && c>= 0 && c < 20){
            return true;
        }
        else{
            return false;
        }
    }           
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(row-1, col-1) == true && bombs.contains(buttons[row-1][col-1])){
            numBombs ++;
        }
        if(isValid(row-1, col) == true && bombs.contains(buttons[row-1][col])){
            numBombs ++;
        }
        if(isValid(row, col-1) == true && bombs.contains(buttons[row][col-1])){
            numBombs ++;
        }
        if(isValid(row+1, col) == true && bombs.contains(buttons[row+1][col])){
            numBombs ++;
        }
        if(isValid(row+1, col+1) == true && bombs.contains(buttons[row+1][col+1])){
            numBombs ++;
        }
        if(isValid(row, col+1) == true && bombs.contains(buttons[row][col+1])){
            numBombs ++;
        }
        if(isValid(row-1, col+1) == true && bombs.contains(buttons[row-1][col+1])){
            numBombs ++;
        }
        if(isValid(row+1, col-1) == true && bombs.contains(buttons[row+1][col-1])){
            numBombs ++;
        }
        return numBombs;
    }
}



