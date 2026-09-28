
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
               	mov	x9, #0x64               // =100
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	mov	x11, #0x5               // =5
               	mov	x10, x9
               	casal	x10, x11, [x8]
               	cmp	x10, #0x64
               	cset	x11, eq
               	cbz	x11, <addr>
               	add	x10, x0, x1
               	ldaddal	x10, x12, [x8]
               	cbz	x11, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	cmp	x9, #0x9
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	x12, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldar	x8, [x8]
               	add	x0, x0, #0x9
               	add	x0, x0, x1
               	cmp	x8, x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	add	x0, x10, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x7
               	ret
               	mov	x9, x10
               	b	<addr>

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
               	ldp	x29, x30, [sp], #0x10
               	ret
