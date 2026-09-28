
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
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x62               // =98
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x7a               // =122
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x6
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x6
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x61               // =97
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x61               // =97
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x161              // =353
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0xff               // =255
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x71               // =113
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0x61               // =97
               	strb	w1, [x0]
               	strb	wzr, [x0, #0x1]
               	mov	x3, #0x62               // =98
               	strb	w3, [x0, #0x2]
               	strb	wzr, [x0, #0x3]
               	strb	w1, [x0, #0x4]
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x8
               	add	x2, x0, #0x4
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x8
               	add	x2, x0, #0x3
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x7a               // =122
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0x61               // =97
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0x61               // =97
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	sub	x1, x29, #0x8
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0xff               // =255
               	mov	x2, #0x2                // =2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x7878787878787878 // =8680820740569200760
               	str	x1, [x0]
               	add	x0, x0, #0x2
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	sub	x0, x29, #0x10
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x78
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x1]
               	eor	x1, x1, #0x78
               	cbz	w1, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	ldrb	w1, [x0, #0x2]
               	cbz	w1, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	ldrb	w1, [x0, #0x3]
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x4]
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x5]
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x6]
               	eor	x1, x1, #0x78
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x7]
               	eor	x1, x1, #0x78
               	cbz	w1, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x79               // =121
               	strb	w2, [x0]
               	bl	<addr>
               	ldurb	w0, [x29, #-0x10]
               	mov	x17, #0x79              // =121
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x3                // =3
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	cbz	x20, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, #0x64               // =100
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	cbz	x20, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	ldrb	w1, [x0]
               	cbz	w1, <addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
