
divmod_pair_shared_quotient.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<check_int>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rcx, %r8
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movslq	%r8d, %r8
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	popq	%rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %r9
               	imulq	%rsi, %r9
               	movq	%rdi, %rcx
               	subq	%r9, %rcx
               	cmpq	%r8, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rax,%rcx), %rbx
               	leaq	(%rdx,%r8), %rcx
               	cmpl	%ecx, %ebx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %r10
               	movq	%rdi, %r9
               	subq	%r10, %r9
               	addq	%rax, %r9
               	cmpl	%ecx, %r9d
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	imulq	%rsi, %rax
               	movq	%rdi, %rcx
               	subq	%rax, %rcx
               	addq	%rcx, %rax
               	cmpl	%edi, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	shlq	$0x4, %rax
               	addq	%rcx, %rax
               	movslq	(%rax), %rdi
               	movslq	0x4(%rax), %rsi
               	movslq	0x8(%rax), %rdx
               	movslq	0xc(%rax), %rcx
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	%ebx, %eax
               	leaq	0x1(%rax), %rbx
               	movl	%ebx, %eax
               	cmpl	$0xc, %eax
               	jb	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	shlq	$0x5, %rax
               	leaq	(%rcx,%rax), %rdx
               	movq	(%rdx), %rax
               	movq	0x8(%rdx), %rcx
               	movq	0x10(%rdx), %rdi
               	movq	0x18(%rdx), %r8
               	pushq	%rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdi, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	movq	%rdx, %r9
               	imulq	%rcx, %r9
               	movq	%rax, %rbx
               	subq	%r9, %rbx
               	cmpq	%r8, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	(%rdx,%rbx), %r9
               	leaq	(%rdi,%r8), %rbx
               	cmpq	%rbx, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	%rdx, %r9
               	imulq	%rcx, %r9
               	movq	%rax, %r12
               	subq	%r9, %r12
               	addq	%rdx, %r12
               	cmpq	%rbx, %r12
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movq	%rax, %rcx
               	subq	%r9, %rcx
               	addq	%r9, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%esi, %eax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, %eax
               	cmpl	$0x8, %eax
               	jb	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	shlq	$0x4, %rax
               	addq	%rdx, %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %esi
               	movl	0x8(%rax), %r8d
               	movl	0xc(%rax), %r9d
               	movl	%edx, %eax
               	movl	%esi, %edi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movl	%r8d, %r12d
               	cmpq	%r12, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	imulq	%rbx, %rdi
               	subq	%rdi, %rax
               	movl	%r9d, %edi
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	%edx, %eax
               	movl	%esi, %ebx
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rbx
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	imulq	%r12, %rbx
               	movq	%rbx, %r10
               	movq	%rax, %rbx
               	subq	%r10, %rbx
               	addq	%r12, %rbx
               	movl	%ebx, %ebx
               	movl	%r8d, %r12d
               	addq	%r12, %rdi
               	movl	%edi, %edi
               	cmpl	%edi, %ebx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	%esi, %edi
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, %r12
               	imulq	%rdi, %r12
               	subq	%r12, %rax
               	addq	%rbx, %rax
               	movl	%eax, %eax
               	movl	%r8d, %r8d
               	movl	%r9d, %r9d
               	addq	%r9, %r8
               	movl	%r8d, %r8d
               	cmpl	%r8d, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	%edx, %eax
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	movq	%rax, %rdx
               	popq	%rax
               	imulq	%rdi, %rdx
               	movl	%edx, %esi
               	movq	%rdx, %r10
               	movq	%rax, %rdx
               	subq	%r10, %rdx
               	addq	%rsi, %rdx
               	movl	%edx, %edx
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%ecx, %eax
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, %eax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	shlq	$0x5, %rax
               	leaq	(%rcx,%rax), %rdx
               	movq	(%rdx), %rax
               	movq	0x8(%rdx), %rcx
               	movq	0x10(%rdx), %rdi
               	movq	0x18(%rdx), %r8
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	cmpq	%rdi, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	movq	%rdx, %r9
               	imulq	%rcx, %r9
               	movq	%rax, %rbx
               	subq	%r9, %rbx
               	cmpq	%r8, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	(%rdx,%rbx), %r9
               	leaq	(%rdi,%r8), %rbx
               	cmpq	%rbx, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	%rdx, %r9
               	imulq	%rcx, %r9
               	movq	%rax, %r12
               	subq	%r9, %r12
               	addq	%rdx, %r12
               	cmpq	%rbx, %r12
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movq	%rax, %rcx
               	subq	%r9, %rcx
               	addq	%r9, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%esi, %eax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, %eax
               	cmpl	$0x3, %eax
               	jb	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x34, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x24a0, %ecx           # imm = 0x24A0
               	movl	$0xa, %esi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%ecx, %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdx
               	imulq	%rsi, %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	cmpl	$0x64, %edx
               	jg	<addr>
               	addq	%rdx, %rax
               	movq	%r8, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x35, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rcx
               	movl	$0xa, %esi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%ecx, %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdx
               	imulq	%rsi, %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	cmpl	$0x64, %edx
               	jg	<addr>
               	addq	%rdx, %rax
               	movq	%r8, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x36, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	addq	$0x28, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addq	$0x1e, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
