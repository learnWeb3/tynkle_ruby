var i = 0
var time = 8000
var images = []


images[0] = 'https://images.pexels.com/photos/3153198/pexels-photo-3153198.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
images[1] = 'https://images.pexels.com/photos/1476321/pexels-photo-1476321.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
images[2] = 'https://images.pexels.com/photos/920382/pexels-photo-920382.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
images[3] = 'https://images.pexels.com/photos/1388947/technology-telephone-mobile-smart-1388947.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
images[4] = 'https://images.pexels.com/photos/1543895/pexels-photo-1543895.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
images[5] = 'https://images.pexels.com/photos/313690/pexels-photo-313690.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'


setInterval(function() {
    document.querySelectorAll('.img-fluid')[0].src = images[i]

    if (i < images.length - 1) {
        i = i + 1
    } else { i = 0 }
}, time)