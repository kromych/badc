
logical_op_normalize.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x1, #0x0                // =0
               	sxtw	x1, w1
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	cmp	x0, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	mov	x1, #0x0                // =0
               	sub	x1, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x10
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x1, #0x0                // =0
               	sxtw	x1, w1
               	ldrsw	x1, [x2, x1, lsl #2]
               	cmp	x1, #0x14
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	mov	x2, #0x0                // =0
               	add	x1, x1, #0x0
               	ldrsw	x1, [x1]
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x0                // =0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
