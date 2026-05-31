
integer_suffixes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x15, #0x1               // =1
               	mov	x14, #0x2               // =2
               	mov	x13, #0x3               // =3
               	mov	x12, #0x4               // =4
               	mov	x11, #0x5               // =5
               	mov	x10, #0x6               // =6
               	mov	x9, #0x7                // =7
               	mov	x8, #0x8                // =8
               	mov	x7, #0x9                // =9
               	mov	x6, #0xa                // =10
               	mov	x5, #0xff               // =255
               	mov	x4, #0xcafe             // =51966
               	mov	x3, #0x1000             // =4096
               	movk	x3, #0xd4a5, lsl #16
               	movk	x3, #0xe8, lsl #32
               	mov	x2, #0x100000000        // =4294967296
               	sxtw	x1, w15
               	cmp	x1, #0x1
               	b.eq	0x4002a0 <.text+0x80>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w14
               	cmp	x15, #0x2
               	b.eq	0x4002c0 <.text+0xa0>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w13
               	cmp	x0, #0x3
               	b.eq	0x4002dc <.text+0xbc>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w12
               	cmp	x15, #0x4
               	b.eq	0x4002fc <.text+0xdc>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w11
               	cmp	x0, #0x5
               	b.eq	0x400318 <.text+0xf8>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w10
               	cmp	x15, #0x6
               	b.eq	0x400338 <.text+0x118>
               	mov	x15, #0x6               // =6
               	mov	x0, x15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w9
               	cmp	x0, #0x7
               	b.eq	0x400354 <.text+0x134>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w8
               	cmp	x15, #0x8
               	b.eq	0x400374 <.text+0x154>
               	mov	x15, #0x8               // =8
               	mov	x0, x15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w7
               	cmp	x0, #0x9
               	b.eq	0x400390 <.text+0x170>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w6
               	cmp	x15, #0xa
               	b.eq	0x4003b0 <.text+0x190>
               	mov	x15, #0xa               // =10
               	mov	x0, x15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w5
               	cmp	x0, #0xff
               	b.eq	0x4003cc <.text+0x1ac>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w4
               	mov	x17, #0xcafe            // =51966
               	cmp	x15, x17
               	b.eq	0x4003f0 <.text+0x1d0>
               	mov	x15, #0xc               // =12
               	mov	x0, x15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x1000            // =4096
               	movk	x17, #0xd4a5, lsl #16
               	movk	x17, #0xe8, lsl #32
               	cmp	x3, x17
               	b.eq	0x400418 <.text+0x1f8>
               	mov	x3, #0xd                // =13
               	mov	x0, x3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x2, x17
               	b.eq	0x400438 <.text+0x218>
               	mov	x2, #0xe                // =14
               	mov	x0, x2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	x2, x0, #0x7
               	sxtw	x0, w2
               	cmp	x0, #0xa
               	b.eq	0x40045c <.text+0x23c>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
