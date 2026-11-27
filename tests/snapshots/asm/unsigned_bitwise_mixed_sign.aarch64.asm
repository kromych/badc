
unsigned_bitwise_mixed_sign.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	ldursb	x1, [x29, #-0x20]
               	ldursh	x0, [x29, #-0x18]
               	ldursw	x3, [x29, #-0x10]
               	ldur	w0, [x29, #-0x8]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x2, x0, x1
               	mov	x17, #0xffaa            // =65450
               	movk	x17, #0xffff, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x2, x0, x1
               	mov	x17, #0xffaa            // =65450
               	movk	x17, #0xffff, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffaa            // =65450
               	movk	x17, #0xffff, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mvn	x2, x0
               	cmp	w2, #0x55
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x0, x3, x0
               	mov	x17, #0xffaa            // =65450
               	movk	x17, #0xffff, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmn	w1, #0x56
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffaa            // =65450
               	eor	x0, x1, x17
               	mov	x17, #-0x10000          // =-65536
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
