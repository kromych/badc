
ptr_diff_plus_ptr.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x80
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x30
               	sub	x0, x29, #0x30
               	sub	x2, x29, #0x30
               	add	x2, x2, #0x20
               	sub	x3, x2, x1
               	asr	x4, x3, #63
               	lsr	x4, x4, #60
               	add	x3, x3, x4
               	asr	x3, x3, #4
               	lsl	x3, x3, #4
               	add	x3, x3, x0
               	sub	x4, x29, #0x30
               	add	x4, x4, #0x20
               	cmp	x3, x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x2, x1
               	asr	x2, x1, #63
               	lsr	x2, x2, #60
               	add	x1, x1, x2
               	asr	x1, x1, #4
               	lsl	x1, x1, #4
               	add	x2, x0, #0x10
               	add	x1, x1, x2
               	sub	x2, x29, #0x30
               	add	x2, x2, #0x30
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x20
               	sub	x1, x29, #0x30
               	add	x1, x1, #0x20
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
