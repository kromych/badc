
static_assert_in_struct.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	sub	x0, x29, #0x8
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	mov	x1, #0x2                // =2
               	str	w1, [x0, #0x4]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
               	b	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x8
               	ldrsw	x1, [x1]
               	sub	x2, x29, #0x8
               	ldrsw	x2, [x2, #0x4]
               	mov	x3, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
               	b	<addr>
