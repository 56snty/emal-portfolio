import './globals.css'

export const metadata = {
  title: 'EMAL | TITAN',
  description: 'Award Winning Portfolio',
}

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
