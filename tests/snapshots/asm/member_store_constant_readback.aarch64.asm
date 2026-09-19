
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
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, #0x0               // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x20               // =32
               	strb	w1, [x0, #0x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x20, #0x2               // =2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0x1]
               	mov	x1, #0x3                // =3
               	strb	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [x1]
               	mov	x1, #0x4                // =4
               	strb	w1, [x0]
               	mov	x2, #0x9                // =9
               	strb	w2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	strb	w1, [x0]
               	strb	w2, [x0, #0x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x5                // =5
               	strb	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x2, #0x7                // =7
               	strb	w2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	ldrb	w0, [x0]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	orr	x20, x20, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x6                // =6
               	strb	w1, [x0]
               	ldrb	w0, [x0]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	orr	x20, x20, #0x40
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
