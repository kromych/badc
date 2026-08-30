
string_gnu_ext.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x22, x23, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x1, #0x62               // =98
               	mov	x0, x20
               	bl	<addr>
               	add	x1, x20, #0x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x1, #0x7a               // =122
               	mov	x0, x20
               	bl	<addr>
               	add	x23, x20, #0x6
               	cmp	x0, x23
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, x23
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x23, #0x61              // =97
               	mov	x0, x21
               	mov	x1, x23
               	bl	<addr>
               	cmp	x0, x21
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, x21
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x1, #0x161              // =353
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x1, #0xff               // =255
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, x22
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x1, #0x71               // =113
               	mov	x0, x22
               	bl	<addr>
               	add	x1, x22, #0x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x21, x29, #0x8
               	mov	x0, #0x0                // =0
               	mov	x1, #0x61               // =97
               	strb	w1, [x21]
               	strb	w0, [x21, #0x1]
               	mov	x2, #0x62               // =98
               	strb	w2, [x21, #0x2]
               	strb	w0, [x21, #0x3]
               	strb	w1, [x21, #0x4]
               	mov	x2, #0x5                // =5
               	mov	x0, x21
               	bl	<addr>
               	add	x1, x21, #0x4
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x1, #0x0                // =0
               	mov	x23, #0x5               // =5
               	mov	x0, x21
               	mov	x2, x23
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x8
               	add	x2, x0, #0x3
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x1, #0x7a               // =122
               	mov	x2, x23
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x21, x29, #0x8
               	mov	x23, #0x61              // =97
               	mov	x2, #0x0                // =0
               	mov	x0, x21
               	mov	x1, x23
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x2, #0x3                // =3
               	mov	x0, x21
               	mov	x1, x23
               	bl	<addr>
               	sub	x1, x29, #0x8
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x1, #0xff               // =255
               	mov	x2, #0x2                // =2
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, x22
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x21, x29, #0x10
               	mov	x0, #0x7878             // =30840
               	movk	x0, #0x7878, lsl #16
               	movk	x0, #0x7878, lsl #32
               	movk	x0, #0x7878, lsl #48
               	str	x0, [x21]
               	add	x0, x21, #0x2
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	uxtb	w0, w0
               	ldrb	w0, [x21]
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	w1, w0
               	cmp	w1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	ldrb	w0, [x21, #0x1]
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	ldrb	w0, [x21, #0x2]
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	ldrb	w0, [x21, #0x3]
               	cbnz	x0, <addr>
               	sub	x21, x29, #0x10
               	ldrb	w0, [x21, #0x4]
               	cbnz	x0, <addr>
               	ldrb	w0, [x21, #0x5]
               	cbnz	x0, <addr>
               	ldrb	w0, [x21, #0x6]
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	w1, w0
               	cmp	w1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	ldrb	w0, [x21, #0x7]
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x22, #0x0               // =0
               	mov	x0, #0x79               // =121
               	strb	w0, [x21]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	uxtb	w0, w0
               	ldrb	w0, [x21]
               	mov	x17, #0x79              // =121
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x1, #0x3                // =3
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	cmp	x21, #0x0
               	cset	x0, eq
               	cbz	x21, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x21
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x1, #0x64               // =100
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	cmp	x21, #0x0
               	cset	x0, eq
               	cbz	x21, <addr>
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x21
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x0, <addr>
               	ldrb	w1, [x0]
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
