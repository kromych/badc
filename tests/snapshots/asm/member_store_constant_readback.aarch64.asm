
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
               	mov	x5, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x20               // =32
               	strb	w1, [x0, #0x1]
               	mov	x2, #0x80               // =128
               	mov	x3, #-0x80              // =-128
               	strb	w3, [x0]
               	strb	w2, [x0, #0x1]
               	mov	x2, #0x8000             // =32768
               	mov	x3, #-0x8000            // =-32768
               	strh	w3, [x0, #0x2]
               	strh	w2, [x0, #0x4]
               	mov	x2, #0x80000000         // =2147483648
               	mov	x3, #-0x80000000        // =-2147483648
               	str	w3, [x0, #0x8]
               	str	w2, [x0, #0xc]
               	mov	x2, #-0x1               // =-1
               	str	x2, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x1                // =1
               	strb	w2, [x0]
               	mov	x2, #0x2                // =2
               	strb	w2, [x0, #0x1]
               	mov	x2, #0x3                // =3
               	strb	w2, [x0]
               	adrp	x2, <page>
               	str	x0, [x2, #0x40]
               	mov	x3, #0x4                // =4
               	strb	w3, [x0]
               	mov	x4, #0x9                // =9
               	strb	w4, [x0]
               	strb	w3, [x0]
               	strb	w4, [x0, #0x1]
               	mov	x3, #0x5                // =5
               	strb	w3, [x0]
               	ldr	x2, [x2, #0x40]
               	mov	x3, #0x7                // =7
               	strb	w3, [x2]
               	adrp	x2, <page>
               	ldrsw	x3, [x2, #0x48]
               	add	x3, x3, #0x1
               	str	w3, [x2, #0x48]
               	ldrb	w0, [x0]
               	cmp	w0, #0x7
               	csel	x0, x1, x5, ne
               	adrp	x1, <page>
               	mov	x2, #0x6                // =6
               	strb	w2, [x1, #0x3a]
               	ldrb	w1, [x1, #0x3a]
               	orr	x2, x0, #0x40
               	cmp	w1, #0x6
               	csel	x0, x2, x0, ne
               	ret
