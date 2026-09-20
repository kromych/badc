
mul_add_wide_result.aarch64:	file format elf64-littleaarch64

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

<macc>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	madd	x0, x0, x2, x3
               	ret

<macc_sub>:
               	sxtw	x0, w0
               	msub	x0, x0, x1, x2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x7fffffff         // =2147483647
               	mov	x1, #0x1                // =1
               	mov	x2, #0x3                // =3
               	mov	x3, #0x64               // =100
               	bl	<addr>
               	mov	x17, #-0xff9c           // =-65436
               	movk	x17, #0x8000, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x4               // =-4
               	mov	x1, #0x0                // =0
               	mov	x2, #0xca00             // =51712
               	movk	x2, #0x3b9a, lsl #16
               	mov	x3, x1
               	bl	<addr>
               	mov	x17, #-0x2800           // =-10240
               	movk	x17, #0x1194, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x3                // =3
               	mov	x2, #0x7                // =7
               	mov	x3, #-0x1               // =-1
               	bl	<addr>
               	cmp	x0, #0x22
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x5               // =-5
               	mov	x1, #0xca00             // =51712
               	movk	x1, #0x3b9a, lsl #16
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	mov	x17, #0xf200            // =61952
               	movk	x17, #0x2a05, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4240             // =16960
               	movk	x0, #0xf, lsl #16
               	mov	x2, #0x0                // =0
               	mov	x1, x0
               	bl	<addr>
               	mov	x17, #-0x1000           // =-4096
               	movk	x17, #0x2b5a, lsl #16
               	movk	x17, #0xff17, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
