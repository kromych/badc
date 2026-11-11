
addr_null_compare_inline_param.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x30]
               	mov	x1, #0x5                // =5
               	stur	w1, [x29, #-0x8]
               	ldrsw	x1, [x0, #0x30]
               	add	x1, x1, #0x5
               	str	w1, [x0, #0x30]
               	mov	x0, x1
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	cmp	w0, #0x6
               	csel	x0, x1, x2, eq
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
