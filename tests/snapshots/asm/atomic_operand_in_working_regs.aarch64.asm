
atomic_operand_in_working_regs.aarch64:	file format elf64-littleaarch64

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

<f>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x8, x2
               	mov	x10, x4
               	mov	x9, x3
               	mov	x2, #0x64               // =100
               	stur	x2, [x29, #-0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x8
               	mov	x4, #0x5                // =5
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x2
               	mov	x10, x3
               	mov	x11, x4
               	ldr	x12, [x10]
               	ldaxr	x16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxr	w17, x11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	str	x16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x4, x16
               	add	x3, x0, x1
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x2
               	mov	x10, x3
               	ldaxr	x16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, x11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x11, x16
               	sxtw	x4, w4
               	cbz	x4, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x4, [x29, #-0x8]
               	cmp	x4, #0x9
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x11, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x2]
               	add	x4, x0, #0x9
               	add	x4, x4, x1
               	cmp	x2, x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x3, x8
               	add	x0, x0, x9
               	add	x0, x0, x10
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	bl	<addr>
               	cmp	x0, #0x24
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w0
               	b	<addr>
