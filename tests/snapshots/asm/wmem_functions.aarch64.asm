
wmem_functions.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x80]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	sub	x20, x29, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldrb	w10, [x0, #0x10]
               	strb	w10, [x20, #0x10]
               	ldrb	w10, [x0, #0x11]
               	strb	w10, [x20, #0x11]
               	ldrb	w10, [x0, #0x12]
               	strb	w10, [x20, #0x12]
               	ldrb	w10, [x0, #0x13]
               	strb	w10, [x20, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	mov	x1, #0x1e               // =30
               	mov	x21, #0x5               // =5
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	add	x1, x20, #0x8
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x1, #0x63               // =99
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x21, x29, #0x18
               	mov	x22, #0x5               // =5
               	mov	x0, x21
               	mov	x2, x22
               	mov	x1, x20
               	bl	<addr>
               	sub	x1, x29, #0x30
               	mov	x0, x21
               	mov	x2, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x1, #0x7                // =7
               	mov	x22, #0x3               // =3
               	mov	x0, x21
               	mov	x2, x22
               	bl	<addr>
               	ldr	w0, [x21]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	mov	x20, #0x1               // =1
               	cbnz	x0, <addr>
               	ldr	w0, [x21, #0x4]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x18
               	ldr	w0, [x0, #0x8]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x18
               	ldr	w0, [x0, #0xc]
               	mov	x17, #0x28              // =40
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x21, x29, #0x18
               	add	x0, x21, #0x4
               	mov	x1, x21
               	mov	x2, x22
               	bl	<addr>
               	ldr	w0, [x21, #0x4]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	ldr	w0, [x21, #0x8]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x20, ne
               	cbnz	x20, <addr>
               	ldr	w0, [x21, #0xc]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
               	mov	x0, x20
               	b	<addr>
