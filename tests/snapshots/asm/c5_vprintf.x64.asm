
c5_vprintf.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movq	%rdx, %r8
               	movq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movslq	%r8d, %r8
               	movslq	%ecx, %rcx
               	movslq	%edi, %rdx
               	addq	%rax, %rdx
               	xorq	%rsi, %rsi
               	movb	%sil, (%rdx)
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movslq	%edi, %rcx
               	subq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	movl	$0x30, %edx
               	movb	%dl, (%rax)
               	movslq	%ecx, %rax
               	retq
               	jmp	<addr>
               	movslq	%r8d, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	cmpq	$0xa, %rcx
               	jne	<addr>
               	jmp	<addr>
               	movslq	%edi, %rax
               	retq
               	movslq	%r8d, %rdx
               	movl	$0xa, %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %r9
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	jmp	<addr>
               	movslq	%edi, %rdx
               	subq	$0x1, %rdx
               	movslq	%edx, %rdi
               	movslq	%r9d, %rdx
               	cmpq	$0xa, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%r8d, %rdx
               	movq	%rdx, %r9
               	andq	$0xf, %r9
               	sarq	$0x4, %rdx
               	movabsq	$0xfffffffffffffff, %r8 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%rdx, %r8
               	jmp	<addr>
               	movslq	%edi, %rdx
               	addq	%rax, %rdx
               	movslq	%r9d, %rsi
               	addq	$0x30, %rsi
               	movslq	%esi, %rsi
               	movb	%sil, (%rdx)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%edi, %rdx
               	addq	%rax, %rdx
               	movslq	%r9d, %rsi
               	addq	$0x61, %rsi
               	movslq	%esi, %rsi
               	subq	$0xa, %rsi
               	movslq	%esi, %rsi
               	movb	%sil, (%rdx)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r15
               	movslq	%ebx, %rbx
               	movslq	%r15d, %r15
               	movl	$0x20, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	xorq	%r14, %r14
               	cmpq	$0x0, %r15
               	jge	<addr>
               	movl	$0x1, %r14d
               	imulq	$-0x1, %r15, %r15
               	jmp	<addr>
               	movl	$0x1f, %esi
               	movslq	%r15d, %rdx
               	movl	$0xa, %ecx
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	movslq	%r14d, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	%r15d, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r15
               	movslq	%r15d, %rax
               	addq	%r12, %rax
               	movl	$0x2d, %ecx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	movl	$0x1f, %eax
               	movslq	%r15d, %rcx
               	subq	%rcx, %rax
               	movslq	%eax, %r14
               	movq	%r12, %rsi
               	addq	%rcx, %rsi
               	movslq	%r14d, %rdx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r14d, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movslq	%ebx, %rbx
               	movslq	%r12d, %r12
               	movl	$0x20, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r14
               	movl	$0x1f, %r15d
               	movl	$0x10, %ecx
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r15, %rcx
               	subq	%rax, %rcx
               	movslq	%ecx, %r12
               	movq	%r14, %rsi
               	addq	%rax, %rsi
               	movslq	%r12d, %rdx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r12d, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r15
               	movslq	%ebx, %rbx
               	movslq	%r15d, %r15
               	leaq	<rip>, %rsi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x11, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%r12, %rax
               	addq	$0x10, %rax
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	movl	$0xf, %r14d
               	jmp	<addr>
               	movslq	%r14d, %rax
               	cmpq	$0x0, %rax
               	jl	<addr>
               	movslq	%r15d, %rax
               	movq	%rax, %r10
               	andq	$0xf, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x28(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$0xa, %rax
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x10, %edx
               	movq	%rbx, %rdi
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
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movslq	%r14d, %rax
               	addq	%r12, %rax
               	movq	0x28(%rsp), %rcx
               	movslq	%ecx, %rcx
               	addq	$0x30, %rcx
               	movslq	%ecx, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	movslq	%r15d, %rax
               	sarq	$0x4, %rax
               	movabsq	$0xfffffffffffffff, %r15 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%rax, %r15
               	movslq	%r14d, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	movslq	%r14d, %rax
               	addq	%r12, %rax
               	movq	0x28(%rsp), %rcx
               	movslq	%ecx, %rcx
               	addq	$0x61, %rcx
               	movslq	%ecx, %rcx
               	subq	$0xa, %rcx
               	movslq	%ecx, %rcx
               	movb	%cl, (%rax)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movslq	%ebx, %rbx
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x6, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	jmp	<addr>
               	movslq	%r14d, %rax
               	addq	%r12, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	%r14d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	movslq	%r14d, %rdx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r14d, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
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
               	movq	%rdi, %rbx
               	movq	%rdx, %rax
               	movq	%rsi, %r12
               	movslq	%ebx, %rbx
               	movq	%rax, 0x30(%rbp)
               	xorq	%r14, %r14
               	movq	%r14, %r15
               	jmp	<addr>
               	movslq	%r14d, %rax
               	addq	%r12, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	%r14d, %rax
               	addq	%r12, %rax
               	movzbq	(%rax), %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	xorq	$0x25, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
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
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	andq	$0xff, %rax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	movslq	%r14d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r14d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r14
               	movslq	%r14d, %rax
               	addq	%r12, %rax
               	movzbq	(%rax), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x28(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x64, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	%r15d, %r15
               	leaq	0x30(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %r10
               	movq	%r10, (%r13)
               	movslq	(%rax), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r15, %rax
               	movslq	%eax, %r15
               	movslq	%r14d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x75, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	%r15d, %r15
               	leaq	0x30(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %r10
               	movq	%r10, (%r13)
               	movslq	(%rax), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r15, %rax
               	movslq	%eax, %r15
               	movslq	%r14d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x78, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	%r15d, %r15
               	leaq	0x30(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %r10
               	movq	%r10, (%r13)
               	movslq	(%rax), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r15, %rax
               	movslq	%eax, %r15
               	movslq	%r14d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x70, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	%r15d, %r15
               	leaq	0x30(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %r10
               	movq	%r10, (%r13)
               	movslq	(%rax), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r15, %rax
               	movslq	%eax, %r15
               	movslq	%r14d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x63, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	0x30(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %r10
               	movq	%r10, (%r13)
               	movslq	(%rax), %rax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	movslq	%r14d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x73, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movslq	%r15d, %r15
               	leaq	0x30(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %r10
               	movq	%r10, (%r13)
               	movq	(%rax), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r15, %rax
               	movslq	%eax, %r15
               	movslq	%r14d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0x25, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x25, %eax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r15
               	movslq	%r14d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %rax
               	andq	$0xff, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x25, %eax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x1, %r10d
               	movq	%r10, 0x20(%rsp)
               	movq	%rbx, %rdi
               	movq	0x20(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x28(%rsp), %rax
               	andq	$0xff, %rax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	0x20(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r15d, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %r15
               	movslq	%r14d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movl	$0x1, %edi
               	movq	%rax, %rsi
               	movq	%rcx, %rdx
               	popq	%rbp
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	0x10(%rbp), %rcx
               	leaq	0x10(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x10(%rbp), %rdi
               	movq	-0x8(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2a, %edx
               	movl	$0x41, %ecx
               	movl	$0xff, %r8d
               	subq	$0x10, %rsp
               	movq	%r8, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rcx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x50, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jg	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	xorq	%rsi, %rsi
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movslq	%eax, %rax
               	cmpq	$0x13, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
