
c5_vprintf.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400ef7 <.text+0xc07>
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
               	jne	0x4003a7 <.text+0xb7>
               	movslq	-0x8(%rbp), %r8
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
               	jmp	0x4003ac <.text+0xbc>
               	movslq	0x30(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	je	0x4003cf <.text+0xdf>
               	cmpq	$0xa, %rdi
               	jne	0x400447 <.text+0x157>
               	jmp	0x4003e7 <.text+0xf7>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	movslq	0x30(%rbp), %rsi
               	movl	$0xa, %eax
               	movq	%rax, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	movl	%r8d, -0x10(%rbp)
               	movq	%rax, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, 0x30(%rbp)
               	jmp	0x400420 <.text+0x130>
               	movslq	-0x8(%rbp), %rsi
               	subq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rdx
               	cmpq	$0xa, %rdx
               	jge	0x400496 <.text+0x1a6>
               	jmp	0x400471 <.text+0x181>
               	movslq	0x30(%rbp), %rsi
               	movq	%rsi, %rax
               	andq	$0xf, %rax
               	movl	%eax, -0x10(%rbp)
               	sarq	$0x4, %rsi
               	movabsq	$0xfffffffffffffff, %r10 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r10, %rsi
               	movl	%esi, 0x30(%rbp)
               	jmp	0x400420 <.text+0x130>
               	movslq	-0x8(%rbp), %rsi
               	movq	%r11, %rdx
               	addq	%rsi, %rdx
               	movslq	-0x10(%rbp), %rsi
               	addq	$0x30, %rsi
               	movslq	%esi, %rsi
               	movb	%sil, (%rdx)
               	jmp	0x400491 <.text+0x1a1>
               	jmp	0x4003ac <.text+0xbc>
               	movslq	-0x8(%rbp), %rsi
               	movq	%r11, %rax
               	addq	%rsi, %rax
               	movslq	-0x10(%rbp), %rsi
               	addq	$0x61, %rsi
               	movslq	%esi, %rsi
               	subq	$0xa, %rsi
               	movslq	%esi, %rsi
               	movb	%sil, (%rax)
               	jmp	0x400491 <.text+0x1a1>
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
               	callq	0x401287 <malloc>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	xorq	%r12, %r12
               	movl	%r12d, -0x18(%rbp)
               	movslq	0x20(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	jge	0x400552 <.text+0x262>
               	movl	$0x1, %r12d
               	movl	%r12d, -0x18(%rbp)
               	movslq	0x20(%rbp), %rdi
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rdi
               	movl	%edi, 0x20(%rbp)
               	jmp	0x400552 <.text+0x262>
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
               	je	0x4005b4 <.text+0x2c4>
               	movslq	-0x10(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %r14
               	movq	0x28(%rsp), %rax
               	addq	%r14, %rax
               	movl	$0x2d, %r14d
               	movb	%r14b, (%rax)
               	jmp	0x4005b4 <.text+0x2c4>
               	movl	$0x1f, %r14d
               	movslq	-0x10(%rbp), %r12
               	subq	%r12, %r14
               	movslq	%r14d, %r14
               	movq	0x28(%rsp), %r15
               	addq	%r12, %r15
               	movslq	%r14d, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x40128d <write>
               	movslq	%eax, %rax
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x401293 <free>
               	movslq	%eax, %rax
               	movslq	%r14d, %r14
               	movq	%r14, %rcx
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
               	callq	0x401287 <malloc>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movl	$0x1f, %r14d
               	movl	$0x10, %r15d
               	movq	%r14, %rsi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	0x28(%rsp), %rdi
               	callq	0x400307 <.text+0x17>
               	movslq	%eax, %rax
               	subq	%rax, %r14
               	movslq	%r14d, %r14
               	movq	0x28(%rsp), %r12
               	addq	%rax, %r12
               	movslq	%r14d, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x40128d <write>
               	movslq	%eax, %rax
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x401293 <free>
               	movslq	%eax, %rax
               	movslq	%r14d, %r14
               	movq	%r14, %rcx
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
               	leaq	0xf9e4(%rip), %r12      # 0x410100
               	movl	$0x2, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x40128d <write>
               	movslq	%eax, %rax
               	movl	$0x11, %r15d
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x401287 <malloc>
               	movq	%rax, %r12
               	movq	%r12, %r15
               	addq	$0x10, %r15
               	xorq	%r14, %r14
               	movb	%r14b, (%r15)
               	movl	$0xf, %esi
               	movl	%esi, -0x10(%rbp)
               	jmp	0x400765 <.text+0x475>
               	movslq	-0x10(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	jl	0x40079b <.text+0x4ab>
               	movslq	0x20(%rbp), %r14
               	andq	$0xf, %r14
               	movl	%r14d, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rsi
               	cmpq	$0xa, %rsi
               	jge	0x400842 <.text+0x552>
               	jmp	0x4007f3 <.text+0x503>
               	movl	$0x10, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x40128d <write>
               	movslq	%eax, %rax
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x401293 <free>
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
               	movslq	-0x10(%rbp), %r14
               	movq	%r12, %rsi
               	addq	%r14, %rsi
               	movslq	-0x18(%rbp), %r14
               	addq	$0x30, %r14
               	movslq	%r14d, %r14
               	movb	%r14b, (%rsi)
               	jmp	0x400813 <.text+0x523>
               	movslq	0x20(%rbp), %r14
               	sarq	$0x4, %r14
               	movabsq	$0xfffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r11, %r14
               	movl	%r14d, 0x20(%rbp)
               	movslq	-0x10(%rbp), %rsi
               	subq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x10(%rbp)
               	jmp	0x400765 <.text+0x475>
               	movslq	-0x10(%rbp), %r14
               	movq	%r12, %r15
               	addq	%r14, %r15
               	movslq	-0x18(%rbp), %r14
               	addq	$0x61, %r14
               	movslq	%r14d, %r14
               	subq	$0xa, %r14
               	movslq	%r14d, %r14
               	movb	%r14b, (%r15)
               	jmp	0x400813 <.text+0x523>
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
               	jne	0x4008df <.text+0x5ef>
               	leaq	0xf85f(%rip), %r14      # 0x410103
               	movl	$0x6, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40128d <write>
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
               	jmp	0x4008ea <.text+0x5fa>
               	movslq	-0x8(%rbp), %rax
               	movq	%r12, %r15
               	addq	%rax, %r15
               	movzbq	(%r15), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400925 <.text+0x635>
               	movslq	-0x8(%rbp), %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x8(%rbp)
               	jmp	0x4008ea <.text+0x5fa>
               	movslq	-0x8(%rbp), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x40128d <write>
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
               	jmp	0x4009bd <.text+0x6cd>
               	movslq	-0x10(%rbp), %rdi
               	movq	0x28(%rsp), %r8
               	addq	%rdi, %r8
               	movzbq	(%r8), %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x400a1e <.text+0x72e>
               	movslq	-0x10(%rbp), %r8
               	movq	0x28(%rsp), %rdi
               	addq	%r8, %rdi
               	movzbq	(%rdi), %r8
               	movb	%r8b, -0x18(%rbp)
               	movzbq	-0x18(%rbp), %rdi
               	xorq	$0x25, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x400aa2 <.text+0x7b2>
               	jmp	0x400a4f <.text+0x75f>
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
               	movzbq	-0x18(%rbp), %r8
               	movb	%r8b, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r14
               	movl	$0x1, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40128d <write>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	jmp	0x400a9d <.text+0x7ad>
               	jmp	0x4009bd <.text+0x6cd>
               	movslq	-0x10(%rbp), %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	0x28(%rsp), %r15
               	addq	%rax, %r15
               	movzbq	(%r15), %rax
               	movb	%al, -0x18(%rbp)
               	movzbq	-0x18(%rbp), %r15
               	xorq	$0x64, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	jne	0x400b2f <.text+0x83f>
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %r15
               	movq	(%r15), %rax
               	leaq	0x10(%rax), %r11
               	movq	%r11, (%r15)
               	movslq	(%rax), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x4004c0 <.text+0x1d0>
               	addq	%rax, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	0x400b2a <.text+0x83a>
               	jmp	0x400a9d <.text+0x7ad>
               	movzbq	-0x18(%rbp), %rax
               	xorq	$0x75, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	0x400b96 <.text+0x8a6>
               	movslq	-0x8(%rbp), %r15
               	leaq	0x30(%rbp), %rax
               	movq	(%rax), %r14
               	leaq	0x10(%r14), %r11
               	movq	%r11, (%rax)
               	movslq	(%r14), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x4004c0 <.text+0x1d0>
               	addq	%rax, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	0x400b91 <.text+0x8a1>
               	jmp	0x400b2a <.text+0x83a>
               	movzbq	-0x18(%rbp), %rax
               	xorq	$0x78, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	0x400bff <.text+0x90f>
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %rax
               	movq	(%rax), %r12
               	leaq	0x10(%r12), %r11
               	movq	%r11, (%rax)
               	movslq	(%r12), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x400621 <.text+0x331>
               	addq	%rax, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	0x400bfa <.text+0x90a>
               	jmp	0x400b91 <.text+0x8a1>
               	movzbq	-0x18(%rbp), %rax
               	xorq	$0x70, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	0x400c66 <.text+0x976>
               	movslq	-0x8(%rbp), %r12
               	leaq	0x30(%rbp), %rax
               	movq	(%rax), %r15
               	leaq	0x10(%r15), %r11
               	movq	%r11, (%rax)
               	movslq	(%r15), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	0x4006d7 <.text+0x3e7>
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	0x400c61 <.text+0x971>
               	jmp	0x400bfa <.text+0x90a>
               	movzbq	-0x18(%rbp), %rax
               	xorq	$0x63, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	0x400ce9 <.text+0x9f9>
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
               	callq	0x40128d <write>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r14
               	addq	$0x1, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x10(%rbp)
               	jmp	0x400ce4 <.text+0x9f4>
               	jmp	0x400c61 <.text+0x971>
               	movzbq	-0x18(%rbp), %r14
               	xorq	$0x73, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	jne	0x400d50 <.text+0xa60>
               	movslq	-0x8(%rbp), %r12
               	leaq	0x30(%rbp), %r14
               	movq	(%r14), %r15
               	leaq	0x10(%r15), %r11
               	movq	%r11, (%r14)
               	movq	(%r15), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	0x40086c <.text+0x57c>
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	0x400d4b <.text+0xa5b>
               	jmp	0x400ce4 <.text+0x9f4>
               	movzbq	-0x18(%rbp), %rax
               	xorq	$0x25, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	0x400dc6 <.text+0xad6>
               	movl	$0x25, %r12d
               	movb	%r12b, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r15
               	movl	$0x1, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x40128d <write>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r14
               	addq	$0x1, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x10(%rbp)
               	jmp	0x400dc1 <.text+0xad1>
               	jmp	0x400d4b <.text+0xa5b>
               	movzbq	-0x18(%rbp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	jne	0x400deb <.text+0xafb>
               	jmp	0x400de6 <.text+0xaf6>
               	jmp	0x400dc1 <.text+0xad1>
               	movl	$0x25, %eax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r12
               	movl	$0x1, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x40128d <write>
               	movslq	%eax, %rax
               	movzbq	-0x18(%rbp), %rax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r15
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x40128d <write>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	jmp	0x400de6 <.text+0xaf6>
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
               	jmp	0x400962 <.text+0x672>
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
               	callq	0x400e59 <.text+0xb69>
               	leaq	-0x8(%rbp), %r12
               	movslq	%eax, %rax
               	movq	%rax, %rcx
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
               	leaq	0xf1fc(%rip), %rbx      # 0x410118
               	leaq	0xf226(%rip), %r12      # 0x410149
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
               	callq	0x400ea2 <.text+0xbb2>
               	addq	$0x50, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jg	0x400fba <.text+0xcca>
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
               	leaq	0xf18e(%rip), %rbx      # 0x41014f
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	0x400ea2 <.text+0xbb2>
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x40100f <.text+0xd1f>
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
               	leaq	0xf13a(%rip), %r15      # 0x410150
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	callq	0x400ea2 <.text+0xbb2>
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x401065 <.text+0xd75>
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
               	leaq	0xf0e6(%rip), %rbx      # 0x410152
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	0x400ea2 <.text+0xbb2>
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	0x4010ba <.text+0xdca>
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
               	leaq	0xf095(%rip), %r15      # 0x410156
               	xorq	%r12, %r12
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	callq	0x400ea2 <.text+0xbb2>
               	addq	$0x20, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x13, %rax
               	je	0x40111e <.text+0xe2e>
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
