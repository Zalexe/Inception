<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP Info</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #f4f4f4;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            border-bottom: 3px solid #4CAF50;
            padding-bottom: 10px;
        }
        .info {
            margin: 20px 0;
            padding: 15px;
            background: #e8f5e9;
            border-left: 4px solid #4CAF50;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>PHP-FPM is Working! ✅</h1>
        
        <div class="info">
            <p><strong>PHP Version:</strong> <?php echo phpversion(); ?></p>
            <p><strong>Server Time:</strong> <?php echo date('Y-m-d H:i:s'); ?></p>
            <p><strong>Server Software:</strong> <?php echo $_SERVER['SERVER_SOFTWARE'] ?? 'N/A'; ?></p>
        </div>

        <h2>Loaded Extensions:</h2>
        <ul>
            <?php foreach (get_loaded_extensions() as $ext): ?>
                <li><?php echo $ext; ?></li>
            <?php endforeach; ?>
        </ul>

        <hr>
        <p><em>For full PHP configuration, uncomment phpinfo() below:</em></p>
        <?php 
        // Uncomment the next line to see full PHP info
        // phpinfo(); 
        ?>
    </div>
</body>
</html>