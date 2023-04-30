document.addEventListener('DOMContentLoaded', function () {
  // Add ASCII art to the terminal
  const asciiArt = `
                888      888      888                                          888 888
                888      888      888                                          888 888                            
                888      888                                                   888 888                                        
888d888 .d88b.  88888b.  88888b.  888  .d88b.  88888b.d88b.  888  888  .d88b.  888 888  .d88b.  888d888   .d8888b .d88b.  88888b.d88b.  
888P"  d88""88b 888 "88b 888 "88b 888 d8P  Y8b 888 "888 "88b 888  888 d8P  Y8b 888 888 d8P  Y8b 888P"    d88P"   d88""88b 888 "888 "88b 
888    888  888 888  888 888  888 888 88888888 888  888  888 888  888 88888888 888 888 88888888 888      888     888  888 888  888  888 
888    Y88..88P 888 d88P 888 d88P 888 Y8b.     888  888  888 Y88b 888 Y8b.     888 888 Y8b.     888  d8b Y88b.   Y88..88P 888  888  888 
888     "Y88P"  88888P"  88888P"  888  "Y8888  888  888  888  "Y88888  "Y8888  888 888  "Y8888  888  Y8P  "Y8888P "Y88P"  888  888  888 
                                                                                                                          
                                                                                                                          
                                                                                                                          
                      
  `;
  document.getElementById('ascii-art').innerHTML = asciiArt;

  // Rest of your JavaScript code...
});


document.addEventListener('DOMContentLoaded', function () {
  // Function to change the cursor color
  function changeCursorColor(cursor) {
    const colors = ['#00ff47', '#ff00b8', '#00b8ff', '#ff4700'];
    let colorIndex = 0;

    setInterval(() => {
      cursor.style.color = colors[colorIndex];
      colorIndex = (colorIndex + 1) % colors.length;
    }, 1000); // Match speed of blink
  }

// Get the current year
const currentYear = new Date().getFullYear();

// Blog page terminal typing
if (document.getElementById('terminal-blog')) {
  new Typed('#terminal-blog', {
    strings: [`<span class="white-text">PS C:\\users\\administrator\\> start blog.html</span><br><br>
    Access granted to blog.<br><br>
    <span class="white-text">PS C:\\robbiemuellercom\\blog.html></span>`],
    typeSpeed: 40,
    backSpeed: 20,
    loop: false,
    cursorChar: '_',
    contentType: 'html',
    onComplete: function () {
      const cursor = document.querySelector('.typed-cursor');
      cursor.style.animation = 'completed-blink 1s infinite';
    },
  });
}

// Gallery page terminal typing
if (document.getElementById('terminal-gallery')) {
  new Typed('#terminal-gallery', {
    strings: [`<span class="white-text">PS C:\\users\\administrator\\> start gallery.html</span><br><br>
    Access granted to gallery.<br><br>
    <span class="white-text">PS C:\\robbiemuellercom\\gallery.html></span>`],
    typeSpeed: 40,
    backSpeed: 20,
    loop: false,
    cursorChar: '_',
    contentType: 'html',
    onComplete: function () {
      const cursor = document.querySelector('.typed-cursor');
      cursor.style.animation = 'completed-blink 1s infinite';
    },
  });
}

if (document.getElementById('current-year')) {
  const currentYear = new Date().getFullYear();
  document.getElementById('current-year').textContent = currentYear;
}
})