
empty_struct_member.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x8
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	mov	x1, #0x7                // =7
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	mov	x1, #0x1111             // =4369
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x38
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x1111            // =4369
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	add	x0, x0, #0x8
               	sub	x1, x29, #0x38
               	add	x1, x1, #0x8
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	mov	x1, #0x2222             // =8738
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x38
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x1111            // =4369
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x38
               	ldr	x0, [x0, #0x10]
               	mov	x17, #0x2222            // =8738
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
