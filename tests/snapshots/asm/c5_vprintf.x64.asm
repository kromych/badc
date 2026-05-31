
c5_vprintf.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
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
               	addq	%r11, %r8
               	xorq	%r9, %r9
               	movb	%r9b, (%r8)
               	movslq	0x30(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	movslq	-0x8(%rbp), %r9
               	subq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rsi
               	addq	%r11, %rsi
               	movl	$0x30, %r9d
               	movb	%r9b, (%rsi)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>
               	movslq	0x30(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	cmpq	$0xa, %rdi
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	movslq	0x30(%rbp), %r9
               	movl	$0xa, %eax
               	movq	%rax, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	movl	%esi, -0x10(%rbp)
               	movq	%rax, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movl	%r9d, 0x30(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	subq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rdx
               	cmpq	$0xa, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	0x30(%rbp), %r9
               	movq	%r9, %rax
               	andq	$0xf, %rax
               	movl	%eax, -0x10(%rbp)
               	sarq	$0x4, %r9
               	movabsq	$0xfffffffffffffff, %r10 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r10, %r9
               	movl	%r9d, 0x30(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	addq	%r11, %r9
               	movslq	-0x10(%rbp), %rdx
               	addq	$0x30, %rdx
               	movslq	%edx, %rdx
               	movb	%dl, (%r9)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	addq	%r11, %rdx
               	movslq	-0x10(%rbp), %rax
               	addq	$0x61, %rax
               	movslq	%eax, %rax
               	subq	$0xa, %rax
               	movslq	%eax, %rax
               	movb	%al, (%rdx)
               	jmp	<addr>
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
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	xorq	%r12, %r12
               	movl	%r12d, -0x18(%rbp)
               	movslq	0x20(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	jge	<addr>
               	movl	$0x1, %r12d
               	movl	%r12d, -0x18(%rbp)
               	movslq	0x20(%rbp), %rdi
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rdi
               	movl	%edi, 0x20(%rbp)
               	jmp	<addr>
               	movl	$0x1f, %r15d
               	movslq	0x20(%rbp), %r12
               	movl	$0xa, %r14d
               	movq	%r15, %rsi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	0x28(%rsp), %rdi
               	callq	<addr>
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x18(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	movslq	-0x10(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %r14
               	movq	0x28(%rsp), %r14
               	addq	%r14, %r14
               	movl	$0x2d, %eax
               	movb	%al, (%r14)
               	jmp	<addr>
               	movl	$0x1f, %eax
               	movslq	-0x10(%rbp), %r12
               	subq	%r12, %rax
               	movslq	%eax, %r15
               	movq	0x28(%rsp), %r12
               	addq	%r12, %r12
               	movslq	%r15d, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r15d, %r15
               	movq	%r15, %rcx
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
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movl	$0x1f, %r14d
               	movl	$0x10, %r15d
               	movq	%r14, %rsi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	0x28(%rsp), %rdi
               	callq	<addr>
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
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
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
               	leaq	<rip>, %r12
               	movl	$0x2, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x11, %r15d
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%r12, %r15
               	addq	$0x10, %r15
               	xorq	%r14, %r14
               	movb	%r14b, (%r15)
               	movl	$0xf, %esi
               	movl	%esi, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	jl	<addr>
               	movslq	0x20(%rbp), %r14
               	andq	$0xf, %r14
               	movl	%r14d, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rsi
               	cmpq	$0xa, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x10, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
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
               	addq	%r12, %r14
               	movslq	-0x18(%rbp), %rsi
               	addq	$0x30, %rsi
               	movslq	%esi, %rsi
               	movb	%sil, (%r14)
               	jmp	<addr>
               	movslq	0x20(%rbp), %r15
               	sarq	$0x4, %r15
               	movabsq	$0xfffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r11, %r15
               	movl	%r15d, 0x20(%rbp)
               	movslq	-0x10(%rbp), %r14
               	subq	$0x1, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rsi
               	addq	%r12, %rsi
               	movslq	-0x18(%rbp), %r15
               	addq	$0x61, %r15
               	movslq	%r15d, %r15
               	subq	$0xa, %r15
               	movslq	%r15d, %r15
               	movb	%r15b, (%rsi)
               	jmp	<addr>
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
               	jne	<addr>
               	leaq	<rip>, %r14
               	movl	$0x6, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
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
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	%r12, %rax
               	movzbq	(%rax), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	je	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
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
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdi
               	movq	0x28(%rsp), %rdi
               	addq	%rdi, %rdi
               	movzbq	(%rdi), %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movslq	-0x10(%rbp), %rdi
               	movq	0x28(%rsp), %rdi
               	addq	%rdi, %rdi
               	movzbq	(%rdi), %r8
               	movb	%r8b, -0x18(%rbp)
               	movzbq	-0x18(%rbp), %rdi
               	xorq	$0x25, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
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
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	0x28(%rsp), %rax
               	addq	%rax, %rax
               	movzbq	(%rax), %r15
               	movb	%r15b, -0x18(%rbp)
               	movzbq	-0x18(%rbp), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %rax
               	movq	(%rax), %r15
               	leaq	0x10(%r15), %r11
               	movq	%r11, (%rax)
               	movslq	(%r15), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%rax, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x18(%rbp), %rax
               	xorq	$0x75, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	-0x8(%rbp), %r15
               	leaq	0x30(%rbp), %rax
               	movq	(%rax), %r12
               	leaq	0x10(%r12), %r11
               	movq	%r11, (%rax)
               	movslq	(%r12), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	<addr>
               	addq	%rax, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x18(%rbp), %rax
               	xorq	$0x78, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	-0x8(%rbp), %r12
               	leaq	0x30(%rbp), %rax
               	movq	(%rax), %r14
               	leaq	0x10(%r14), %r11
               	movq	%r11, (%rax)
               	movslq	(%r14), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	<addr>
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x18(%rbp), %rax
               	xorq	$0x70, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %rax
               	movq	(%rax), %r15
               	leaq	0x10(%r15), %r11
               	movq	%r11, (%rax)
               	movslq	(%r15), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%rax, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x18(%rbp), %rax
               	xorq	$0x63, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	0x30(%rbp), %r14
               	movq	(%r14), %rax
               	leaq	0x10(%rax), %r11
               	movq	%r11, (%r14)
               	movslq	(%rax), %r14
               	movb	%r14b, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r15
               	movl	$0x1, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x18(%rbp), %r12
               	xorq	$0x73, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %r12
               	movq	(%r12), %r15
               	leaq	0x10(%r15), %r11
               	movq	%r11, (%r12)
               	movq	(%r15), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%rax, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x18(%rbp), %rax
               	xorq	$0x25, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x25, %r14d
               	movb	%r14b, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r15
               	movl	$0x1, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x18(%rbp), %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x25, %eax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r14
               	movl	$0x1, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movzbq	-0x18(%rbp), %rax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r15
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %r15
               	addq	$0x1, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x10(%rbp)
               	jmp	<addr>
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
               	jmp	<addr>
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
               	callq	<addr>
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
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r12
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
               	callq	<addr>
               	addq	$0x50, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jg	<addr>
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
               	leaq	<rip>, %rbx
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
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
               	leaq	<rip>, %r15
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
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
               	leaq	<rip>, %rbx
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
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
               	leaq	<rip>, %r15
               	xorq	%r12, %r12
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x13, %rax
               	je	<addr>
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
