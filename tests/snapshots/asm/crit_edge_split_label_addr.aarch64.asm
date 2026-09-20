
crit_edge_split_label_addr.aarch64:	file format elf64-littleaarch64

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

<probe>:
               	mov	x2, x0
               	mov	x0, #0xa                // =10
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x3, [x3]
               	cbz	x3, <addr>
               	adr	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	mov	x0, #-0x1               // =-1
               	ret
               	and	x2, x2, #0xf
               	mov	x17, #0x5               // =5
               	eor	x2, x2, x17
               	cbnz	w2, <addr>
               	tbz	w1, #0x0, <addr>
               	mov	x0, #0xb                // =11
               	cbnz	w2, <addr>
               	tbz	w1, #0x1, <addr>
               	add	x0, x0, #0x2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	mov	x1, #0x3                // =3
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	cmp	w0, #0xd
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	mov	x1, #0x2                // =2
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	cmp	w0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	mov	x0, #0x5                // =5
               	mov	x1, #0x3                // =3
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
