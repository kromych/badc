
struct_layout.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003cd <.text+0x14d>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100e8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe3e(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40030b <.text+0x8b>
               	leaq	0xfe1a(%rip), %rdi      # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfdf7(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfde5(%rip), %rsi      # 0x410116
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfdd4(%rip), %r9       # 0x41011d
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400f67 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400399 <.text+0x119>
               	leaq	0xfd77(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400399 <.text+0x119>
               	leaq	0xfd58(%rip), %r12      # 0x4100f8
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4003e3 <.text+0x163>
               	movl	$0x1, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x400400 <.text+0x180>
               	movl	$0x2, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x400427 <.text+0x1a7>
               	movl	$0x3, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x40044e <.text+0x1ce>
               	movl	$0x4, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x10, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x10, %r11
               	je	0x400475 <.text+0x1f5>
               	movl	$0x5, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x18, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x18, %r11
               	je	0x40049c <.text+0x21c>
               	movl	$0x6, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x1a, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1a, %r11
               	je	0x4004c3 <.text+0x243>
               	movl	$0x7, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x20, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x20, %r11
               	je	0x4004ea <.text+0x26a>
               	movl	$0x8, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400504 <.text+0x284>
               	movl	$0xa, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x40051d <.text+0x29d>
               	movl	$0xb, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	0x400540 <.text+0x2c0>
               	movl	$0xc, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	0x400563 <.text+0x2e3>
               	movl	$0xd, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	0x400586 <.text+0x306>
               	movl	$0xe, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40059c <.text+0x31c>
               	movl	$0x14, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x4005b9 <.text+0x339>
               	movl	$0x15, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x4005e0 <.text+0x360>
               	movl	$0x16, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x400607 <.text+0x387>
               	movl	$0x17, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400621 <.text+0x3a1>
               	movl	$0x1e, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x40063a <.text+0x3ba>
               	movl	$0x1f, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	0x40065d <.text+0x3dd>
               	movl	$0x20, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	je	0x400680 <.text+0x400>
               	movl	$0x21, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400696 <.text+0x416>
               	movl	$0x28, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x4006b3 <.text+0x433>
               	movl	$0x29, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x4006da <.text+0x45a>
               	movl	$0x2a, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x20, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x20, %r11
               	je	0x400701 <.text+0x481>
               	movl	$0x2b, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x40071b <.text+0x49b>
               	movl	$0x32, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400735 <.text+0x4b5>
               	movl	$0x33, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x40074e <.text+0x4ce>
               	movl	$0x34, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x24, %rax
               	movslq	%eax, %rax
               	cmpq	$0x24, %rax
               	je	0x400771 <.text+0x4f1>
               	movl	$0x35, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400787 <.text+0x507>
               	movl	$0x3c, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40079d <.text+0x51d>
               	movl	$0x3d, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x4007ba <.text+0x53a>
               	movl	$0x3e, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x4007e1 <.text+0x561>
               	movl	$0x3f, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x18, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x18, %r11
               	je	0x400808 <.text+0x588>
               	movl	$0x40, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400822 <.text+0x5a2>
               	movl	$0x46, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x40083b <.text+0x5bb>
               	movl	$0x47, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	0x40085e <.text+0x5de>
               	movl	$0x48, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x5, %rax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	0x400881 <.text+0x601>
               	movl	$0x49, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x6, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	0x4008a4 <.text+0x624>
               	movl	$0x4a, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0xe, %rax
               	movslq	%eax, %rax
               	cmpq	$0xe, %rax
               	je	0x4008c7 <.text+0x647>
               	movl	$0x4b, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	je	0x4008ea <.text+0x66a>
               	movl	$0x4c, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x11, %rax
               	movslq	%eax, %rax
               	cmpq	$0x11, %rax
               	je	0x40090d <.text+0x68d>
               	movl	$0x4d, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400923 <.text+0x6a3>
               	movl	$0x50, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x400940 <.text+0x6c0>
               	movl	$0x51, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x400967 <.text+0x6e7>
               	movl	$0x52, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x1a, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1a, %r11
               	je	0x40098e <.text+0x70e>
               	movl	$0x53, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x4009a8 <.text+0x728>
               	movl	$0x5a, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x4009c1 <.text+0x741>
               	movl	$0x5b, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	0x4009e4 <.text+0x764>
               	movl	$0x5c, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x6, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	0x400a07 <.text+0x787>
               	movl	$0x5d, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x8, %rax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	je	0x400a2a <.text+0x7aa>
               	movl	$0x5e, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	je	0x400a4d <.text+0x7cd>
               	movl	$0x5f, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x12, %rax
               	movslq	%eax, %rax
               	cmpq	$0x12, %rax
               	je	0x400a70 <.text+0x7f0>
               	movl	$0x60, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	cmpq	$0x14, %rax
               	je	0x400a93 <.text+0x813>
               	movl	$0x61, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400aa9 <.text+0x829>
               	movl	$0x64, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x400ac6 <.text+0x846>
               	movl	$0x65, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x400aed <.text+0x86d>
               	movl	$0x66, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x400b14 <.text+0x894>
               	movl	$0x67, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0xc, %r11
               	movslq	%r11d, %r11
               	cmpq	$0xc, %r11
               	je	0x400b3b <.text+0x8bb>
               	movl	$0x68, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x14, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x14, %r11
               	je	0x400b62 <.text+0x8e2>
               	movl	$0x69, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x16, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x16, %r11
               	je	0x400b89 <.text+0x909>
               	movl	$0x6a, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x18, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x18, %r11
               	je	0x400bb0 <.text+0x930>
               	movl	$0x6b, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400bca <.text+0x94a>
               	movl	$0x6e, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x400bf1 <.text+0x971>
               	movl	$0x6f, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400c0b <.text+0x98b>
               	movl	$0x78, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x400c32 <.text+0x9b2>
               	movl	$0x79, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400c4c <.text+0x9cc>
               	movl	$0x82, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x400c73 <.text+0x9f3>
               	movl	$0x83, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400c8d <.text+0xa0d>
               	movl	$0x8c, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400ca6 <.text+0xa26>
               	movl	$0x8d, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	0x400cc9 <.text+0xa49>
               	movl	$0x8e, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x8, %rax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	je	0x400cec <.text+0xa6c>
               	movl	$0x8f, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400d02 <.text+0xa82>
               	movl	$0x96, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400d18 <.text+0xa98>
               	movl	$0x97, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x400d35 <.text+0xab5>
               	movl	$0x98, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x400d5c <.text+0xadc>
               	movl	$0x99, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x9, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x9, %r11
               	je	0x400d83 <.text+0xb03>
               	movl	$0x9a, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400d9d <.text+0xb1d>
               	movl	$0xa0, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400db6 <.text+0xb36>
               	movl	$0xa1, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	0x400dd9 <.text+0xb59>
               	movl	$0xa2, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	cmpq	$0xa, %rax
               	je	0x400dfc <.text+0xb7c>
               	movl	$0xa3, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0xc, %rax
               	movslq	%eax, %rax
               	cmpq	$0xc, %rax
               	je	0x400e1f <.text+0xb9f>
               	movl	$0xa4, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, 0x41(%rdx)
