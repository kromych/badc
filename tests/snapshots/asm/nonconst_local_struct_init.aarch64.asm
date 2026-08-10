
nonconst_local_struct_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x1, #0x2a               // =42
               	mov	x0, #0x63               // =99
               	mov	x2, #0x0                // =0
               	mov	x2, #0x0                // =0
               	mov	x2, #0x0                // =0
               	sub	x2, x29, #0x10
               	mov	x3, #0x0                // =0
               	str	x3, [x2]
               	str	w3, [x2, #0x8]
               	sub	x2, x29, #0x10
               	str	w1, [x2]
               	sub	x2, x29, #0x10
               	str	w0, [x2, #0x8]
               	mov	x2, #0x0                // =0
               	mov	x2, #0x0                // =0
               	sub	x2, x29, #0x20
               	mov	x3, #0x0                // =0
               	str	x3, [x2]
               	str	w3, [x2, #0x8]
               	sub	x2, x29, #0x20
               	str	w0, [x2, #0x8]
               	sub	x2, x29, #0x20
               	str	w1, [x2]
               	mov	x2, #0x0                // =0
               	mov	x2, #0x0                // =0
               	sub	x2, x29, #0x30
               	mov	x3, #0x0                // =0
               	str	x3, [x2]
               	str	w3, [x2, #0x8]
               	sub	x2, x29, #0x30
               	str	w1, [x2]
               	sub	x1, x29, #0x30
               	str	w0, [x1, #0x8]
               	mov	x1, #0x0                // =0
               	mov	x1, #0x0                // =0
               	sub	x1, x29, #0x40
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldrb	w10, [x2, #0x8]
               	strb	w10, [x1, #0x8]
               	ldrb	w10, [x2, #0x9]
               	strb	w10, [x1, #0x9]
               	ldrb	w10, [x2, #0xa]
               	strb	w10, [x1, #0xa]
               	ldrb	w10, [x2, #0xb]
               	strb	w10, [x1, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x50
               	mov	x2, #0x0                // =0
               	str	x2, [x1]
               	str	w2, [x1, #0x8]
               	sub	x1, x29, #0x50
               	str	w0, [x1, #0x4]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
