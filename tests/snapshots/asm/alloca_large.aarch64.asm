
alloca_large.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x0, #0x100000           // =1048576
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	ldur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x8]
               	sub	x1, x1, #0x1
               	add	x0, x0, x1
               	mov	x1, #0x2                // =2
               	strb	w1, [x0]
               	mov	x0, #0x1000             // =4096
               	stur	x0, [x29, #-0x18]
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x18]
               	add	x0, x0, x1
               	mov	x1, #0x3                // =3
               	strb	w1, [x0]
               	ldur	x0, [x29, #-0x18]
               	mov	x17, #0x1000            // =4096
               	add	x0, x0, x17
               	stur	x0, [x29, #-0x18]
               	ldur	x0, [x29, #-0x18]
               	ldur	x1, [x29, #-0x8]
               	sub	x1, x1, #0x1
               	cmp	x0, x1
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldrb	w1, [x0]
               	ldur	x2, [x29, #-0x8]
               	sub	x2, x2, #0x1
               	add	x0, x0, x2
               	ldrb	w0, [x0]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	stur	x0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	sxtw	x0, w0
               	sub	sp, x29, #0x40
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	ret
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x28]
               	b	<addr>
