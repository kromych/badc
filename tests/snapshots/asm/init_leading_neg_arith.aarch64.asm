
init_leading_neg_arith.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x1, [x0, #0x8]
               	mov	x17, #-0x4650           // =-18000
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x1, [x0, #0x18]
               	mov	x17, #-0x5460           // =-21600
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x1, [x0, #0x28]
               	mov	x17, #-0x6234           // =-25140
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x0, [x0, #0x38]
               	mov	x17, #-0x9              // =-9
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
