
atomic_operand_in_working_regs.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	cmp	x11, #0x0
               	csel	x10, x9, x10, ne
               	add	x9, x0, x1
               	ldaddal	x9, x12, [x8]
               	cbz	x11, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	cmp	x10, #0x9
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
               	add	x0, x9, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x7
               	ret

<main>:
               	mov	x0, #0x64               // =100
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #0x5                // =5
               	mov	x2, x0
               	casal	x2, x3, [x1]
               	cmp	x2, #0x64
               	cset	x3, eq
               	cmp	x3, #0x0
               	csel	x2, x0, x2, ne
               	mov	x0, #0x3                // =3
               	ldaddal	x0, x4, [x1]
               	cbz	x3, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	cmp	x2, #0x9
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	cmp	x4, #0x9
               	b.ne	<addr>
               	ldar	x0, [x1]
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
