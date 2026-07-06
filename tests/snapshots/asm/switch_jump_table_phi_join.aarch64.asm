
switch_jump_table_phi_join.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x3, x1
               	sxtw	x0, w0
               	cmp	x0, #0xc
               	b.hs	<addr>
               	adr	x17, <addr>
               	ldrsw	x16, [x17, x0, lsl #2]
               	add	x17, x17, x16
               	br	x17
               	udf	#0x30
               	udf	#0x6c
               	udf	#0x70
               	udf	#0x74
               	udf	#0x78
               	udf	#0x7c
               	udf	#0x80
               	udf	#0x84
               	udf	#0x88
               	udf	#0x8c
               	udf	#0x90
               	udf	#0xa8
               	add	x3, x3, #0x1
               	add	x2, x3, #0x2
               	add	x3, x3, x2
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x3, x3, x2
               	add	x2, x2, x3
               	lsl	x3, x3, #1
               	sub	x2, x2, #0x1
               	add	x3, x3, #0x7
               	add	x2, x2, x3
               	mov	x17, #0x1f              // =31
               	mul	x0, x3, x17
               	add	x0, x0, x2
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x3, x3, x17
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x2, x2, x17
               	b	<addr>
               	mov	x3, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x1, #0x0                // =0
               	mov	x20, #0xfffe            // =65534
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	b	<addr>
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	b	<addr>
               	mov	x22, #0x0               // =0
               	b	<addr>
               	mov	x17, #0x21              // =33
               	mul	x23, x1, x17
               	sxtw	x0, w20
               	mov	x1, x21
               	mov	x2, x22
               	bl	<addr>
               	add	x1, x23, x0
               	add	x22, x22, #0x1
               	cmp	x22, #0x3
               	b.lt	<addr>
               	add	x21, x21, #0x1
               	cmp	x21, #0x3
               	b.lt	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0xe
               	b.lt	<addr>
               	mov	x17, #0x2760            // =10080
               	movk	x17, #0x4634, lsl #16
               	movk	x17, #0xf948, lsl #32
               	movk	x17, #0xd14a, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	b	<addr>
               	b	<addr>
