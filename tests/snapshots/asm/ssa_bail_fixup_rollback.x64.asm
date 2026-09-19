
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movl	(%rcx), %eax
               	movl	0x4(%rcx), %edi
               	movl	0x8(%rcx), %r8d
               	movl	0xc(%rcx), %ecx
               	xorq	%rdi, %rax
               	xorq	%r8, %rax
               	xorq	%rcx, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rbx)
               	popq	%rbx
               	leave
               	retq

<stream_xor>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%r8, %r13
               	xorl	%r12d, %r12d
               	movl	$0x40, %eax
               	leaq	-0x50(%rbp), %rdx
               	movq	%r12, (%rdx)
               	movq	%r12, 0x8(%rdx)
               	leaq	-0x50(%rbp), %rdx
               	movzbq	(%rcx), %rsi
               	movb	%sil, (%rdx)
               	movzbq	0x1(%rcx), %rsi
               	movb	%sil, 0x1(%rdx)
               	leaq	-0x50(%rbp), %rdx
               	movzbq	0x2(%rcx), %rsi
               	movb	%sil, 0x2(%rdx)
               	movzbq	0x3(%rcx), %rsi
               	movb	%sil, 0x3(%rdx)
               	leaq	-0x50(%rbp), %rdx
               	movzbq	0x4(%rcx), %rsi
               	movb	%sil, 0x4(%rdx)
               	movzbq	0x5(%rcx), %rsi
               	movb	%sil, 0x5(%rdx)
               	leaq	-0x50(%rbp), %rdx
               	movzbq	0x6(%rcx), %rsi
               	movb	%sil, 0x6(%rdx)
               	movzbq	0x7(%rcx), %rcx
               	movb	%cl, 0x7(%rdx)
               	cmpl	$0x40, %eax
               	jb	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movq	%r13, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x40, %eax
               	jae	<addr>
               	leaq	-0x40(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	movb	%cl, (%rbx,%rax)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jb	<addr>
               	xorl	%eax, %eax
               	addq	$0x40, %rbx
               	cmpl	$0x40, %eax
               	jae	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
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
               	leaq	-0x20(%rbp), %rcx
               	movb	%al, (%rcx,%rax)
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
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
