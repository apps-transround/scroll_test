const htmlData = """
<h3>Render paint measurement and benchmarking experiment - Live intro</h3>
  <p>This experiment is related to issue  </p>
  
  <p>- It runs on a fork of the framework with some experimental paint event logging and in-place indicators added.</p> 
  <p>- The demo app is a normal Flutter app with standard widgets.</p>
  <p>- For convenience, a custom widget with render object was created that can disable repaint measurements and indicators for its child tree.</p>
  <p>- The UI is just an experiment.</p>
  

      <h3>Inline Styles:</h3>
      <p>The should be <span style='color: blue;'>BLUE style='color: blue;'</span></p>
      <p>The should be <span style='color: red;'>RED style='color: red;'</span></p>
      <p>The should be <span style='color: rgba(0, 0, 0, 0.10);'>BLACK with 10% alpha style='color: rgba(0, 0, 0, 0.10);</span></p>
      <h3>The should be <span style='background-color: teal; color: rgb(0, 97, 0);'>GREEN style='color: rgb(0, 97, 0)
      ;</span></h3>
      <h3>The should be <span style='background-color: black; color: Aquamarine;'>GREEN style='color: rgb(0, 97, 0);
      </span></h3>
 />
""";
