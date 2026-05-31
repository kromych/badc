
bitfield_brace_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0xfe83(%rip), %r9       # 0x4100d0
               	pushq	%rax
               	movzbq	(%r9), %rax
               	movb	%al, (%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x8(%rbp), %r8
               	movzbq	(%r8), %r9
               	movq	%r9, %r8
               	andq	$0x3, %r8
               	cmpq	$0x1, %r8
               	je	0x400286 <.text+0x66>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzbq	(%r9), %rax
               	movq	%rax, %r9
               	sarq	$0x2, %r9
               	movq	%r9, %rax
               	andq	$0x3, %rax
               	cmpq	$0x2, %rax
               	je	0x4002ba <.text+0x9a>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzbq	(%r9), %rax
               	movq	%rax, %r9
               	sarq	$0x4, %r9
               	movq	%r9, %rax
               	andq	$0x3, %rax
               	cmpq	$0x3, %rax
               	je	0x4002ee <.text+0xce>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzbq	(%r9), %rax
               	movq	%rax, %r9
               	sarq	$0x6, %r9
               	movq	%r9, %rax
               	andq	$0x3, %rax
               	cmpq	$0x0, %rax
               	je	0x400322 <.text+0x102>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	leaq	0xfda4(%rip), %rax      # 0x4100d1
               	pushq	%r11
               	movzbq	(%rax), %r11
               	movb	%r11b, (%r9)
               	movzbq	0x1(%rax), %r11
               	movb	%r11b, 0x1(%r9)
               	movzbq	0x2(%rax), %r11
               	movb	%r11b, 0x2(%r9)
               	movzbq	0x3(%rax), %r11
               	movb	%r11b, 0x3(%r9)
               	popq	%r11
               	movq	%r9, %r11
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %eax
               	movq	%rax, %r11
               	andq	$0xff, %r11
               	cmpq	$0xab, %r11
               	je	0x400386 <.text+0x166>
               	movl	$0x15, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r11d
               	movq	%r11, %rax
               	sarq	$0x8, %rax
               	movq	%rax, %r11
               	andq	$0x1, %r11
               	cmpq	$0x1, %r11
               	je	0x4003bd <.text+0x19d>
               	movl	$0x16, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r11d
               	movq	%r11, %rax
               	sarq	$0x9, %rax
               	movq	%rax, %r11
               	andq	$0x7fffff, %r11         # imm = 0x7FFFFF
               	cmpq	$0x12345, %r11          # imm = 0x12345
               	je	0x4003f4 <.text+0x1d4>
               	movl	$0x17, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	0xfcd6(%rip), %r11      # 0x4100d5
               	pushq	%rcx
               	movzbq	(%r11), %rcx
               	movb	%cl, (%rax)
               	popq	%rcx
               	movq	%rax, %r9
               	leaq	-0x18(%rbp), %r9
               	movzbq	(%r9), %r11
               	movq	%r11, %r9
               	andq	$0x7, %r9
               	cmpq	$0x7, %r9
               	je	0x400438 <.text+0x218>
               	movl	$0x1f, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movzbq	(%r11), %rax
               	movq	%rax, %r11
               	sarq	$0x3, %r11
               	movq	%r11, %rax
               	andq	$0x7, %rax
               	cmpq	$0x7, %rax
               	je	0x40046c <.text+0x24c>
               	movl	$0x20, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movzbq	(%r11), %rax
               	movq	%rax, %r11
               	sarq	$0x6, %r11
               	movq	%r11, %rax
               	andq	$0x3, %rax
               	cmpq	$0x3, %rax
               	je	0x4004a0 <.text+0x280>
               	movl	$0x21, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	leaq	0xfc2b(%rip), %rax      # 0x4100d6
               	pushq	%rcx
               	movzbq	(%rax), %rcx
               	movb	%cl, (%r11)
               	popq	%rcx
               	movq	%r11, %r9
               	leaq	-0x20(%rbp), %r9
               	movzbq	(%r9), %rax
               	movq	%rax, %r9
               	andq	$0x3, %r9
               	cmpq	$0x1, %r9
               	je	0x4004e8 <.text+0x2c8>
               	movl	$0x29, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %r9
               	movq	%r9, %rax
               	sarq	$0x2, %rax
               	movq	%rax, %r9
               	andq	$0x3, %r9
               	cmpq	$0x2, %r9
               	je	0x400520 <.text+0x300>
               	movl	$0x2a, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %r9
               	movq	%r9, %rax
               	sarq	$0x4, %rax
               	movq	%rax, %r9
               	andq	$0x3, %r9
               	cmpq	$0x0, %r9
               	je	0x400558 <.text+0x338>
               	movl	$0x2b, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %r9
               	movq	%r9, %rax
               	sarq	$0x6, %rax
               	movq	%rax, %r9
               	andq	$0x3, %r9
               	cmpq	$0x0, %r9
               	je	0x400590 <.text+0x370>
               	movl	$0x2c, %r9d
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
