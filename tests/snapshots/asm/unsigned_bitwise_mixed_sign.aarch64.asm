
unsigned_bitwise_mixed_sign.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #-0x56              // =-86
               	sturb	w0, [x29, #-0x20]
               	sturh	w0, [x29, #-0x18]
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0xffaa             // =65450
               	movk	x0, #0xffff, lsl #16
               	stur	w0, [x29, #-0x8]
               	ldursb	x0, [x29, #-0x20]
               	ldursh	x3, [x29, #-0x18]
               	ldursw	x2, [x29, #-0x10]
               	ldur	w1, [x29, #-0x8]
               	eor	x4, x1, x0
               	cbz	w4, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x4, x1, x0
               	mov	x17, #0xffaa            // =65450
               	movk	x17, #0xffff, lsl #16
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x4, x1, x0
               	mov	x17, #0xffaa            // =65450
               	movk	x17, #0xffff, lsl #16
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	eor	x4, x0, x0
               	cbz	w4, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cbz	w4, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	eor	x3, x3, x3
               	cbz	w3, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x3, x2, x2
               	mov	x17, #0xffaa            // =65450
               	movk	x17, #0xffff, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mvn	x3, x1
               	cmp	w3, #0x55
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x1, x2, x1
               	mov	x17, #0xffaa            // =65450
               	movk	x17, #0xffff, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #-0x56             // =-86
               	eor	x1, x0, x17
               	cbz	x1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffaa            // =65450
               	eor	x0, x0, x17
               	mov	x17, #-0x10000          // =-65536
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
