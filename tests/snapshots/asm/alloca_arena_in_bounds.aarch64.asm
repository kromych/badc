
alloca_arena_in_bounds.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x20, [sp, #-0x60]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x2, #0x1f40             // =8000
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x20, sp
               	sub	x20, x20, x17
               	mov	sp, x20
               	mov	x1, #0x3                // =3
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	add	x3, x20, x2
               	ldrb	w3, [x3]
               	add	x1, x1, x3
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	mov	x17, #0x1f40            // =8000
               	cmp	x2, x17
               	b.lt	<addr>
               	sxtw	x0, w1
               	mov	x17, #0x5dc0            // =24000
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
