
add_three_operand_lea.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x3                // =3
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0x5                // =5
               	stur	x0, [x29, #-0x18]
               	ldur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x10]
               	add	x0, x0, x1
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x10]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x8]
               	ldur	x2, [x29, #-0x18]
               	add	x1, x1, x2
               	add	x0, x0, x1
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfffb             // =65531
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x10]
               	add	x0, x0, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9400             // =37888
               	movk	x0, #0x7735, lsl #16
               	stur	w0, [x29, #-0x20]
               	stur	w0, [x29, #-0x28]
               	ldursw	x0, [x29, #-0x20]
               	ldursw	x1, [x29, #-0x28]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0x7fff, lsl #48
               	stur	x0, [x29, #-0x30]
               	ldur	x0, [x29, #-0x30]
               	add	x0, x0, #0x1
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
