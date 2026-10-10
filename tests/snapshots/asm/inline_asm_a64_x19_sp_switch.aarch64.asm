
inline_asm_a64_x19_sp_switch.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x230
               	mov	x0, #0x5                // =5
               	sub	x17, x29, #0x218
               	str	x0, [x17]
               	mov	x0, #0xa                // =10
               	sub	x17, x29, #0x210
               	str	x0, [x17]
               	mov	x0, #0xf                // =15
               	sub	x17, x29, #0x208
               	str	x0, [x17]
               	mov	x0, #0x1                // =1
               	sub	x17, x29, #0x200
               	strb	w0, [x17]
               	sub	x16, x29, #0x230
               	str	x19, [x16]
               	mov	x19, sp
               	sub	sp, sp, #0x40
               	mov	sp, x19
               	mov	x19, #0x40              // =64
               	sub	x19, x29, #0x230
               	ldr	x19, [x19]
               	sub	x16, x29, #0x218
               	ldr	x0, [x16]
               	sub	x16, x29, #0x210
               	ldr	x1, [x16]
               	sub	x16, x29, #0x208
               	ldr	x2, [x16]
               	add	x1, x1, x2
               	add	x0, x0, x1
               	sub	x17, x29, #0x218
               	str	x0, [x17]
               	sub	x16, x29, #0x210
               	ldr	x0, [x16]
               	sub	x16, x29, #0x218
               	ldr	x1, [x16]
               	add	x0, x0, x1
               	sub	x17, x29, #0x210
               	str	x0, [x17]
               	sub	x16, x29, #0x208
               	ldr	x0, [x16]
               	sub	x16, x29, #0x210
               	ldr	x1, [x16]
               	add	x0, x0, x1
               	sub	x17, x29, #0x208
               	str	x0, [x17]
               	sub	x16, x29, #0x218
               	ldr	x0, [x16]
               	sub	x16, x29, #0x210
               	ldr	x1, [x16]
               	add	x0, x0, x1
               	sub	x16, x29, #0x208
               	ldr	x1, [x16]
               	add	x0, x0, x1
               	sub	x16, x29, #0x200
               	ldrb	w1, [x16]
               	add	x0, x0, x1
               	cmp	x0, #0x7e
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	sub	sp, x29, #0x230
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
