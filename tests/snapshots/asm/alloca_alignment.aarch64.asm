
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
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x7                // =7
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0x21               // =33
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0x64               // =100
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	ldur	x1, [x29, #-0x10]
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	orr	x0, x0, x1
               	ldur	x1, [x29, #-0x18]
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	orr	x0, x0, x1
               	ldur	x1, [x29, #-0x20]
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x1, #0x0                // =0
               	mov	x2, #0xb                // =11
               	strb	w2, [x0]
               	ldur	x0, [x29, #-0x10]
               	mov	x2, #0x16               // =22
               	strb	w2, [x0, #0x6]
               	ldur	x0, [x29, #-0x18]
               	mov	x2, #0x21               // =33
               	strb	w2, [x0, #0x20]
               	ldur	x0, [x29, #-0x20]
               	mov	x2, #0x2c               // =44
               	strb	w2, [x0, #0x63]
               	ldur	x0, [x29, #-0x8]
               	ldrb	w0, [x0]
               	mov	x17, #0xb               // =11
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	stur	x1, [x29, #-0x48]
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0x10]
               	ldrb	w0, [x0, #0x6]
               	mov	x17, #0x16              // =22
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x40]
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0x18]
               	ldrb	w0, [x0, #0x20]
               	mov	x17, #0x21              // =33
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x40]
               	stur	x0, [x29, #-0x38]
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0x20]
               	ldrb	w0, [x0, #0x63]
               	mov	x17, #0x2c              // =44
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	stur	x0, [x29, #-0x38]
               	ldur	x0, [x29, #-0x38]
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x50]
               	ldur	x0, [x29, #-0x50]
               	sxtw	x0, w0
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x50]
               	b	<addr>
