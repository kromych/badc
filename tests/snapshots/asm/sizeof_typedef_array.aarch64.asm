
sizeof_typedef_array.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0x200             // =512
               	sxtw	x15, w15
               	cmp	x15, #0x200
               	b.eq	0x400250 <.text+0x30>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x14, #0x28              // =40
               	sxtw	x14, w14
               	cmp	x14, #0x28
               	b.eq	0x40026c <.text+0x4c>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400280 <.text+0x60>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400294 <.text+0x74>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x4002a8 <.text+0x88>
               	mov	x14, #0x5               // =5
               	mov	x0, x14
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x4002bc <.text+0x9c>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	ret
               	mov	x0, #0x0                // =0
               	ret
