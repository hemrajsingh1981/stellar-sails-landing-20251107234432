import type { Metadata } from "next";

// Global styles are imported via the link tag in the head for better control and adherence to doctrine.
// import "./globals.css";

export const metadata: Metadata = {
  title: "Stellar Sails",
  description: "Experience the cosmos with Stellar Sails, your premier partner in luxury space travel.",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <head>
        <meta charSet="utf-8" />
        <link rel="icon" href="/images/logo.svg" sizes="any" />
        {/* Linking global CSS with an absolute path as per doctrine */}
        <link rel="stylesheet" href="/css/globals.css" />
      </head>
      <body>
        {children}
      </body>
    </html>
  );
}