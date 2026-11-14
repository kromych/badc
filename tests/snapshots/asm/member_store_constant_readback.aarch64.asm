
member_store_constant_readback.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x3, #0x20               // =32
               	mov	x1, #0x8080             // =32896
               	movk	x1, #0x8000, lsl #16
               	mov	x4, #0x8000             // =32768
               	str	w1, [x0]
               	strh	w4, [x0, #0x4]
               	mov	x1, #-0x7fffffff80000000 // =-9223372034707292160
               	str	x1, [x0, #0x8]
               	mov	x1, #-0x1               // =-1
               	str	x1, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	str	x0, [x1, #0x40]
               	mov	x4, #0x905              // =2309
               	strh	w4, [x0]
               	ldr	x1, [x1, #0x40]
               	mov	x4, #0x7                // =7
               	strb	w4, [x1]
               	adrp	x1, <page>
               	ldrsw	x4, [x1, #0x48]
               	add	x4, x4, #0x1
               	str	w4, [x1, #0x48]
               	ldrb	w0, [x0]
               	cmp	w0, #0x7
               	csel	x0, x3, x2, ne
               	adrp	x1, <page>
               	mov	x2, #0x6                // =6
               	strb	w2, [x1, #0x3a]
               	ldrb	w1, [x1, #0x3a]
               	orr	x2, x0, #0x40
               	cmp	w1, #0x6
               	csel	x0, x2, x0, ne
               	ret
