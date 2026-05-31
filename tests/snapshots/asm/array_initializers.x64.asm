
array_initializers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0xff11(%rip), %r9       # 0x41015e
               	pushq	%rax
               	movzbq	(%r9), %rax
               	movb	%al, (%r11)
               	movzbq	0x1(%r9), %rax
               	movb	%al, 0x1(%r11)
               	movzbq	0x2(%r9), %rax
               	movb	%al, 0x2(%r11)
               	movzbq	0x3(%r9), %rax
               	movb	%al, 0x3(%r11)
               	movzbq	0x4(%r9), %rax
               	movb	%al, 0x4(%r11)
               	movzbq	0x5(%r9), %rax
               	movb	%al, 0x5(%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x18(%rbp), %r8
               	leaq	0xfed3(%rip), %r9       # 0x410164
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r8)
               	movzbq	0x8(%r9), %rax
               	movb	%al, 0x8(%r8)
               	movzbq	0x9(%r9), %rax
               	movb	%al, 0x9(%r8)
               	movzbq	0xa(%r9), %rax
               	movb	%al, 0xa(%r8)
               	movzbq	0xb(%r9), %rax
               	movb	%al, 0xb(%r8)
               	popq	%rax
               	movq	%r8, %r11
               	leaq	-0x20(%rbp), %r11
               	leaq	0xfea8(%rip), %r9       # 0x410173
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x38(%rbp), %r8
               	leaq	0xfe9a(%rip), %r9       # 0x41017b
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r8)
               	movq	0x8(%r9), %rax
               	movq	%rax, 0x8(%r8)
               	movzbq	0x10(%r9), %rax
               	movb	%al, 0x10(%r8)
               	movzbq	0x11(%r9), %rax
               	movb	%al, 0x11(%r8)
               	movzbq	0x12(%r9), %rax
               	movb	%al, 0x12(%r8)
               	movzbq	0x13(%r9), %rax
               	movb	%al, 0x13(%r8)
               	popq	%rax
               	movq	%r8, %r11
               	leaq	0xfdb7(%rip), %r11      # 0x4100d6
               	movzbq	(%r11), %r9
               	movq	%r9, %r11
               	xorq	$0x68, %r11
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x400351 <.text+0x131>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd7e(%rip), %r11      # 0x4100d6
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movzbq	(%rax), %r11
               	movq	%r11, %rax
               	xorq	$0x6f, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rax, %r11
               	cmpq	$0x0, %r11
               	je	0x400398 <.text+0x178>
               	movl	$0x2, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd37(%rip), %rax      # 0x4100d6
               	movq	%rax, %r11
               	addq	$0x5, %r11
               	movzbq	(%r11), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rax, %r11
               	cmpq	$0x0, %r11
               	je	0x4003d5 <.text+0x1b5>
               	movl	$0x3, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x4003f7 <.text+0x1d7>
               	movl	$0x4, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfce2(%rip), %rax      # 0x4100e0
               	movslq	(%rax), %r11
               	movq	%rax, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %rdi
               	movq	%r11, %r8
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movq	%rax, %rdi
               	addq	$0x8, %rdi
               	movslq	(%rdi), %r11
               	movq	%r8, %rdi
               	addq	%r11, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r11
               	addq	$0xc, %r11
               	movslq	(%r11), %r8
               	movq	%rdi, %r11
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	movq	%rax, %r8
               	addq	$0x10, %r8
               	movslq	(%r8), %rax
               	movq	%r11, %r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	cmpq	$0x1c, %r8
               	je	0x400478 <.text+0x258>
               	movl	$0x5, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x40049a <.text+0x27a>
               	movl	$0x6, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc57(%rip), %rax      # 0x4100f8
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x68, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x4004d7 <.text+0x2b7>
               	movl	$0x7, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc1a(%rip), %rax      # 0x4100f8
               	movq	%rax, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %rax
               	movq	%rax, %r8
               	xorq	$0x69, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	je	0x400519 <.text+0x2f9>
               	movl	$0x8, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfbd8(%rip), %r8       # 0x4100f8
               	movq	%r8, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	je	0x400551 <.text+0x331>
               	movl	$0x9, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfba0(%rip), %r8       # 0x4100f8
               	movq	%r8, %rax
               	addq	$0xf, %rax
               	movzbq	(%rax), %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	je	0x400589 <.text+0x369>
               	movl	$0xa, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	cmpq	$0x0, %r8
               	je	0x4005a7 <.text+0x387>
               	movl	$0xb, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb62(%rip), %r8       # 0x410110
               	movslq	(%r8), %rax
               	cmpq	$0x1, %rax
               	je	0x4005cc <.text+0x3ac>
               	movl	$0xc, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb3d(%rip), %r8       # 0x410110
               	movq	%r8, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r8
               	cmpq	$0x3, %r8
               	je	0x4005ff <.text+0x3df>
               	movl	$0xd, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb0a(%rip), %rax      # 0x410110
               	movq	%rax, %r8
               	addq	$0xc, %r8
               	movslq	(%r8), %rax
               	cmpq	$0x0, %rax
               	je	0x40062e <.text+0x40e>
               	movl	$0xe, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfadb(%rip), %r8       # 0x410110
               	movq	%r8, %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %r8
               	cmpq	$0x0, %r8
               	je	0x400661 <.text+0x441>
               	movl	$0xf, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfad8(%rip), %rax      # 0x410140
               	movq	(%rax), %r8
               	movzbq	(%r8), %rax
               	movq	%rax, %r8
               	xorq	$0x61, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	je	0x40069c <.text+0x47c>
               	movl	$0x10, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfa9d(%rip), %r8       # 0x410140
               	movq	%r8, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r8
               	movzbq	(%r8), %rax
               	movq	%rax, %r8
               	xorq	$0x62, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	je	0x4006e1 <.text+0x4c1>
               	movl	$0x11, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfa58(%rip), %r8       # 0x410140
               	movq	%r8, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r8
               	movq	%r8, %rax
               	addq	$0x4, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x61, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x400735 <.text+0x515>
               	movl	$0x12, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x77, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x40076f <.text+0x54f>
               	movl	$0x13, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %r8
               	addq	$0x4, %r8
               	movzbq	(%r8), %rax
               	movq	%rax, %r8
               	xorq	$0x64, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	je	0x4007ae <.text+0x58e>
               	movl	$0x14, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x5, %rax
               	movzbq	(%rax), %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	je	0x4007e3 <.text+0x5c3>
               	movl	$0x15, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	cmpq	$0x0, %r8
               	je	0x400801 <.text+0x5e1>
               	movl	$0x16, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %rax
               	leaq	-0x18(%rbp), %r8
               	movq	%r8, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r8
               	movq	%rax, %r11
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	leaq	-0x18(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r8
               	movq	%r11, %rax
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	cmpq	$0x258, %rax            # imm = 0x258
               	je	0x400857 <.text+0x637>
               	movl	$0x17, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	cmpq	$0x0, %r8
               	je	0x400875 <.text+0x655>
               	movl	$0x18, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r8
               	movzbq	(%r8), %rax
               	movq	%rax, %r8
               	xorq	$0x6f, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	je	0x4008aa <.text+0x68a>
               	movl	$0x19, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x6b, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x4008ee <.text+0x6ce>
               	movl	$0x1a, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x400928 <.text+0x708>
               	movl	$0x1b, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %r8
               	cmpq	$0x64, %r8
               	je	0x40094e <.text+0x72e>
               	movl	$0x1c, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	movq	%rax, %r8
               	addq	$0x8, %r8
               	movslq	(%r8), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	0x40097a <.text+0x75a>
               	movl	$0x1d, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %r8
               	cmpq	$0x0, %r8
               	je	0x4009aa <.text+0x78a>
               	movl	$0x1e, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	movq	%rax, %r8
               	addq	$0x10, %r8
               	movslq	(%r8), %rax
               	cmpq	$0x0, %rax
               	je	0x4009d6 <.text+0x7b6>
               	movl	$0x1f, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	je	0x400a0b <.text+0x7eb>
               	movl	$0x20, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x7, %rax
               	movzbq	(%rax), %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	je	0x400a40 <.text+0x820>
               	movl	$0x21, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
