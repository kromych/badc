
bitwise_not_mvn.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x3210             // =12816
               	movk	x0, #0x7654, lsl #16
               	movk	x0, #0xba98, lsl #32
               	movk	x0, #0xfedc, lsl #48
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0x5555             // =21845
               	movk	x0, #0xaaaa, lsl #16
               	movk	x0, #0x5555, lsl #32
               	movk	x0, #0xaaaa, lsl #48
               	stur	x0, [x29, #-0x18]
               	ldur	x0, [x29, #-0x8]
               	mvn	x0, x0
               	ldur	x1, [x29, #-0x8]
               	mvn	x1, x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x10]
               	mvn	x0, x0
               	and	x0, x0, x1
               	ldur	x1, [x29, #-0x8]
               	mvn	x1, x1
               	ldur	x2, [x29, #-0x10]
               	and	x1, x1, x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x10]
               	ldur	x2, [x29, #-0x18]
               	and	x1, x0, x1
               	mvn	x0, x0
               	and	x0, x0, x2
               	eor	x0, x1, x0
               	ldur	x1, [x29, #-0x8]
               	ldur	x2, [x29, #-0x10]
               	and	x1, x1, x2
               	ldur	x2, [x29, #-0x8]
               	mvn	x2, x2
               	ldur	x3, [x29, #-0x18]
               	and	x2, x2, x3
               	eor	x1, x1, x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	mvn	x0, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
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
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	mvn	x0, x0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
