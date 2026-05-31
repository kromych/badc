
integer_suffixes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
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
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x14, w14
               	cmp	x14, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x13, w13
               	cmp	x13, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x12, w12
               	cmp	x12, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x11, w11
               	cmp	x11, #0x5
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x10, w10
               	cmp	x10, #0x6
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x9, w9
               	cmp	x9, #0x7
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x8, w8
               	cmp	x8, #0x8
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x7, w7
               	cmp	x7, #0x9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x6, w6
               	cmp	x6, #0xa
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x5, w5
               	cmp	x5, #0xff
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x4, w4
               	mov	x17, #0xcafe            // =51966
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x1000            // =4096
               	movk	x17, #0xd4a5, lsl #16
               	movk	x17, #0xe8, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x3                // =3
               	add	x2, x2, #0x7
               	sxtw	x2, w2
               	cmp	x2, #0xa
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
