
c5_vprintf.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400f73 <.text+0xc83>
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
               	callq	0x401307 <malloc>
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
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x18(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x4005c2 <.text+0x2d2>
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r14
               	subq	$0x1, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	0x28(%rsp), %r14
               	addq	%rax, %r14
               	movl	$0x2d, %eax
               	movb	%al, (%r14)
               	jmp	0x4005c2 <.text+0x2d2>
               	movl	$0x1f, %eax
               	movslq	-0x10(%rbp), %r12
               	movq	%rax, %r14
               	subq	%r12, %r14
               	movslq	%r14d, %r15
               	movq	0x28(%rsp), %r14
               	addq	%r12, %r14
               	movslq	%r15d, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40130d <write>
               	movslq	%eax, %rax
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x401313 <free>
               	movslq	%eax, %rax
               	movslq	%r15d, %rax
               	movq	%rax, %rcx
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
               	callq	0x401307 <malloc>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movl	$0x1f, %r14d
               	movl	$0x10, %r15d
               	movq	%r14, %rsi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	0x28(%rsp), %rdi
               	callq	0x400307 <.text+0x17>
               	movslq	%eax, %r15
               	movq	%r14, %rax
               	subq	%r15, %rax
               	movslq	%eax, %r12
               	movq	0x28(%rsp), %r14
               	addq	%r15, %r14
               	movslq	%r12d, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40130d <write>
               	movslq	%eax, %rax
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x401313 <free>
               	movslq	%eax, %rax
               	movslq	%r12d, %rax
               	movq	%rax, %rcx
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
               	leaq	0xf9d1(%rip), %r12      # 0x410100
               	movl	$0x2, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x40130d <write>
               	movslq	%eax, %rax
               	movl	$0x11, %r15d
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x401307 <malloc>
               	movq	%rax, %r12
               	movq	%r12, %r15
               	addq	$0x10, %r15
               	xorq	%r14, %r14
               	movb	%r14b, (%r15)
               	movl	$0xf, %esi
               	movl	%esi, -0x10(%rbp)
               	jmp	0x400778 <.text+0x488>
               	movslq	-0x10(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	jl	0x4007b1 <.text+0x4c1>
               	movslq	0x20(%rbp), %rsi
               	movq	%rsi, %r14
               	andq	$0xf, %r14
               	movl	%r14d, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rsi
               	cmpq	$0xa, %rsi
               	jge	0x400862 <.text+0x572>
               	jmp	0x400809 <.text+0x519>
               	movl	$0x10, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x40130d <write>
               	movslq	%eax, %rax
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x401313 <free>
               	movslq	%eax, %rax
               	movl	$0x12, %eax
               	movq	%rax, %rcx
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
               	jmp	0x40082c <.text+0x53c>
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
               	jmp	0x400778 <.text+0x488>
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
               	jmp	0x40082c <.text+0x53c>
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
               	jne	0x400905 <.text+0x615>
               	leaq	0xf839(%rip), %r14      # 0x410103
               	movl	$0x6, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40130d <write>
               	movslq	%eax, %rax
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400910 <.text+0x620>
               	movslq	-0x8(%rbp), %rax
               	movq	%r12, %r15
               	addq	%rax, %r15
               	movzbq	(%r15), %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	cmpq	$0x0, %r15
               	je	0x40094d <.text+0x65d>
               	movslq	-0x8(%rbp), %r15
               	movq	%r15, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400910 <.text+0x620>
               	movslq	-0x8(%rbp), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x40130d <write>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
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
               	jmp	0x4009e5 <.text+0x6f5>
               	movslq	-0x10(%rbp), %rdi
               	movq	0x28(%rsp), %r8
               	addq	%rdi, %r8
               	movzbq	(%r8), %rdi
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rdi, %r8
               	cmpq	$0x0, %r8
               	je	0x400a48 <.text+0x758>
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
               	je	0x400ad3 <.text+0x7e3>
               	jmp	0x400a79 <.text+0x789>
               	movslq	-0x8(%rbp), %r15
               	movq	%r15, %rcx
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
               	callq	0x40130d <write>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	jmp	0x400ace <.text+0x7de>
               	jmp	0x4009e5 <.text+0x6f5>
               	movslq	-0x10(%rbp), %r15
               	movq	%r15, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %r15
               	movq	0x28(%rsp), %rax
               	addq	%r15, %rax
               	movzbq	(%rax), %r15
               	movb	%r15b, -0x18(%rbp)
               	movzbq	-0x18(%rbp), %rax
               	movq	%rax, %r15
               	xorq	$0x64, %r15
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r15, %rax
               	cmpq	$0x0, %rax
               	jne	0x400b6b <.text+0x87b>
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %r15
               	movq	(%r15), %rax
               	leaq	0x10(%rax), %r11
               	movq	%r11, (%r15)
               	movslq	(%rax), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x4004cd <.text+0x1dd>
               	movq	%r14, %r15
               	addq	%rax, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	jmp	0x400b66 <.text+0x876>
               	jmp	0x400ace <.text+0x7de>
               	movzbq	-0x18(%rbp), %r15
               	movq	%r15, %rax
               	xorq	$0x75, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	cmpq	$0x0, %r15
               	jne	0x400bdc <.text+0x8ec>
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %rax
               	movq	(%rax), %r15
               	leaq	0x10(%r15), %r11
               	movq	%r11, (%rax)
               	movslq	(%r15), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x4004cd <.text+0x1dd>
               	movq	%r14, %r12
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	0x400bd7 <.text+0x8e7>
               	jmp	0x400b66 <.text+0x876>
               	movzbq	-0x18(%rbp), %r12
               	movq	%r12, %rax
               	xorq	$0x78, %rax
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	cmpq	$0x0, %r12
               	jne	0x400c4d <.text+0x95d>
               	movslq	-0x8(%rbp), %r15
               	leaq	0x30(%rbp), %rax
               	movq	(%rax), %r14
               	leaq	0x10(%r14), %r11
               	movq	%r11, (%rax)
               	movslq	(%r14), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400631 <.text+0x341>
               	movq	%r15, %r12
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	0x400c48 <.text+0x958>
               	jmp	0x400bd7 <.text+0x8e7>
               	movzbq	-0x18(%rbp), %r12
               	movq	%r12, %rax
               	xorq	$0x70, %rax
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	cmpq	$0x0, %r12
               	jne	0x400cbe <.text+0x9ce>
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %rax
               	movq	(%rax), %r15
               	leaq	0x10(%r15), %r11
               	movq	%r11, (%rax)
               	movslq	(%r15), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x4006ea <.text+0x3fa>
               	movq	%r14, %r12
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	0x400cb9 <.text+0x9c9>
               	jmp	0x400c48 <.text+0x958>
               	movzbq	-0x18(%rbp), %r12
               	movq	%r12, %rax
               	xorq	$0x63, %rax
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	cmpq	$0x0, %r12
               	jne	0x400d4b <.text+0xa5b>
               	leaq	0x30(%rbp), %r12
               	movq	(%r12), %rax
               	leaq	0x10(%rax), %r11
               	movq	%r11, (%r12)
               	movslq	(%rax), %r12
               	movb	%r12b, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r15
               	movl	$0x1, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x40130d <write>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %r14
               	addq	$0x1, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r14
               	addq	$0x1, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x10(%rbp)
               	jmp	0x400d46 <.text+0xa56>
               	jmp	0x400cb9 <.text+0x9c9>
               	movzbq	-0x18(%rbp), %r14
               	movq	%r14, %rax
               	xorq	$0x73, %rax
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rax, %r14
               	cmpq	$0x0, %r14
               	jne	0x400dbc <.text+0xacc>
               	movslq	-0x8(%rbp), %r12
               	leaq	0x30(%rbp), %rax
               	movq	(%rax), %r15
               	leaq	0x10(%r15), %r11
               	movq	%r11, (%rax)
               	movq	(%r15), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	0x400892 <.text+0x5a2>
               	movq	%r12, %r14
               	addq	%rax, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r14
               	addq	$0x1, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x10(%rbp)
               	jmp	0x400db7 <.text+0xac7>
               	jmp	0x400d46 <.text+0xa56>
               	movzbq	-0x18(%rbp), %r14
               	movq	%r14, %rax
               	xorq	$0x25, %rax
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rax, %r14
               	cmpq	$0x0, %r14
               	jne	0x400e3c <.text+0xb4c>
               	movl	$0x25, %r14d
               	movb	%r14b, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r15
               	movl	$0x1, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x40130d <write>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	0x400e37 <.text+0xb47>
               	jmp	0x400db7 <.text+0xac7>
               	movzbq	-0x18(%rbp), %r12
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	cmpq	$0x0, %rax
               	jne	0x400e60 <.text+0xb70>
               	jmp	0x400e5b <.text+0xb6b>
               	jmp	0x400e37 <.text+0xb47>
               	movl	$0x25, %eax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r14
               	movl	$0x1, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40130d <write>
               	movslq	%eax, %rax
               	movzbq	-0x18(%rbp), %rax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r15
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x40130d <write>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x2, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	jmp	0x400e5b <.text+0xb6b>
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
               	jmp	0x40098a <.text+0x69a>
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
               	callq	0x400ed5 <.text+0xbe5>
               	leaq	-0x8(%rbp), %r12
               	movslq	%eax, %rbx
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
               	leaq	0xf180(%rip), %rbx      # 0x410118
               	leaq	0xf1aa(%rip), %r12      # 0x410149
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
               	callq	0x400f1e <.text+0xc2e>
               	addq	$0x50, %rsp
               	movslq	%eax, %r15
               	cmpq	$0x0, %r15
               	jg	0x401036 <.text+0xd46>
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
               	leaq	0xf112(%rip), %rbx      # 0x41014f
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	0x400f1e <.text+0xc2e>
               	addq	$0x10, %rsp
               	movslq	%eax, %rbx
               	cmpq	$0x0, %rbx
               	je	0x40108b <.text+0xd9b>
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
               	leaq	0xf0be(%rip), %r15      # 0x410150
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	callq	0x400f1e <.text+0xc2e>
               	addq	$0x10, %rsp
               	movslq	%eax, %r15
               	cmpq	$0x0, %r15
               	je	0x4010e1 <.text+0xdf1>
               	movl	$0x3, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf06a(%rip), %rbx      # 0x410152
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	0x400f1e <.text+0xc2e>
               	addq	$0x10, %rsp
               	movslq	%eax, %rbx
               	cmpq	$0x3, %rbx
               	je	0x401136 <.text+0xe46>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf019(%rip), %r15      # 0x410156
               	xorq	%r12, %r12
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	callq	0x400f1e <.text+0xc2e>
               	addq	$0x20, %rsp
               	movslq	%eax, %r12
               	cmpq	$0x13, %r12
               	je	0x40119a <.text+0xeaa>
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
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
