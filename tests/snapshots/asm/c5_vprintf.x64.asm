
c5_vprintf.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400fbe <.text+0xcce>
               	movq	%rax, %rdi
               	callq	*0xfde1(%rip)           # 0x4100e8
               	popq	%r10
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	movslq	%edx, %r8
               	movl	%r8d, 0x30(%rbp)
               	movslq	%ecx, %rdi
               	movl	%r9d, -0x8(%rbp)
               	movslq	-0x8(%rbp), %r8
               	movq	%r11, %r9
               	addq	%r8, %r9
               	xorq	%r8, %r8
               	movb	%r8b, (%r9)
               	movslq	0x30(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	jne	0x4003aa <.text+0xba>
               	movslq	-0x8(%rbp), %rsi
               	movq	%rsi, %r8
               	subq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rsi
               	movq	%r11, %r8
               	addq	%rsi, %r8
               	movl	$0x30, %esi
               	movb	%sil, (%r8)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	jmp	0x4003af <.text+0xbf>
               	movslq	0x30(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	je	0x4003d2 <.text+0xe2>
               	cmpq	$0xa, %rdi
               	jne	0x400448 <.text+0x158>
               	jmp	0x4003ed <.text+0xfd>
               	movslq	-0x8(%rbp), %rsi
               	movq	%rsi, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	movslq	0x30(%rbp), %rax
               	movl	$0xa, %esi
               	movq	%rsi, %r10
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movl	%r8d, -0x10(%rbp)
               	movq	%rsi, %r10
               	pushq	%rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%edx, 0x30(%rbp)
               	jmp	0x40041e <.text+0x12e>
               	movslq	-0x8(%rbp), %rdx
               	movq	%rdx, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rdx
               	cmpq	$0xa, %rdx
               	jge	0x40049d <.text+0x1ad>
               	jmp	0x400475 <.text+0x185>
               	movslq	0x30(%rbp), %rdx
               	movq	%rdx, %rsi
               	andq	$0xf, %rsi
               	movl	%esi, -0x10(%rbp)
               	movq	%rdx, %rax
               	sarq	$0x4, %rax
               	movabsq	$0xfffffffffffffff, %rdx # imm = 0xFFFFFFFFFFFFFFF
               	andq	%rax, %rdx
               	movl	%edx, 0x30(%rbp)
               	jmp	0x40041e <.text+0x12e>
               	movslq	-0x8(%rbp), %rdx
               	movq	%r11, %rax
               	addq	%rdx, %rax
               	movslq	-0x10(%rbp), %rdx
               	movq	%rdx, %rsi
               	addq	$0x30, %rsi
               	movslq	%esi, %rsi
               	movb	%sil, (%rax)
               	jmp	0x400498 <.text+0x1a8>
               	jmp	0x4003af <.text+0xbf>
               	movslq	-0x8(%rbp), %rsi
               	movq	%r11, %rdx
               	addq	%rsi, %rdx
               	movslq	-0x10(%rbp), %rsi
               	movq	%rsi, %rax
               	addq	$0x61, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	subq	$0xa, %rsi
               	movslq	%esi, %rsi
               	movb	%sil, (%rdx)
               	jmp	0x400498 <.text+0x1a8>
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movslq	%edi, %rbx
               	movslq	%esi, %r9
               	movl	%r9d, 0x20(%rbp)
               	movl	$0x20, %r12d
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x401357 <malloc>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	xorq	%r12, %r12
               	movl	%r12d, -0x18(%rbp)
               	movslq	0x20(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	jge	0x40055d <.text+0x26d>
               	movl	$0x1, %edi
               	movl	%edi, -0x18(%rbp)
               	movslq	0x20(%rbp), %r12
               	movabsq	$-0x1, %rdi
               	imulq	%r12, %rdi
               	movl	%edi, 0x20(%rbp)
               	jmp	0x40055d <.text+0x26d>
               	movl	$0x1f, %r15d
               	movslq	0x20(%rbp), %r12
               	movl	$0xa, %r14d
               	movq	%r15, %rsi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	0x28(%rsp), %rdi
               	callq	0x400307 <.text+0x17>
               	movq	%rax, %rsi
               	movl	%esi, -0x10(%rbp)
               	movslq	-0x18(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x4005c5 <.text+0x2d5>
               	movslq	-0x10(%rbp), %rsi
               	movq	%rsi, %r14
               	subq	$0x1, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rsi
               	movq	0x28(%rsp), %r14
               	addq	%rsi, %r14
               	movl	$0x2d, %esi
               	movb	%sil, (%r14)
               	jmp	0x4005c5 <.text+0x2d5>
               	movl	$0x1f, %esi
               	movslq	-0x10(%rbp), %r12
               	movq	%rsi, %r14
               	subq	%r12, %r14
               	movslq	%r14d, %r15
               	movq	0x28(%rsp), %r14
               	addq	%r12, %r14
               	movslq	%r15d, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40135d <write>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x401363 <free>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movslq	%r15d, %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movslq	%edi, %rbx
               	movslq	%esi, %r12
               	movl	$0x20, %r14d
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x401357 <malloc>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movl	$0x1f, %r14d
               	movl	$0x10, %r15d
               	movq	%r14, %rsi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	0x28(%rsp), %rdi
               	callq	0x400307 <.text+0x17>
               	movq	%rax, %rsi
               	movslq	%esi, %r15
               	movq	%r14, %rsi
               	subq	%r15, %rsi
               	movslq	%esi, %r12
               	movq	0x28(%rsp), %r14
               	addq	%r15, %r14
               	movslq	%r12d, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40135d <write>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x401363 <free>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movslq	%r12d, %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movslq	%edi, %rbx
               	movslq	%esi, %r9
               	movl	%r9d, 0x20(%rbp)
               	leaq	0xf9bf(%rip), %r12      # 0x410100
               	movl	$0x2, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x40135d <write>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movl	$0x11, %r15d
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x401357 <malloc>
               	movq	%rax, %r12
               	movq	%r12, %r15
               	addq	$0x10, %r15
               	xorq	%r14, %r14
               	movb	%r14b, (%r15)
               	movl	$0xf, %esi
               	movl	%esi, -0x10(%rbp)
               	jmp	0x40078d <.text+0x49d>
               	movslq	-0x10(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	jl	0x4007c6 <.text+0x4d6>
               	movslq	0x20(%rbp), %rsi
               	movq	%rsi, %r14
               	andq	$0xf, %r14
               	movl	%r14d, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rsi
               	cmpq	$0xa, %rsi
               	jge	0x40087e <.text+0x58e>
               	jmp	0x400825 <.text+0x535>
               	movl	$0x10, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x40135d <write>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x401363 <free>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x12, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movslq	-0x10(%rbp), %rsi
               	movq	%r12, %r14
               	addq	%rsi, %r14
               	movslq	-0x18(%rbp), %rsi
               	movq	%rsi, %r15
               	addq	$0x30, %r15
               	movslq	%r15d, %r15
               	movb	%r15b, (%r14)
               	jmp	0x400848 <.text+0x558>
               	movslq	0x20(%rbp), %r15
               	movq	%r15, %r14
               	sarq	$0x4, %r14
               	movabsq	$0xfffffffffffffff, %r15 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r14, %r15
               	movl	%r15d, 0x20(%rbp)
               	movslq	-0x10(%rbp), %r14
               	movq	%r14, %r15
               	subq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	jmp	0x40078d <.text+0x49d>
               	movslq	-0x10(%rbp), %r15
               	movq	%r12, %rsi
               	addq	%r15, %rsi
               	movslq	-0x18(%rbp), %r15
               	movq	%r15, %r14
               	addq	$0x61, %r14
               	movslq	%r14d, %r14
               	movq	%r14, %r15
               	subq	$0xa, %r15
               	movslq	%r15d, %r15
               	movb	%r15b, (%rsi)
               	jmp	0x400848 <.text+0x558>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movslq	%edi, %rbx
               	movq	%rsi, %r12
               	cmpq	$0x0, %r12
               	jne	0x400924 <.text+0x634>
               	leaq	0xf81d(%rip), %r14      # 0x410103
               	movl	$0x6, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40135d <write>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movl	%esi, -0x8(%rbp)
               	jmp	0x40092f <.text+0x63f>
               	movslq	-0x8(%rbp), %rsi
               	movq	%r12, %r15
               	addq	%rsi, %r15
               	movzbq	(%r15), %rsi
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rsi, %r15
               	cmpq	$0x0, %r15
               	je	0x40096c <.text+0x67c>
               	movslq	-0x8(%rbp), %r15
               	movq	%r15, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x8(%rbp)
               	jmp	0x40092f <.text+0x63f>
               	movslq	-0x8(%rbp), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x40135d <write>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movslq	-0x8(%rbp), %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movslq	%edi, %rbx
               	movq	%rsi, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%rdx, %r8
               	movq	%r8, 0x30(%rbp)
               	xorq	%rdi, %rdi
               	movl	%edi, -0x8(%rbp)
               	movl	%edi, -0x10(%rbp)
               	jmp	0x400a07 <.text+0x717>
               	movslq	-0x10(%rbp), %rdi
               	movq	0x28(%rsp), %r8
               	addq	%rdi, %r8
               	movzbq	(%r8), %rdi
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rdi, %r8
               	cmpq	$0x0, %r8
               	je	0x400a6a <.text+0x77a>
               	movslq	-0x10(%rbp), %r8
               	movq	0x28(%rsp), %rdi
               	addq	%r8, %rdi
               	movzbq	(%rdi), %r8
               	movb	%r8b, -0x18(%rbp)
               	movzbq	-0x18(%rbp), %rdi
               	movq	%rdi, %r8
               	xorq	$0x25, %r8
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r8, %rdi
               	cmpq	$0x0, %rdi
               	je	0x400af8 <.text+0x808>
               	jmp	0x400a9b <.text+0x7ab>
               	movslq	-0x8(%rbp), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	movzbq	-0x18(%rbp), %rdi
               	movb	%dil, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r14
               	movl	$0x1, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40135d <write>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movslq	-0x8(%rbp), %rsi
               	movq	%rsi, %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rsi
               	movq	%rsi, %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	jmp	0x400af3 <.text+0x803>
               	jmp	0x400a07 <.text+0x717>
               	movslq	-0x10(%rbp), %r15
               	movq	%r15, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x10(%rbp)
               	movslq	-0x10(%rbp), %r15
               	movq	0x28(%rsp), %rsi
               	addq	%r15, %rsi
               	movzbq	(%rsi), %r15
               	movb	%r15b, -0x18(%rbp)
               	movzbq	-0x18(%rbp), %rsi
               	movq	%rsi, %r15
               	xorq	$0x64, %r15
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%r15, %rsi
               	cmpq	$0x0, %rsi
               	jne	0x400b93 <.text+0x8a3>
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %r15
               	movq	(%r15), %rsi
               	leaq	0x10(%rsi), %r11
               	movq	%r11, (%r15)
               	movslq	(%rsi), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x4004cd <.text+0x1dd>
               	movq	%rax, %rsi
               	movq	%r14, %r15
               	addq	%rsi, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rsi
               	movq	%rsi, %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	jmp	0x400b8e <.text+0x89e>
               	jmp	0x400af3 <.text+0x803>
               	movzbq	-0x18(%rbp), %r15
               	movq	%r15, %rsi
               	xorq	$0x75, %rsi
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rsi, %r15
               	cmpq	$0x0, %r15
               	jne	0x400c07 <.text+0x917>
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %rsi
               	movq	(%rsi), %r15
               	leaq	0x10(%r15), %r11
               	movq	%r11, (%rsi)
               	movslq	(%r15), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x4004cd <.text+0x1dd>
               	movq	%rax, %r15
               	movq	%r14, %r12
               	addq	%r15, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	0x400c02 <.text+0x912>
               	jmp	0x400b8e <.text+0x89e>
               	movzbq	-0x18(%rbp), %r12
               	movq	%r12, %r15
               	xorq	$0x78, %r15
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	cmpq	$0x0, %r12
               	jne	0x400c7d <.text+0x98d>
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %r15
               	movq	(%r15), %r12
               	leaq	0x10(%r12), %r11
               	movq	%r11, (%r15)
               	movslq	(%r12), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x40063a <.text+0x34a>
               	movq	%rax, %r12
               	movq	%r14, %r15
               	addq	%r12, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	jmp	0x400c78 <.text+0x988>
               	jmp	0x400c02 <.text+0x912>
               	movzbq	-0x18(%rbp), %r15
               	movq	%r15, %r12
               	xorq	$0x70, %r12
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	$0x0, %r15
               	jne	0x400cf3 <.text+0xa03>
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %r12
               	movq	(%r12), %r15
               	leaq	0x10(%r15), %r11
               	movq	%r11, (%r12)
               	movslq	(%r15), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x4006fc <.text+0x40c>
               	movq	%rax, %r15
               	movq	%r14, %r12
               	addq	%r15, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	0x400cee <.text+0x9fe>
               	jmp	0x400c78 <.text+0x988>
               	movzbq	-0x18(%rbp), %r12
               	movq	%r12, %r15
               	xorq	$0x63, %r15
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	cmpq	$0x0, %r12
               	jne	0x400d83 <.text+0xa93>
               	leaq	0x30(%rbp), %r12
               	movq	(%r12), %r15
               	leaq	0x10(%r15), %r11
               	movq	%r11, (%r12)
               	movslq	(%r15), %r12
               	movb	%r12b, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r14
               	movl	$0x1, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40135d <write>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movslq	-0x8(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	jmp	0x400d7e <.text+0xa8e>
               	jmp	0x400cee <.text+0x9fe>
               	movzbq	-0x18(%rbp), %r15
               	movq	%r15, %r12
               	xorq	$0x73, %r12
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	$0x0, %r15
               	jne	0x400df9 <.text+0xb09>
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %r12
               	movq	(%r12), %r15
               	leaq	0x10(%r15), %r11
               	movq	%r11, (%r12)
               	movq	(%r15), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x4008ae <.text+0x5be>
               	movq	%rax, %r15
               	movq	%r14, %r12
               	addq	%r15, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	0x400df4 <.text+0xb04>
               	jmp	0x400d7e <.text+0xa8e>
               	movzbq	-0x18(%rbp), %r12
               	movq	%r12, %r15
               	xorq	$0x25, %r15
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	cmpq	$0x0, %r12
               	jne	0x400e7c <.text+0xb8c>
               	movl	$0x25, %r12d
               	movb	%r12b, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r14
               	movl	$0x1, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40135d <write>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movslq	-0x8(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	jmp	0x400e77 <.text+0xb87>
               	jmp	0x400df4 <.text+0xb04>
               	movzbq	-0x18(%rbp), %r15
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	cmpq	$0x0, %r12
               	jne	0x400ea1 <.text+0xbb1>
               	jmp	0x400e9c <.text+0xbac>
               	jmp	0x400e77 <.text+0xb87>
               	movl	$0x25, %r12d
               	movb	%r12b, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r14
               	movl	$0x1, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40135d <write>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movzbq	-0x18(%rbp), %r12
               	movb	%r12b, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x40135d <write>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movslq	-0x8(%rbp), %r14
               	movq	%r14, %r12
               	addq	$0x2, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r14
               	movq	%r14, %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	0x400e9c <.text+0xbac>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movl	$0x1, %r14d
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	jmp	0x4009ac <.text+0x6bc>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x8(%rbp), %r11
               	leaq	0x10(%rbp), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	movq	0x10(%rbp), %rbx
               	movq	-0x8(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400f1d <.text+0xc2d>
               	movq	%rax, %r11
               	leaq	-0x8(%rbp), %r12
               	movslq	%r11d, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xf135(%rip), %rbx      # 0x410118
               	leaq	0xf15f(%rip), %r12      # 0x410149
               	movl	$0x2a, %r14d
               	movl	$0x41, %r10d
               	movq	%r10, 0x28(%rsp)
               	movl	$0xff, %r15d
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	movq	0x38(%rsp), %r10
               	subq	$0x10, %rsp
               	movq	%r10, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r14, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	0x400f66 <.text+0xc76>
               	addq	$0x50, %rsp
               	movq	%rax, %rsi
               	movslq	%esi, %r15
               	cmpq	$0x0, %r15
               	jg	0x401084 <.text+0xd94>
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf0c4(%rip), %rbx      # 0x41014f
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	0x400f66 <.text+0xc76>
               	addq	$0x10, %rsp
               	movq	%rax, %r15
               	movslq	%r15d, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4010dc <.text+0xdec>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf06d(%rip), %r12      # 0x410150
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	callq	0x400f66 <.text+0xc76>
               	addq	$0x10, %rsp
               	movq	%rax, %rbx
               	movslq	%ebx, %r12
               	cmpq	$0x0, %r12
               	je	0x401135 <.text+0xe45>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf016(%rip), %r15      # 0x410152
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	callq	0x400f66 <.text+0xc76>
               	addq	$0x10, %rsp
               	movq	%rax, %r12
               	movslq	%r12d, %r15
               	cmpq	$0x3, %r15
               	je	0x40118e <.text+0xe9e>
               	movl	$0x4, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0xefc1(%rip), %rbx      # 0x410156
               	xorq	%r12, %r12
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	0x400f66 <.text+0xc76>
               	addq	$0x20, %rsp
               	movq	%rax, %r14
               	movslq	%r14d, %r12
               	cmpq	$0x13, %r12
               	je	0x4011f5 <.text+0xf05>
               	movl	$0x5, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x401253 <.text+0xf63>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x4012da <.text+0xfea>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4012d1 <.text+0xfe1>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4012d5 <.text+0xfe5>
               	andb	%ch, 0x74(%rax)
               	je	0x4012e5 <.text+0xff5>
               	jae	0x4012b1 <.text+0xfc1>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4012ed <.text+0xffd>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x401369 <exit>
               	movzbq	%al, %rax
               	movq	%rax, %r9
               	xorq	%r9, %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x40130b <.text+0x101b>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x401392 <exit+0x29>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x401389 <exit+0x20>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40138d <exit+0x24>
               	andb	%ch, 0x74(%rax)
               	je	0x40139d <exit+0x34>
               	jae	0x401369 <exit>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4013a5 <exit+0x3c>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<malloc>:
               	jmpq	*0xed73(%rip)           # 0x4100d0

<write>:
               	jmpq	*0xed75(%rip)           # 0x4100d8

<free>:
               	jmpq	*0xed77(%rip)           # 0x4100e0

<exit>:
               	jmpq	*0xed79(%rip)           # 0x4100e8
