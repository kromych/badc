
alloca_arena_in_bounds.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2, lsl #12   // =0x2000
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	sub	x16, x29, #0x28
               	str	x16, [x16]
               	mov	x2, #0x1f40             // =8000
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	sub	x16, x29, #0x28
               	ldr	x0, [x16]
               	sub	x0, x0, x17
               	sub	x17, x16, #0x2, lsl #12 // =0x2000
               	cmp	x0, x17
               	b.hs	<addr>
               	brk	#0x1
               	str	x0, [x16]
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
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x30
               	str	x0, [x17]
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	sub	x16, x16, #0x30
               	ldr	x0, [x16]
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	sub	x17, x17, #0x30
               	str	x0, [x17]
               	b	<addr>
