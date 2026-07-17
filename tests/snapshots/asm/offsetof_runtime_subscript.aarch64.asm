
offsetof_runtime_subscript.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x2, x1, #0x4
               	cmp	x2, x2
               	b.ne	<addr>
               	lsl	x2, x1, #3
               	add	x2, x2, #0x18
               	cmp	x2, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #0xc               // =12
               	mul	x2, x1, x17
               	add	x2, x2, #0x58
               	mov	x17, #0x6               // =6
               	mul	x3, x1, x17
               	lsl	x3, x3, #1
               	add	x3, x3, #0x58
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x2, x1, #0x88
               	cmp	x2, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x5
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x1                // =1
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
