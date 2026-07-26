
store_to_load_forward.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	mov	x1, #0x15               // =21
               	str	x1, [x0]
               	add	x0, x1, x1
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	stur	x0, [x29, #-0x18]
               	sub	x0, x29, #0x18
               	mov	x1, #0x9                // =9
               	str	x1, [x0]
               	str	x1, [x0]
               	add	x2, x1, x1
               	add	x2, x2, #0x0
               	add	x0, x2, x1
               	cmp	x0, #0x1b
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
