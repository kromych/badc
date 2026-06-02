
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
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	movslq	%esi, %r9
               	movl	%r9d, 0x20(%rbp)
               	movl	$0x20, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	xorq	%rdi, %rdi
               	movl	%edi, -0x18(%rbp)
               	movslq	0x20(%rbp), %r8
               	cmpq	$0x0, %r8
               	jge	<addr>
               	movl	$0x1, %edi
               	movl	%edi, -0x18(%rbp)
               	movslq	0x20(%rbp), %r8
               	movabsq	$-0x1, %r11
               	imulq	%r11, %r8
               	movl	%r8d, 0x20(%rbp)
               	jmp	<addr>
               	movl	$0x1f, %esi
               	movslq	0x20(%rbp), %rdx
               	movl	$0xa, %ecx
               	movq	%r12, %rdi
               	callq	<addr>
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x18(%rbp), %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movslq	-0x10(%rbp), %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rcx
               	addq	%r12, %rcx
               	movl	$0x2d, %eax
               	movb	%al, (%rcx)
               	jmp	<addr>
               	movl	$0x1f, %eax
               	movslq	-0x10(%rbp), %rdx
               	subq	%rdx, %rax
               	movslq	%eax, %r14
               	movq	%r12, %rsi
               	addq	%rdx, %rsi
               	movslq	%r14d, %rdx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r14d, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movslq	%edi, %rbx
               	movslq	%esi, %r12
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
               	subq	%rax, %r15
               	movslq	%r15d, %r15
               	movq	%r14, %rsi
               	addq	%rax, %rsi
               	movslq	%r15d, %rdx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r15d, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	movslq	%esi, %r9
               	movl	%r9d, 0x20(%rbp)
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
               	movq	%r12, %rdi
               	addq	$0x10, %rdi
               	xorq	%rsi, %rsi
               	movb	%sil, (%rdi)
               	movl	$0xf, %r8d
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r8
               	cmpq	$0x0, %r8
               	jl	<addr>
               	movslq	0x20(%rbp), %rsi
               	andq	$0xf, %rsi
               	movl	%esi, -0x18(%rbp)
               	movslq	-0x18(%rbp), %r8
               	cmpq	$0xa, %r8
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
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movslq	-0x10(%rbp), %rsi
               	addq	%r12, %rsi
               	movslq	-0x18(%rbp), %r8
               	addq	$0x30, %r8
               	movslq	%r8d, %r8
               	movb	%r8b, (%rsi)
               	jmp	<addr>
               	movslq	0x20(%rbp), %rdi
               	sarq	$0x4, %rdi
               	movabsq	$0xfffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r11, %rdi
               	movl	%edi, 0x20(%rbp)
               	movslq	-0x10(%rbp), %rsi
               	subq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r8
               	addq	%r12, %r8
               	movslq	-0x18(%rbp), %rdi
               	addq	$0x61, %rdi
               	movslq	%edi, %rdi
               	subq	$0xa, %rdi
               	movslq	%edi, %rdi
               	movb	%dil, (%r8)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	movq	%rsi, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x6, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	%r12, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	-0x8(%rbp), %r14
               	addq	$0x1, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
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
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movslq	%edi, %rbx
               	movq	%rsi, %r12
               	movq	%rdx, %r8
               	movq	%r8, 0x30(%rbp)
               	xorq	%rdi, %rdi
               	movl	%edi, -0x8(%rbp)
               	movl	%edi, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdi
               	addq	%r12, %rdi
               	movzbq	(%rdi), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movslq	-0x10(%rbp), %r8
               	addq	%r12, %r8
               	movzbq	(%r8), %r8
               	movb	%r8b, -0x18(%rbp)
               	movzbq	-0x18(%rbp), %rdi
               	xorq	$0x25, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	movzbq	-0x18(%rbp), %r8
               	movb	%r8b, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rdx
               	addq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdx
               	addq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	%r12, %rax
               	movzbq	(%rax), %rax
               	movb	%al, -0x18(%rbp)
               	movzbq	-0x18(%rbp), %rdx
               	xorq	$0x64, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %rdx
               	movq	(%rdx), %rsi
               	leaq	0x10(%rsi), %r11
               	movq	%r11, (%rdx)
               	movslq	(%rsi), %rdx
               	movq	%rbx, %rdi
               	movq	%rdx, %rsi
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
               	movq	(%rax), %rdx
               	leaq	0x10(%rdx), %r11
               	movq	%r11, (%rax)
               	movslq	(%rdx), %rsi
               	movq	%rbx, %rdi
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
               	movslq	-0x8(%rbp), %r14
               	leaq	0x30(%rbp), %rax
               	movq	(%rax), %rsi
               	leaq	0x10(%rsi), %r11
               	movq	%r11, (%rax)
               	movslq	(%rsi), %rax
               	movq	%rbx, %rdi
               	movq	%rax, %rsi
               	callq	<addr>
               	movq	%rax, %rsi
               	addq	%rsi, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x18(%rbp), %rsi
               	xorq	$0x70, %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	movslq	-0x8(%rbp), %r15
               	leaq	0x30(%rbp), %rsi
               	movq	(%rsi), %rax
               	leaq	0x10(%rax), %r11
               	movq	%r11, (%rsi)
               	movslq	(%rax), %rsi
               	movq	%rbx, %rdi
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
               	xorq	$0x63, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	0x30(%rbp), %r15
               	movq	(%r15), %rax
               	leaq	0x10(%rax), %r11
               	movq	%r11, (%r15)
               	movslq	(%rax), %rax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rdx
               	addq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x18(%rbp), %rdx
               	xorq	$0x73, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movslq	-0x8(%rbp), %r15
               	leaq	0x30(%rbp), %rdx
               	movq	(%rdx), %rsi
               	leaq	0x10(%rsi), %r11
               	movq	%r11, (%rdx)
               	movq	(%rsi), %rdx
               	movq	%rbx, %rdi
               	movq	%rdx, %rsi
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
               	xorq	$0x25, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x25, %r15d
               	movb	%r15b, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rdx
               	addq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x10(%rbp)
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x18(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x25, %eax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x1, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movzbq	-0x18(%rbp), %rax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x10(%rbp)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movl	$0x1, %edi
               	movq	%r11, %rsi
               	movq	%r9, %rdx
               	popq	%rbp
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0x10(%rbp), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	movq	0x10(%rbp), %rdi
               	movq	-0x8(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x8(%rbp), %rsi
               	movslq	%eax, %rdi
               	movq	%rdi, %rax
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
               	movl	$0x1, %r8d
               	movq	%r8, %rax
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
               	movl	$0x2, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	movq	%rax, %rdi
               	movslq	%edi, %rdi
               	cmpq	$0x0, %rdi
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
               	movl	$0x4, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%rsi, %rsi
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rax, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x13, %rcx
               	je	<addr>
               	movl	$0x5, %esi
               	movq	%rsi, %rax
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	popq	%rbp
               	retq
