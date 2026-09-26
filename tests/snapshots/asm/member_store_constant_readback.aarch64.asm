
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

<narrow_sign>:
               	mov	x1, #0x80               // =128
               	mov	x2, #-0x80              // =-128
               	strb	w2, [x0]
               	strb	w1, [x0, #0x1]
               	mov	x1, #0x8000             // =32768
               	mov	x2, #-0x8000            // =-32768
               	strh	w2, [x0, #0x2]
               	strh	w1, [x0, #0x4]
               	mov	x1, #0x80000000         // =2147483648
               	mov	x2, #-0x80000000        // =-2147483648
               	str	w2, [x0, #0x8]
               	str	w1, [x0, #0xc]
               	mov	x1, #-0x1               // =-1
               	str	x1, [x0, #0x10]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x20               // =32
               	strb	w1, [x0, #0x1]
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x1, #0x2                // =2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x1                // =1
               	strb	w2, [x0]
               	mov	x2, #0x2                // =2
               	strb	w2, [x0, #0x1]
               	mov	x2, #0x3                // =3
               	strb	w2, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x0, [x2]
               	mov	x3, #0x4                // =4
               	strb	w3, [x0]
               	mov	x4, #0x9                // =9
               	strb	w4, [x0]
               	strb	w3, [x0]
               	strb	w4, [x0, #0x1]
               	mov	x3, #0x5                // =5
               	strb	w3, [x0]
               	ldr	x2, [x2]
               	mov	x3, #0x7                // =7
               	strb	w3, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	ldrb	w0, [x0]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	orr	x1, x1, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x6                // =6
               	strb	w2, [x0]
               	ldrb	w0, [x0]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	orr	x1, x1, #0x40
               	mov	x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
