
packed_member_read_through_a_pointer.aarch64:	file format elf64-littleaarch64

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

<read_word>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x0, [x0, #0x1]
               	ret

<write_wide>:
               	mov	x0, #0x708              // =1800
               	movk	x0, #0x506, lsl #16
               	movk	x0, #0x304, lsl #32
               	movk	x0, #0x102, lsl #48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stur	x0, [x1, #0x5]
               	ret

<read_first>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x17, #0xcafe            // =51966
               	movk	x17, #0xbad, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x2]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x708              // =1800
               	movk	x0, #0x506, lsl #16
               	movk	x0, #0x304, lsl #32
               	movk	x0, #0x102, lsl #48
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldur	x1, [x0, #0x5]
               	mov	x17, #0x708             // =1800
               	movk	x17, #0x506, lsl #16
               	movk	x17, #0x304, lsl #32
               	movk	x17, #0x102, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	ldursh	x1, [x0, #0xd]
               	mov	x17, #0x4321            // =17185
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w0, [x0]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
