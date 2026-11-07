
narrow_remainder_rebuilt.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	mov	x1, #-0x1               // =-1
               	str	w1, [x0, #0x40]
               	str	w1, [x0, #0x40]
               	str	w1, [x0, #0x40]
               	str	w1, [x0, #0x40]
               	str	w1, [x0, #0x40]
               	str	w1, [x0, #0x40]
               	str	w1, [x0, #0x40]
               	str	w1, [x0, #0x40]
               	mov	x0, #-0x1               // =-1
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x18]
               	udiv	w17, w0, w1
               	msub	w20, w17, w1, w0
               	adrp	x0, <page>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	ldrsw	x3, [x2, #0x38]
               	and	x3, x3, #0x4
               	and	x3, x20, x3
               	ldrsw	x3, [x1, x3, lsl #2]
               	str	w3, [x0, #0x30]
               	ldrsw	x3, [x2, #0x38]
               	and	x3, x3, #0x4
               	and	x3, x20, x3
               	ldrsw	x3, [x1, x3, lsl #2]
               	str	w3, [x0, #0x30]
               	ldrsw	x3, [x2, #0x38]
               	and	x3, x3, #0x4
               	and	x3, x20, x3
               	ldrsw	x3, [x1, x3, lsl #2]
               	str	w3, [x0, #0x30]
               	ldrsw	x3, [x2, #0x38]
               	and	x3, x3, #0x4
               	and	x3, x20, x3
               	ldrsw	x3, [x1, x3, lsl #2]
               	str	w3, [x0, #0x30]
               	ldrsw	x3, [x2, #0x38]
               	and	x3, x3, #0x4
               	and	x3, x20, x3
               	ldrsw	x3, [x1, x3, lsl #2]
               	str	w3, [x0, #0x30]
               	ldrsw	x2, [x2, #0x38]
               	and	x2, x2, #0x4
               	and	x2, x20, x2
               	ldrsw	x2, [x1, x2, lsl #2]
               	str	w2, [x0, #0x30]
               	adrp	x2, <page>
               	ldrsw	x3, [x2, #0x38]
               	and	x3, x3, #0x4
               	and	x3, x20, x3
               	ldrsw	x1, [x1, x3, lsl #2]
               	str	w1, [x0, #0x30]
               	adrp	x0, <page>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x2, #0x38]
               	and	x2, x2, #0x4
               	and	x2, x20, x2
               	ldrsw	x1, [x1, x2, lsl #2]
               	str	w1, [x0, #0x30]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	cmp	w20, #0x3
               	cset	x0, ne
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
