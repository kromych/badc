
fts_and_fd_set_headers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x430              // =1072
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x100]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0xf0]
               	add	x29, sp, #0xf0
               	sub	x0, x29, #0x80
               	mov	x2, #0x0                // =0
               	strb	w2, [x0]
               	sub	x0, x29, #0x90
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x90
               	str	x1, [x0]
               	sub	x0, x29, #0xa0
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xa0
               	mov	x1, #0x14               // =20
               	bl	<addr>
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xf0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xf0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	ldrh	w1, [x0, #0x5e]
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xf0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	ldr	x1, [x0, #0x30]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x30]
               	ldrb	w1, [x1]
               	mov	x17, #0x2e              // =46
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xf0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	ldrh	w21, [x0, #0x40]
               	ldr	x0, [x0, #0x30]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	cmp	x21, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xf0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xf0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	b	<addr>
