// <wingdi.h>'s drawing families render into a 32-bit top-down DIB section
// selected into a memory DC, with no window: pens and lines, brushes and
// filled shapes, clipping regions, text, pixels, blits and DIB transfers,
// gdi32's gradient fill, and msimg32's AlphaBlend and GradientFill. Each
// family is checked at a pixel it must have set or kept.

#ifdef _WIN32
#include <windows.h>
#include <wingdi.h>

#define W 64
#define H 64

static DWORD *bits;

static DWORD px(int x, int y) {
    GdiFlush();
    return bits[y * W + x] & 0xffffff;
}

// A DIB pixel holds blue in its low byte; a COLORREF holds red there.
static DWORD dib(COLORREF c) {
    return (GetRValue(c) << 16) | (GetGValue(c) << 8) | GetBValue(c);
}

static HBITMAP dib_section(HDC dc, void **out) {
    BITMAPINFO bi = {0};
    bi.bmiHeader.biSize = sizeof bi.bmiHeader;
    bi.bmiHeader.biWidth = W;
    bi.bmiHeader.biHeight = -H;
    bi.bmiHeader.biPlanes = 1;
    bi.bmiHeader.biBitCount = 32;
    bi.bmiHeader.biCompression = BI_RGB;
    return CreateDIBSection(dc, &bi, DIB_RGB_COLORS, out, NULL, 0);
}

