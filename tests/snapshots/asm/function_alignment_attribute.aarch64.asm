
function_alignment_attribute.aarch64:	file format elf64-littleaarch64

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
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<first>:
               	mov	x0, #0x2                // =2
               	ret
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop

<f64>:
               	mov	x0, #0x1                // =1
               	ret
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop

<s128>:
               	add	x0, x0, #0x1
               	ret
               	nop
               	nop
               	nop
               	nop
               	nop
               	nop

<h>:
               	mov	x0, #0x3                // =3
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x10]
               	and	x0, x0, #0x3f
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x18]
               	and	x0, x0, #0x7f
               	cbnz	w0, <addr>
               	ldur	x0, [x29, #-0x8]
               	and	x0, x0, #0x1f
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldur	x1, [x29, #-0x18]
               	blr	x1
               	str	x0, [sp, #0x8]
               	ldur	x0, [x29, #-0x10]
               	blr	x0
               	ldr	x16, [sp, #0x8]
               	add	x16, x16, x0
               	str	x16, [sp, #0x8]
               	ldur	x0, [x29, #-0x8]
               	blr	x0
               	ldr	x16, [sp, #0x8]
               	add	x0, x16, x0
               	add	x0, x0, #0x2
               	mov	x1, #0x0                // =0
               	mov	x2, #0x2                // =2
               	cmp	w0, #0x8
               	csel	x0, x1, x2, eq
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
