
returned_aggregate_read_past_its_lifetime_marker.aarch64:	file format elf64-littleaarch64

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

<k>:
               	sxth	x1, w1
               	sxtb	x2, w2
               	mov	x0, #0x3                // =3
               	adrp	x1, <page>
               	strb	wzr, [x1, #0x48]
               	ret

<main>:
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x10]
               	mov	x1, #0x3                // =3
               	adrp	x3, <page>
               	mov	x0, #0x0                // =0
               	strb	w0, [x3, #0x48]
               	str	x1, [x2]
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	cmp	x1, #0x3
               	mov	x17, #0x1               // =1
               	csel	x0, x0, x17, eq
               	ret
