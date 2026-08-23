
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

<check_uint>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	movl	%edi, %eax
               	movl	%esi, %ecx
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%r8d, %ebx
               	cmpq	%rbx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	imulq	%rdx, %rcx
               	subq	%rcx, %rax
               	movl	%r9d, %ebx
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%edi, %eax
               	movl	%esi, %ecx
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %r12
               	imulq	%rcx, %r12
               	movq	%r12, %r10
               	movq	%rax, %r12
               	subq	%r10, %r12
               	addq	%rdx, %r12
               	movl	%r12d, %r12d
               	movl	%r8d, %r13d
               	addq	%r13, %rbx
               	movl	%ebx, %ebx
               	cmpq	%rbx, %r12
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	imulq	%rdx, %rcx
               	subq	%rcx, %rax
               	addq	%rdx, %rax
               	movl	%eax, %eax
               	movl	%r8d, %ecx
               	movl	%r9d, %edx
               	addq	%rdx, %rcx
               	movl	%ecx, %ecx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%edi, %eax
               	movl	%esi, %ecx
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	imulq	%rdx, %rcx
               	movl	%ecx, %edx
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	subq	%r10, %rcx
               	addq	%rdx, %rcx
               	movl	%ecx, %ecx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	shlq	$0x4, %rax
               	leaq	(%rcx,%rax), %rdx
               	movslq	(%rdx), %rax
               	movslq	0x4(%rdx), %rcx
               	movslq	0x8(%rdx), %rdi
               	movslq	0xc(%rdx), %r8
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
               	movslq	%r9d, %r9
               	leaq	(%rdi,%r8), %rbx
               	movslq	%ebx, %r12
               	cmpq	%r12, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	%rdx, %r9
               	imulq	%rcx, %r9
               	movq	%rax, %r13
               	subq	%r9, %r13
               	addq	%rdx, %r13
               	movslq	%r13d, %r13
               	cmpq	%r12, %r13
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movq	%rax, %rcx
               	subq	%r9, %rcx
               	addq	%r9, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%esi, %eax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, %eax
               	cmpq	$0xc, %rax
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
               	cmpq	$0x8, %rax
               	jb	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	shlq	$0x4, %rax
               	addq	%rcx, %rax
               	movl	(%rax), %edi
               	movl	0x4(%rax), %esi
               	movl	0x8(%rax), %edx
               	movl	0xc(%rax), %ecx
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	%ebx, %eax
               	leaq	0x1(%rax), %rbx
               	movl	%ebx, %eax
               	cmpq	$0x4, %rax
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
               	cmpq	$0x3, %rax
               	jb	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x34, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x24a0, %ecx           # imm = 0x24A0
               	movl	$0xa, %esi
               	xorq	%rax, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdi
               	imulq	%rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rdx, %rdi
               	subq	%r10, %rdi
               	movslq	%edi, %r9
               	cmpq	$0x64, %r9
               	jg	<addr>
               	addq	%rdi, %rax
               	movq	%r8, %rcx
               	movslq	%ecx, %rdx
               	testq	%rdx, %rdx
               	jg	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x35, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rcx
               	movl	$0xa, %esi
               	xorq	%rax, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdi
               	imulq	%rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rdx, %rdi
               	subq	%r10, %rdi
               	movslq	%edi, %r9
               	cmpq	$0x64, %r9
               	jg	<addr>
               	addq	%rdi, %rax
               	movq	%r8, %rcx
               	movslq	%ecx, %rdx
               	testq	%rdx, %rdx
               	jg	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x36, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
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
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addq	$0x1e, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
