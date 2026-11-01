
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
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x20               // =32
               	strb	w2, [x1, #0x1]
               	mov	x3, #0x80               // =128
               	mov	x4, #-0x80              // =-128
               	strb	w4, [x1]
               	strb	w3, [x1, #0x1]
               	mov	x3, #0x8000             // =32768
               	mov	x4, #-0x8000            // =-32768
               	strh	w4, [x1, #0x2]
               	strh	w3, [x1, #0x4]
               	mov	x3, #0x80000000         // =2147483648
               	mov	x4, #-0x80000000        // =-2147483648
               	str	w4, [x1, #0x8]
               	str	w3, [x1, #0xc]
               	mov	x3, #-0x1               // =-1
               	str	x3, [x1, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #0x1                // =1
               	strb	w3, [x1]
               	mov	x3, #0x2                // =2
               	strb	w3, [x1, #0x1]
               	mov	x3, #0x3                // =3
               	strb	w3, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x1, [x3]
               	mov	x4, #0x4                // =4
               	strb	w4, [x1]
               	mov	x5, #0x9                // =9
               	strb	w5, [x1]
               	strb	w4, [x1]
               	strb	w5, [x1, #0x1]
               	mov	x4, #0x5                // =5
               	strb	w4, [x1]
               	ldr	x3, [x3]
               	mov	x4, #0x7                // =7
               	strb	w4, [x3]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x4, [x3]
               	add	x4, x4, #0x1
               	str	w4, [x3]
               	ldrb	w1, [x1]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, x2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x6                // =6
               	strb	w2, [x1]
               	ldrb	w1, [x1]
               	cmp	w1, #0x6
               	b.eq	<addr>
               	orr	x0, x0, #0x40
               	ret
