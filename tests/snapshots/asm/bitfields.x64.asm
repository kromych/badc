
bitfields.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400247 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r9d
               	movq	%r9, %r8
               	andq	$-0x2, %r8
               	movl	$0x1, %r9d
               	movq	%r9, %rdi
               	andq	$0x1, %rdi
               	movq	%r8, %r9
               	orq	%rdi, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %rdi
               	movl	(%rdi), %r9d
               	movq	%r9, %r11
               	andq	$-0x3, %r11
               	xorq	%r9, %r9
               	movq	%r9, %r8
               	andq	$0x1, %r8
               	movq	%r8, %r9
               	shlq	$0x1, %r9
               	movq	%r11, %r8
               	orq	%r9, %r8
               	movl	%r8d, (%rdi)
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %r8d
               	movq	%r8, %rdi
               	andq	$-0x1d, %rdi
               	movl	$0x5, %r8d
               	movq	%r8, %r11
               	andq	$0x7, %r11
               	movq	%r11, %r8
               	shlq	$0x2, %r8
               	movq	%rdi, %r11
               	orq	%r8, %r11
               	movl	%r11d, (%r9)
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %r11d
               	movq	%r11, %r9
               	andq	$-0x3e1, %r9            # imm = 0xFC1F
               	movl	$0x11, %r11d
               	movq	%r11, %rdi
               	andq	$0x1f, %rdi
               	movq	%rdi, %r11
               	shlq	$0x5, %r11
               	movq	%r9, %rdi
               	orq	%r11, %rdi
               	movl	%edi, (%r8)
               	leaq	-0x10(%rbp), %r11
               	movq	%r11, %rdi
               	addq	$0x4, %rdi
               	movl	(%rdi), %r11d
               	movabsq	$-0x100000000, %r8      # imm = 0xFFFFFFFF00000000
               	andq	%r11, %r8
               	movl	$0x12345678, %r11d      # imm = 0x12345678
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movq	%r8, %r11
               	orq	%r9, %r11
               	movl	%r11d, (%rdi)
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0x8, %r11
               	movl	$0x3e7, %r9d            # imm = 0x3E7
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %rdi
               	movl	(%rdi), %r9d
               	movq	%r9, %rdi
               	andq	$0x1, %rdi
               	cmpq	$0x1, %rdi
               	je	0x400385 <.text+0x155>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	movq	%rax, %r9
               	sarq	$0x1, %r9
               	movq	%r9, %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	0x4003b8 <.text+0x188>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	movq	%rax, %r9
               	sarq	$0x2, %r9
               	movq	%r9, %rax
               	andq	$0x7, %rax
               	cmpq	$0x5, %rax
               	je	0x4003eb <.text+0x1bb>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	movq	%rax, %r9
               	sarq	$0x5, %r9
               	movq	%r9, %rax
               	andq	$0x1f, %rax
               	cmpq	$0x11, %rax
               	je	0x40041e <.text+0x1ee>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %rax
               	addq	$0x4, %rax
               	movl	(%rax), %r9d
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	cmpq	$0x12345678, %rax       # imm = 0x12345678
               	je	0x400452 <.text+0x222>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x3e7, %r9             # imm = 0x3E7
               	je	0x400482 <.text+0x252>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r9d
               	movq	%r9, %r11
               	andq	$-0x2, %r11
               	xorq	%r9, %r9
               	movq	%r9, %r8
               	andq	$0x1, %r8
               	movq	%r11, %r9
               	orq	%r8, %r9
               	movl	%r9d, (%rax)
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %r9d
               	movq	%r9, %r8
               	andq	$0x1, %r8
               	cmpq	$0x0, %r8
               	je	0x4004d5 <.text+0x2a5>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	movq	%rax, %r9
               	sarq	$0x1, %r9
               	movq	%r9, %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	0x400508 <.text+0x2d8>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	movq	%rax, %r9
               	sarq	$0x2, %r9
               	movq	%r9, %rax
               	andq	$0x7, %rax
               	cmpq	$0x5, %rax
               	je	0x40053b <.text+0x30b>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	movq	%rax, %r9
               	sarq	$0x5, %r9
               	movq	%r9, %rax
               	andq	$0x1f, %rax
               	cmpq	$0x11, %rax
               	je	0x40056e <.text+0x33e>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %rax
               	addq	$0x4, %rax
               	movl	(%rax), %r9d
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	cmpq	$0x12345678, %rax       # imm = 0x12345678
               	je	0x4005a2 <.text+0x372>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x3e7, %r9             # imm = 0x3E7
               	je	0x4005d2 <.text+0x3a2>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r9d
               	movq	%r9, %r8
               	andq	$-0x1d, %r8
               	movl	$0x7, %r9d
               	movq	%r9, %r11
               	andq	$0x7, %r11
               	movq	%r11, %r9
               	shlq	$0x2, %r9
               	movq	%r8, %r11
               	orq	%r9, %r11
               	movl	%r11d, (%rax)
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %r11d
               	movq	%r11, %r9
               	sarq	$0x2, %r9
               	movq	%r9, %r11
               	andq	$0x7, %r11
               	cmpq	$0x7, %r11
               	je	0x400636 <.text+0x406>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	movq	%rax, %r9
               	sarq	$0x5, %r9
               	movq	%r9, %rax
               	andq	$0x1f, %rax
               	cmpq	$0x11, %rax
               	je	0x400669 <.text+0x439>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	movq	%rax, %r9
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	je	0x400699 <.text+0x469>
               	movl	$0xf, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %r9d
               	movq	%r9, %r11
               	andq	$-0x2, %r11
               	movl	$0x1, %r9d
               	movq	%r9, %r8
               	andq	$0x1, %r8
               	movq	%r11, %r9
               	orq	%r8, %r9
               	movl	%r9d, (%rax)
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %r9d
               	movq	%r9, %rax
               	andq	$-0x3, %rax
               	movq	%r8, %r9
               	shlq	$0x1, %r9
               	movq	%rax, %rsi
               	orq	%r9, %rsi
               	movl	%esi, (%r11)
               	leaq	-0x18(%rbp), %r9
               	movl	(%r9), %esi
               	movq	%rsi, %r11
               	andq	$-0x5, %r11
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	andq	$0x1, %rax
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	movq	%r11, %rax
               	orq	%rsi, %rax
               	movl	%eax, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movl	(%rsi), %eax
               	movq	%rax, %r9
               	andq	$-0x9, %r9
               	movq	%r8, %rax
               	shlq	$0x3, %rax
               	movq	%r9, %r8
               	orq	%rax, %r8
               	movl	%r8d, (%rsi)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %r8d
               	movq	%r8, %rsi
               	andq	$-0xf1, %rsi
               	movl	$0xb, %r8d
               	movq	%r8, %r9
               	andq	$0xf, %r9
               	movq	%r9, %r8
               	shlq	$0x4, %r8
               	movq	%rsi, %r9
               	orq	%r8, %r9
               	movl	%r9d, (%rax)
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %r9d
               	movq	%r9, %rax
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	movl	$0xc8, %r9d
               	movq	%r9, %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r9
               	shlq	$0x8, %r9
               	movq	%rax, %rsi
               	orq	%r9, %rsi
               	movl	%esi, (%r8)
               	leaq	-0x18(%rbp), %r9
               	movl	(%r9), %esi
               	movq	%rsi, %r9
               	andq	$0x1, %r9
               	cmpq	$0x1, %r9
               	je	0x4007c0 <.text+0x590>
               	movl	$0x10, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rsi
               	movl	(%rsi), %eax
               	movq	%rax, %rsi
               	sarq	$0x1, %rsi
               	movq	%rsi, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	0x4007f2 <.text+0x5c2>
               	movl	$0x11, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rsi
               	movl	(%rsi), %eax
               	movq	%rax, %rsi
               	sarq	$0x2, %rsi
               	movq	%rsi, %rax
               	andq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	0x400824 <.text+0x5f4>
               	movl	$0x12, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rsi
               	movl	(%rsi), %eax
               	movq	%rax, %rsi
               	sarq	$0x3, %rsi
               	movq	%rsi, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	0x400856 <.text+0x626>
               	movl	$0x13, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rsi
               	movl	(%rsi), %eax
               	movq	%rax, %rsi
               	sarq	$0x4, %rsi
               	movq	%rsi, %rax
               	andq	$0xf, %rax
               	cmpq	$0xb, %rax
               	je	0x400888 <.text+0x658>
               	movl	$0x14, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rsi
               	movl	(%rsi), %eax
               	movq	%rax, %rsi
               	sarq	$0x8, %rsi
               	movq	%rsi, %rax
               	andq	$0xff, %rax
               	cmpq	$0xc8, %rax
               	je	0x4008ba <.text+0x68a>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rsi
               	movl	(%rsi), %eax
               	movq	%rax, %r8
               	andq	$-0xff01, %r8           # imm = 0xFFFF00FF
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %r9d
               	movq	%r9, %rax
               	sarq	$0x8, %rax
               	movq	%rax, %r9
               	andq	$0xff, %r9
               	movq	%r9, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	andq	$0xff, %r9
               	movq	%r9, %rax
               	shlq	$0x8, %rax
               	movq	%r8, %r9
               	orq	%rax, %r9
               	movl	%r9d, (%rsi)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %r9d
               	movq	%r9, %rax
               	sarq	$0x8, %rax
               	movq	%rax, %r9
               	andq	$0xff, %r9
               	cmpq	$0xc9, %r9
               	je	0x400940 <.text+0x710>
               	movl	$0x16, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
