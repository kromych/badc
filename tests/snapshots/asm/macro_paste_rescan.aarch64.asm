
macro_paste_rescan.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0x3               // =3
               	cmp	x15, #0x3
               	b.eq	0x40024c <.text+0x2c>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x14, #0x3               // =3
               	cmp	x14, #0x3
               	b.eq	0x400264 <.text+0x44>
               	mov	x14, #0xc               // =12
               	mov	x0, x14
               	ret
               	mov	x0, #0x32               // =50
               	sxtw	x0, w0
               	cmp	x0, #0x32
               	b.eq	0x40027c <.text+0x5c>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x14, #0x11              // =17
               	sxtw	x14, w14
               	cmp	x14, #0x11
               	b.eq	0x400298 <.text+0x78>
               	mov	x14, #0xe               // =14
               	mov	x0, x14
               	ret
               	mov	x0, #0x3                // =3
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	0x4002b0 <.text+0x90>
               	mov	x0, #0xf                // =15
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ret
