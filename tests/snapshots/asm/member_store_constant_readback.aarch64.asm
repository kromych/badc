
member_store_constant_readback.aarch64:	file format elf64-littleaarch64

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

<narrow_sign>:
               	mov	x2, #0x0                // =0
               	mov	x1, #0x80               // =128
               	mov	x3, #0xff80             // =65408
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	strb	w3, [x0]
               	strb	w1, [x0, #0x1]
               	mov	x1, x2
               	mov	x3, #0x8000             // =32768
               	mov	x4, #0x8000             // =32768
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	strh	w4, [x0, #0x2]
               	strh	w3, [x0, #0x4]
               	mov	x3, #0x80000000         // =2147483648
               	mov	x4, #0x80000000         // =2147483648
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	str	w4, [x0, #0x8]
               	str	w3, [x0, #0xc]
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	str	x3, [x0, #0x10]
               	mov	x0, x2
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, #0x0               // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x20               // =32
               	strb	w1, [x0, #0x1]
               	mov	x1, #0x1                // =1
               	mov	x1, x20
               	mov	x2, x20
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x20, #0x2               // =2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	mov	x2, #0x2                // =2
               	strb	w2, [x0, #0x1]
               	mov	x2, #0x3                // =3
               	strb	w2, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [x1]
               	mov	x1, #0x4                // =4
               	strb	w1, [x0]
               	mov	x2, #0x9                // =9
               	strb	w2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	strb	w1, [x0]
               	strb	w2, [x0, #0x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x5                // =5
               	strb	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x2, #0x7                // =7
               	strb	w2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	ldrb	w0, [x0]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x17, #0x20              // =32
               	orr	x20, x20, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x6                // =6
               	strb	w1, [x0]
               	ldrb	w0, [x0]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x17, #0x40              // =64
               	orr	x20, x20, x17
               	mov	x0, #0xc                // =12
               	mov	x1, x0
               	sxtw	x0, w20
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
