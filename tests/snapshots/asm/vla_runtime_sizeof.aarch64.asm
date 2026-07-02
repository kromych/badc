
vla_runtime_sizeof.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x2, lsl #12   // =0x2000
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	sub	x16, x29, #0x28
               	str	x16, [x16]
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	lsl	x0, x0, #3
               	stur	x0, [x29, #-0x18]
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	sub	x16, x29, #0x28
               	ldr	x0, [x16]
               	sub	x0, x0, x17
               	sub	x17, x16, #0x2, lsl #12 // =0x2000
               	cmp	x0, x17
               	b.hs	<addr>
               	brk	#0x1
               	str	x0, [x16]
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x18]
               	stur	x0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	ldursw	x1, [x29, #-0x8]
               	lsl	x1, x1, #3
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x20]
               	lsr	x0, x0, #3
               	ldursw	x1, [x29, #-0x8]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	stur	w0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x18]
               	cmp	x0, #0x38
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
