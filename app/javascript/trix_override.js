window.addEventListener("trix-file-accept", function(event) {
  const acceptedTypes = ['image/jpeg', 'image/png']
  if (!acceptedTypes.includes(event.file.type)) {
    event.preventDefault()
    alert("不正な形式のファイルです。(jpeg,pngのみ対応)")
  }
  const maxFileSize = 2048 * 2048
  if (event.file.size > maxFileSize) {
    event.preventDefault()
    alert("最大ファイルサイズは2MBです。")
  }
})