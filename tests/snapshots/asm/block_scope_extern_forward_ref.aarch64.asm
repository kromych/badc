
block_scope_extern_forward_ref.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	sxtw	x1, w1
               	add	x1, x1, #0x4
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x1, [x0]
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
