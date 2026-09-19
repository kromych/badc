
branch_fuse_short_circuit.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x3, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1]
               	mov	x17, #-0x1              // =-1
               	cmp	x2, x17
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	cbnz	x3, <addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2]
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	cmp	x1, #0x64
               	b.ls	<addr>
               	mov	x1, #0x2                // =2
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2]
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.ne	<addr>
               	cmp	x1, #0x64
               	b.ls	<addr>
               	mov	x1, #0x2                // =2
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	cmp	x1, #0x64
               	b.ls	<addr>
               	mov	x0, #0x2                // =2
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	cmp	x2, #0x64
               	b.ls	<addr>
               	mov	x1, #0x2                // =2
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
