
switch_jump_table_phi_join.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
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
               	add	x1, x1, #0x1
               	add	x2, x1, #0x2
               	add	x1, x1, x2
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x1, x1, x2
               	add	x2, x2, x1
               	lsl	x1, x1, #1
               	sub	x2, x2, #0x1
               	add	x1, x1, #0x7
               	add	x2, x2, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x1, x17
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
               	mul	x1, x1, x17
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x2, x2, x17
               	b	<addr>
               	mov	x1, #0xd                // =13
               	mov	x2, #0x11               // =17
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x0                // =0
               	mov	x21, #0xfffe            // =65534
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	b	<addr>
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	b	<addr>
               	mov	x2, #0x0                // =0
               	mov	x17, #0x21              // =33
               	mul	x22, x0, x17
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	add	x0, x22, x0
               	mov	x2, #0x1                // =1
               	mov	x17, #0x21              // =33
               	mul	x22, x0, x17
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	add	x0, x22, x0
               	mov	x2, #0x2                // =2
               	mov	x17, #0x21              // =33
               	mul	x22, x0, x17
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	add	x0, x22, x0
               	add	x20, x20, #0x1
               	cmp	x20, #0x3
               	b.lt	<addr>
               	sxtw	x1, w21
               	add	x21, x1, #0x1
               	sxtw	x1, w21
               	cmp	x1, #0xe
               	b.lt	<addr>
               	mov	x17, #0x2760            // =10080
               	movk	x17, #0x4634, lsl #16
               	movk	x17, #0xf948, lsl #32
               	movk	x17, #0xd14a, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>
               	b	<addr>
