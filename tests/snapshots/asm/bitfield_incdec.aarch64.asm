
bitfield_incdec.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	mov	x1, #0x1                // =1
               	movk	x1, #0x8000, lsl #16
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, #0x2                // =2
               	movk	x2, #0x8000, lsl #16
               	str	w2, [x0]
               	mov	x3, #0x3                // =3
               	movk	x3, #0x8000, lsl #16
               	str	w3, [x0]
               	str	w2, [x0]
               	str	w3, [x0]
               	mov	x3, x1
               	str	w2, [x0]
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
