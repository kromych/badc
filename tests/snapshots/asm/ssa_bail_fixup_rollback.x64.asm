
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
               	pushq	%r14
               	pushq	%rbx
               	movq	%rdi, %r14
               	leaq	(%rcx), %rax
               	movl	(%rax), %eax
               	movl	0x4(%rcx), %r8d
               	movl	0x8(%rcx), %ebx
               	movl	0xc(%rcx), %ecx
               	xorq	%r8, %rax
               	xorq	%rbx, %rax
               	xorq	%rcx, %rax
               	andq	$0xff, %rax
               	movb	%al, (%r14)
               	popq	%rbx
               	popq	%r14
               	leave
               	retq

<stream_xor>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%r8, %r14
               	xorl	%ebx, %ebx
               	movl	$0x40, %r13d
               	leaq	-0x50(%rbp), %rax
               	movq	%rbx, (%rax)
               	movq	%rbx, 0x8(%rax)
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
               	cmpq	$0x40, %r13
               	jb	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movq	%r14, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	%eax, %ecx
               	cmpl	$0x40, %ecx
               	jae	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	movzbq	(%rbx,%rcx), %rdx
               	jmp	<addr>
               	xorl	%edx, %edx
               	leaq	-0x40(%rbp), %rsi
               	movzbq	(%rsi,%rcx), %rsi
               	xorq	%rsi, %rdx
               	movb	%dl, (%r12,%rcx)
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpl	$0x40, %ecx
               	jb	<addr>
               	subq	$0x40, %r13
               	addq	$0x40, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	addq	$0x40, %rbx
               	cmpq	$0x40, %r13
               	jae	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	xorl	%eax, %eax
               	cmpl	$0x20, %eax
               	jge	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rcx)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x68(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x20(%rbp), %r8
               	callq	<addr>
               	leaq	-0x68(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x4d, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