int main(void) {
    const COLORREF white = RGB(255, 255, 255), red = RGB(255, 0, 0), green = RGB(0, 128, 0);
    const COLORREF blue = RGB(0, 0, 255);
    HDC dc = CreateCompatibleDC(NULL), src;
    HBITMAP bmp, src_bmp, old;
    HPEN pen;
    HFONT font;
    BITMAP info;
    TEXTMETRICW tm;
    LOGBRUSH lb = {BS_SOLID, 0, 0};
    void *src_bits;
    int x, y, inked = 0;
    if (!dc || !(bmp = dib_section(dc, (void **)&bits)))
        return 1;
    old = SelectObject(dc, bmp);
    if (GetObject(bmp, sizeof info, &info) != sizeof info || info.bmWidth != W ||
        info.bmBitsPixel != 32)
        return 2;

    // Brushes: the DC brush fills the whole surface.
    SelectObject(dc, GetStockObject(DC_BRUSH));
    SetDCBrushColor(dc, white);
    if (!PatBlt(dc, 0, 0, W, H, PATCOPY) || px(10, 10) != dib(white))
        return 3;

    // Pens and lines.
    pen = CreatePen(PS_SOLID, 1, red);
    SelectObject(dc, pen);
    MoveToEx(dc, 0, 5, NULL);
    LineTo(dc, W, 5);
    if (px(30, 5) != dib(red) || px(30, 6) != dib(white))
        return 4;
    SelectObject(dc, GetStockObject(DC_PEN));
    SetDCPenColor(dc, blue);
    POINT tri[3] = {{40, 40}, {60, 40}, {50, 60}};
    POINT line[2] = {{0, 62}, {W, 62}};
    Polyline(dc, line, 2);
    if (px(20, 62) != dib(blue))
        return 5;

    // Filled shapes take the DC brush inside the DC pen.
    SetDCBrushColor(dc, green);
    Rectangle(dc, 10, 10, 30, 30);
    if (px(20, 20) != dib(green) || px(10, 20) != dib(blue))
        return 6;
    SetDCBrushColor(dc, red);
    Ellipse(dc, 32, 10, 52, 30);
    RoundRect(dc, 10, 32, 30, 38, 4, 4);
    Polygon(dc, tri, 3);
    if (px(42, 20) != dib(red) || px(20, 35) != dib(red) || px(50, 45) != dib(red))
        return 7;

    // Clipping: a fill outside the clip rectangle leaves the pixel alone.
    IntersectClipRect(dc, 0, 0, 8, 8);
    SetDCBrushColor(dc, blue);
    PatBlt(dc, 0, 0, W, H, PATCOPY);
    if (px(2, 2) != dib(blue) || px(20, 20) != dib(green))
        return 8;
    SelectClipRgn(dc, NULL);

    // Pixels.
    if (SetPixel(dc, 63, 0, green) == (COLORREF)-1 || GetPixel(dc, 63, 0) != green)
        return 9;

    // Text: a transparent run in the text colour inks pixels of its box.
    font = CreateFontA(16, 0, 0, 0, FW_BOLD, 0, 0, 0, ANSI_CHARSET, OUT_DEFAULT_PRECIS,
                       CLIP_DEFAULT_PRECIS, NONANTIALIASED_QUALITY, DEFAULT_PITCH, "Arial");
    if (!font)
        return 10;
    SelectObject(dc, font);
    if (!GetTextMetricsW(dc, &tm) || tm.tmHeight <= 0)
        return 11;
    SetDCBrushColor(dc, white);
    PatBlt(dc, 32, 32, W - 32, tm.tmHeight, PATCOPY);
    SetBkMode(dc, TRANSPARENT);
    SetTextColor(dc, blue);
    if (!ExtTextOutW(dc, 34, 32, 0, NULL, L"WW", 2, NULL))
        return 12;
    for (y = 32; y < 32 + tm.tmHeight && y < H; y++)
        for (x = 34; x < W; x++)
            inked |= px(x, y) == dib(blue);
    if (!inked)
        return 13;

    // Blits and DIB transfers from a second DC.
    src = CreateCompatibleDC(dc);
    if (!(src_bmp = dib_section(src, &src_bits)))
        return 14;
    SelectObject(src, src_bmp);
    for (x = 0; x < W * H; x++)
        ((DWORD *)src_bits)[x] = 0x00ff00ff;
    GdiFlush();
    BitBlt(dc, 0, 40, 4, 4, src, 0, 0, SRCCOPY);
    StretchBlt(dc, 4, 40, 8, 8, src, 0, 0, 2, 2, SRCCOPY);
    if (px(1, 41) != 0xff00ff || px(10, 46) != 0xff00ff)
        return 15;
    {
        BITMAPINFO bi = {0};
        DWORD row[W];
        DWORD *spare_bits;
        HBITMAP spare = dib_section(dc, (void **)&spare_bits);
        for (x = 0; x < W; x++)
            row[x] = 0x00123456;
        bi.bmiHeader.biSize = sizeof bi.bmiHeader;
        bi.bmiHeader.biWidth = W;
        bi.bmiHeader.biHeight = 1;
        bi.bmiHeader.biPlanes = 1;
        bi.bmiHeader.biBitCount = 32;
        bi.bmiHeader.biCompression = BI_RGB;
        if (SetDIBitsToDevice(dc, 0, 2, W, 1, 0, 0, 0, 1, row, &bi, DIB_RGB_COLORS) != 1 ||
            px(5, 2) != 0x123456)
            return 16;
        // SetDIBits writes a bitmap no DC has selected; its scan 0 is the
        // first row in memory of the top-down section.
        if (!spare || SetDIBits(dc, spare, 0, 1, row, &bi, DIB_RGB_COLORS) != 1)
            return 17;
        GdiFlush();
        if ((spare_bits[7] & 0xffffff) != 0x123456)
            return 18;
        DeleteObject(spare);
    }

    // Gradients: gdi32's and msimg32's fill the rectangle between the two
    // vertex colours.
    {
        TRIVERTEX v[2] = {{0, 48, 0x0000, 0x0000, 0x0000, 0}, {16, 50, 0xff00, 0xff00, 0xff00, 0}};
        GRADIENT_RECT r = {0, 1};
        if (!GdiGradientFill(dc, v, 2, &r, 1, GRADIENT_FILL_RECT_H))
            return 19;
        DWORD left = px(0, 49), right = px(15, 49);
        if ((left & 0xff) > 0x20 || (right & 0xff) < 0xd0)
            return 20;
        v[0].y = 50;
        v[1].y = 52;
        if (!GradientFill(dc, v, 2, &r, 1, GRADIENT_FILL_RECT_V) || (px(15, 51) & 0xff) < 0x60)
            return 21;
    }

    // AlphaBlend: a half-opaque copy of the magenta source over white.
    {
        BLENDFUNCTION bf = {AC_SRC_OVER, 0, 128, 0};
        SetDCBrushColor(dc, white);
        PatBlt(dc, 48, 48, 8, 8, PATCOPY);
        if (!AlphaBlend(dc, 48, 48, 8, 8, src, 0, 0, 8, 8, bf))
            return 22;
        DWORD p = px(50, 50);
        if ((p & 0xff) < 0xf0 || ((p >> 8) & 0xff) < 0x70 || ((p >> 8) & 0xff) > 0x90)
            return 23;
    }

    // A geometric pen made from a LOGBRUSH.
    lb.lbColor = green;
    DeleteObject(SelectObject(dc, ExtCreatePen(PS_GEOMETRIC | PS_SOLID, 3, &lb, 0, NULL)));
    MoveToEx(dc, 0, 58, NULL);
    LineTo(dc, 20, 58);
    if (px(10, 58) != dib(green))
        return 24;

    SelectObject(dc, old);
    DeleteObject(font);
    DeleteDC(src);
    DeleteObject(src_bmp);
    DeleteObject(bmp);
    DeleteDC(dc);
    return 0;
}
#else
int main(void) { return 0; }
#endif
