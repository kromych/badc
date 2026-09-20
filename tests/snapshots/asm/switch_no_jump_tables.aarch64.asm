
switch_no_jump_tables.aarch64:	file format elf64-littleaarch64

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

<dense_signed>:
               	cmp	w0, #0xb
               	b.lt	<addr>
               	cmp	w0, #0x10
               	b.lt	<addr>
               	cmp	w0, #0x12
               	b.lt	<addr>
               	cmp	w0, #0x13
               	b.lt	<addr>
               	cmp	w0, #0x13
               	b.eq	<addr>
               	mov	x0, #-0x1               // =-1
               	ret
               	mov	x0, #0x10               // =16
               	ret
               	mov	x0, #0xf                // =15
               	ret
               	cmp	w0, #0x11
               	b.lt	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	mov	x0, #0xd                // =13
               	ret
               	cmp	w0, #0xd
               	b.lt	<addr>
               	cmp	w0, #0xe
               	b.lt	<addr>
               	cmp	w0, #0xe
               	b.ne	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0xb                // =11
               	ret
               	cmp	w0, #0xc
               	b.lt	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0x9                // =9
               	ret
               	cmp	w0, #0x7
               	b.lt	<addr>
               	cmp	w0, #0x9
               	b.lt	<addr>
               	cmp	w0, #0xa
               	b.lt	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x7                // =7
               	ret
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x5                // =5
               	ret
               	cmp	w0, #0x5
               	b.lt	<addr>
               	cmp	w0, #0x6
               	b.lt	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	w0, #0x3
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret

<fallthrough_sum>:
               	mov	x1, #0x0                // =0
               	cmp	w0, #0x4
               	b.lt	<addr>
               	cmp	w0, #0x6
               	b.lt	<addr>
               	cmp	w0, #0x7
               	b.lt	<addr>
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #-0x1               // =-1
               	ret
               	add	x0, x1, #0x80
               	b	<addr>
               	add	x1, x1, #0x40
               	b	<addr>
               	cmp	w0, #0x5
               	b.lt	<addr>
               	add	x1, x1, #0x20
               	b	<addr>
               	add	x1, x1, #0x10
               	b	<addr>
               	cmp	w0, #0x2
               	b.lt	<addr>
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x1, x1, #0x8
               	b	<addr>
               	add	x1, x1, #0x4
               	b	<addr>
               	cmp	w0, #0x1
               	b.lt	<addr>
               	add	x1, x1, #0x2
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, #0x3               // =3
               	cmp	w20, #0xf
               	b.eq	<addr>
               	cmp	w20, #0xf
               	b.ge	<addr>
               	sub	x21, x20, #0x2
               	mov	x0, x20
               	bl	<addr>
               	cmp	w0, w21
               	b.eq	<addr>
               	b	<addr>
               	sub	x21, x20, #0x3
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x13
               	b.le	<addr>
               	mov	x0, #0xf                // =15
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #-0x80000000        // =-2147483648
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x7fffffff         // =2147483647
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	w0, #0xff
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	w0, #0xfc
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0xf8
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	w0, #0xf0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	w0, #0xe0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	cmp	w0, #0xc0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	cmp	w0, #0x80
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
