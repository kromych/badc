
mul_add_contraction.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	xorq	%rsi, %rsi
               	leaq	<rip>, %rdi
               	jmp	<addr>
               	imulq	$0x18, %r9, %rbx
               	leaq	(%rdi,%rbx), %rdx
               	movslq	(%rdx), %rax
               	movslq	0x4(%rdx), %rcx
               	movslq	0x8(%rdx), %rdx
               	movq	%rax, %r8
               	imulq	%rcx, %r8
               	leaq	(%rdx,%r8), %r12
               	leaq	(%rdi,%rbx), %r9
               	movslq	0xc(%r9), %r9
               	cmpl	%r9d, %r12d
               	jne	<addr>
               	leaq	(%r8,%rdx), %r9
               	movl	%esi, %ebx
               	imulq	$0x18, %rbx, %r12
               	leaq	(%rdi,%r12), %r13
               	movslq	0xc(%r13), %r13
               	cmpl	%r13d, %r9d
               	jne	<addr>
               	movq	%r8, %r10
               	movq	%rdx, %r8
               	subq	%r10, %r8
               	leaq	(%rdi,%r12), %r9
               	movslq	0x10(%r9), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movq	%rax, %r8
               	imulq	%rcx, %r8
               	movq	%r8, %r9
               	subq	%rdx, %r9
               	movl	%esi, %ebx
               	imulq	$0x18, %rbx, %r12
               	leaq	(%rdi,%r12), %r13
               	movslq	0x14(%r13), %r13
               	cmpl	%r13d, %r9d
               	jne	<addr>
               	movq	%rdx, %r9
               	subq	%r8, %r9
               	xorq	%r8, %r9
               	movslq	%r9d, %r13
               	leaq	(%rdi,%r12), %r9
               	movslq	0x10(%r9), %r9
               	movslq	%r8d, %r8
               	xorq	%r9, %r8
               	cmpq	%r8, %r13
               	jne	<addr>
               	movq	%rax, %r8
               	imulq	%rcx, %r8
               	movq	%r8, %r10
               	movq	%rdx, %r8
               	subq	%r10, %r8
               	movslq	%r8d, %r8
               	movl	%esi, %r9d
               	imulq	$0x18, %r9, %r9
               	addq	%rdi, %r9
               	movslq	0x10(%r9), %r9
               	cmpq	%r9, %r8
               	jne	<addr>
               	movq	%rdx, %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movl	%esi, %eax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, %r9d
               	cmpl	$0x7, %r9d
               	jb	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	imulq	$0x28, %rsi, %rdi
               	leaq	(%rdx,%rdi), %rcx
               	movq	(%rcx), %r8
               	movq	0x8(%rcx), %r9
               	movq	0x10(%rcx), %rbx
               	movq	%r8, %r12
               	imulq	%r9, %r12
               	leaq	(%rbx,%r12), %r13
               	movq	0x18(%rcx), %rcx
               	cmpq	%rcx, %r13
               	jne	<addr>
               	movq	%rbx, %rsi
               	subq	%r12, %rsi
               	movl	%eax, %ecx
               	imulq	$0x28, %rcx, %rcx
               	addq	%rdx, %rcx
               	movq	0x20(%rcx), %rcx
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %esi
               	cmpl	$0x4, %esi
               	jb	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	imulq	$0x14, %rsi, %rdi
               	leaq	(%rdx,%rdi), %rcx
               	movl	(%rcx), %r8d
               	movl	0x4(%rcx), %r9d
               	movl	0x8(%rcx), %ecx
               	movl	%r8d, %ebx
               	movl	%r9d, %r12d
               	movl	%ecx, %r13d
               	movl	%r13d, %r13d
               	movl	%ebx, %ebx
               	movl	%r12d, %r12d
               	imulq	%r12, %rbx
               	movl	%ebx, %ebx
               	addq	%r13, %rbx
               	movl	%ebx, %ebx
               	leaq	(%rdx,%rdi), %rsi
               	movl	0xc(%rsi), %esi
               	cmpl	%esi, %ebx
               	jne	<addr>
               	movl	%r8d, %esi
               	movl	%r9d, %edi
               	movl	%ecx, %ecx
               	movl	%ecx, %ecx
               	movl	%esi, %esi
               	movl	%edi, %edi
               	imulq	%rdi, %rsi
               	movl	%esi, %esi
               	subq	%rsi, %rcx
               	movl	%ecx, %esi
               	movl	%eax, %ecx
               	imulq	$0x14, %rcx, %rcx
               	addq	%rdx, %rcx
               	movl	0x10(%rcx), %ecx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %esi
               	cmpl	$0x4, %esi
               	jb	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	imulq	$0x28, %rsi, %rdi
               	leaq	(%rdx,%rdi), %rcx
               	movq	(%rcx), %r8
               	movq	0x8(%rcx), %r9
               	movq	0x10(%rcx), %rbx
               	movq	%r8, %r12
               	imulq	%r9, %r12
               	leaq	(%rbx,%r12), %r13
               	movq	0x18(%rcx), %rcx
               	cmpq	%rcx, %r13
               	jne	<addr>
               	movq	%rbx, %rsi
               	subq	%r12, %rsi
               	movl	%eax, %ecx
               	imulq	$0x28, %rcx, %rcx
               	addq	%rdx, %rcx
               	movq	0x20(%rcx), %rcx
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %esi
               	cmpl	$0x3, %esi
               	jb	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %r8
               	jmp	<addr>
               	imulq	$0xc, %rdx, %r9
               	leaq	(%r8,%r9), %rcx
               	movslq	(%rcx), %rsi
               	movslq	0x4(%rcx), %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	imulq	%rbx, %rdi
               	subq	%rdi, %rsi
               	addq	%rbx, %rsi
               	movslq	0x8(%rcx), %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movl	%eax, %edx
               	cmpl	$0x6, %edx
               	jb	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	imulq	$0x18, %rdx, %rdi
               	leaq	(%rsi,%rdi), %rcx
               	movq	(%rcx), %r8
               	movq	0x8(%rcx), %r9
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	imulq	%rbx, %r9
               	subq	%r9, %r8
               	addq	%rbx, %r8
               	movq	0x10(%rcx), %rcx
               	cmpq	%rcx, %r8
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	movl	%eax, %edx
               	cmpl	$0x3, %edx
               	jb	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rdi
               	jmp	<addr>
               	shlq	$0x5, %rcx
               	leaq	(%rdi,%rcx), %rdx
               	movq	(%rdx), %rsi
               	movq	0x8(%rdx), %rcx
               	movq	0x10(%rdx), %rdx
               	leaq	0x1(%rsi), %rbx
               	leaq	0x2(%rcx), %r12
               	leaq	0x3(%rdx), %r13
               	movq	%rsi, %r14
               	xorq	%rcx, %r14
               	movq	%rcx, %r15
               	xorq	%rdx, %r15
               	leaq	(%rsi,%rcx), %r8
               	leaq	(%rcx,%rdx), %r9
               	addq	%rsi, %rdx
               	movq	%r9, %r10
               	imulq	%rdx, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%r8, %r10
               	subq	0x38(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rbx, %r10
               	movq	0x38(%rsp), %rbx
               	addq	%r10, %rbx
               	addq	%r12, %rbx
               	addq	%r13, %rbx
               	addq	%r14, %rbx
               	addq	%r15, %rbx
               	addq	%rbx, %r8
               	addq	%r9, %r8
               	addq	%r8, %rdx
               	imulq	%rsi, %rcx
               	addq	%rcx, %rdx
               	movl	%eax, %ecx
               	shlq	$0x5, %rcx
               	addq	%rdi, %rcx
               	movq	0x18(%rcx), %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpl	$0x3, %ecx
               	jb	<addr>
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movslq	(%rsi,%rdx,4), %rdi
               	leaq	(%rdi,%rdi,2), %rdi
               	addq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	cmpl	$0x33, %eax
               	je	<addr>
               	movl	$0x46, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movslq	(%rsi,%rdx,4), %rdi
               	leaq	(%rdi,%rdi,2), %rdi
               	addq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rdx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x47, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movslq	(%rsi,%rdx,4), %rdi
               	imulq	$-0x1, %rdi, %rdi
               	addq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	cmpl	$-0x11, %eax
               	je	<addr>
               	movl	$0x48, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movslq	(%rsi,%rdx,4), %rdi
               	imulq	$0x7, %rdi, %rdi
               	addq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x49, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x33, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x32, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x29, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x28, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
