
alloca_alignment.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x0, #0x1                // =1
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x3, sp
               	sub	x3, x3, x17
               	mov	sp, x3
               	mov	x0, #0x7                // =7
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	mov	x1, #0x21               // =33
               	add	x17, x1, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	mov	sp, x1
               	mov	x2, #0x64               // =100
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	mov	sp, x2
               	mov	x17, #0xf               // =15
               	and	x4, x3, x17
               	mov	x17, #0xf               // =15
               	and	x5, x0, x17
               	orr	x4, x4, x5
               	mov	x17, #0xf               // =15
               	and	x5, x1, x17
               	orr	x4, x4, x5
               	mov	x17, #0xf               // =15
               	and	x5, x2, x17
               	orr	x4, x4, x5
               	cbz	x4, <addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x4, #0x0                // =0
               	mov	x5, #0xb                // =11
               	strb	w5, [x3]
               	mov	x5, #0x16               // =22
               	strb	w5, [x0, #0x6]
               	mov	x5, #0x21               // =33
               	strb	w5, [x1, #0x20]
               	mov	x5, #0x2c               // =44
               	strb	w5, [x2, #0x63]
               	ldrb	w3, [x3]
               	mov	x17, #0xb               // =11
               	eor	x3, x3, x17
               	mov	w3, w3
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w0, [x0, #0x6]
               	mov	x17, #0x16              // =22
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x4, ne
               	mov	x0, #0x0                // =0
               	cbz	x4, <addr>
               	ldrb	w0, [x1, #0x20]
               	mov	x17, #0x21              // =33
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	ldrb	w0, [x2, #0x63]
               	mov	x17, #0x2c              // =44
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
