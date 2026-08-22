
ssa_bail_fixup_rollback.x64:	file format elf64-x86-64

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

<core>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	movq	%rdi, %r12
               	leaq	(%rcx), %rax
               	movl	(%rax), %eax
               	movl	%eax, %edi
               	leaq	0x4(%rcx), %rax
               	movl	(%rax), %eax
               	movl	%eax, %r8d
               	leaq	0x8(%rcx), %rax
               	movl	(%rax), %eax
               	movl	%eax, %r9d
               	leaq	0xc(%rcx), %rax
               	movl	(%rax), %eax
               	movl	%eax, %ecx
               	xorq	%rax, %rax
               	movl	%edi, %edx
               	movl	%r8d, %esi
               	xorq	%rsi, %rdx
               	movl	%r9d, %esi
               	xorq	%rsi, %rdx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%r12)
               	movq	(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<stream_xor>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %r12
               	movq	%r8, %r14
               	xorq	%rbx, %rbx
               	movl	$0x40, %r13d
               	leaq	-0x50(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x50(%rbp), %rax
               	leaq	(%rax), %rdx
               	leaq	(%rcx), %rsi
               	movzbq	(%rsi), %rsi
               	movb	%sil, (%rdx)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	leaq	-0x50(%rbp), %rax
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	leaq	-0x50(%rbp), %rax
               	movzbq	0x4(%rcx), %rdx
               	movb	%dl, 0x4(%rax)
               	movzbq	0x5(%rcx), %rdx
               	movb	%dl, 0x5(%rax)
               	leaq	-0x50(%rbp), %rax
               	movzbq	0x6(%rcx), %rdx
               	movb	%dl, 0x6(%rax)
               	movzbq	0x7(%rcx), %rcx
               	movb	%cl, 0x7(%rax)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movq	%r14, %rdx
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%r12,%rcx), %rsi
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	(%rbx,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	leaq	-0x40(%rbp), %rdi
               	addq	%rdi, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	%rdx, %rcx
               	movb	%cl, (%rsi)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x40, %rcx
               	jb	<addr>
               	subq	$0x40, %r13
               	addq	$0x40, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	addq	$0x40, %rbx
               	jmp	<addr>
               	cmpq	$0x40, %r13
               	jae	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdx
               	addq	%rcx, %rdx
               	movq	%rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x20, %rcx
               	jl	<addr>
               	leaq	-0x68(%rbp), %rbx
               	xorq	%rsi, %rsi
               	movl	$0x40, %edx
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %r8
               	movq	%rbx, %rdi
               	callq	<addr>
               	movzbq	(%rbx), %rax
               	xorq	$0x4d, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
