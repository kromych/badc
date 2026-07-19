
alloca_arena_in_bounds.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x2, #0x1f40             // =8000
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x10]
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x8]
               	ldursw	x2, [x29, #-0x18]
               	add	x1, x1, x2
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x18]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x18]
               	ldursw	x0, [x29, #-0x18]
               	mov	x17, #0x1f40            // =8000
               	cmp	x0, x17
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x10]
               	mov	x17, #0x5dc0            // =24000
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x30]
               	ldur	x0, [x29, #-0x30]
               	sxtw	x0, w0
               	sub	sp, x29, #0x40
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	ret
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x30]
               	b	<addr>
