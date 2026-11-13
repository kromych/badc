
qsort_and_bsearch_call_the_comparison_back.x64:	file format elf64-x86-64

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

<by_key>:
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	(%rdi), %eax
               	movl	(%rsi), %ecx
               	cmpl	%ecx, %eax
               	setg	%dl
               	movzbq	%dl, %rdx
               	cmpl	%ecx, %eax
               	setl	%cl
               	movzbq	%cl, %rcx
               	movq	%rdx, %rax
               	subq	%rcx, %rax
               	retq

<ints>:
               	movl	(%rdi), %eax
               	movl	(%rsi), %ecx
               	subq	%rcx, %rax
               	retq

<names>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	(%rdi), %rdi
               	movq	(%rsi), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1f8, %rsp            # imm = 0x1F8
               	pushq	%rbx
               	leaq	-0x1a0(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%rdi)
               	movl	$0xc, %esi
               	movl	$0x4, %edx
               	leaq	-<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x1a0(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x19c(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x198(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x194(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x190(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x18c(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x188(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x184(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x180(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x17c(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x178(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x174(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x20(%rdi)
               	movl	$0x5, %esi
               	movl	$0x8, %edx
               	leaq	-<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movq	-0x1c8(%rbp), %rsi
               	movq	-0x1c0(%rbp), %rdx
               	movq	-0x1b8(%rbp), %rcx
               	movq	-0x1b0(%rbp), %r8
               	movq	-0x1a8(%rbp), %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x7, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	leaq	-0x140(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0x3, %rsi
               	movl	%esi, (%rdx)
               	movl	%eax, 0x4(%rdx)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	-0x140(%rbp), %rbx
               	movl	$0x28, %esi
               	movl	$0x8, %edx
               	leaq	-<rip>, %rcx # <addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rsi
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x3, %rcx
               	addq	%rbx, %rcx
               	movl	(%rcx), %ecx
               	leaq	-0x140(%rbp), %rdx
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	cmpl	%edx, %ecx
               	setle	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	<rip>, %esi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rdi
               	leaq	-0x140(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movl	0x4(%rax), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x28, %ebx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x170(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	0x20(%rcx), %r10
               	movq	%r10, 0x20(%rax)
               	movl	0x28(%rcx), %r10d
               	movl	%r10d, 0x28(%rax)
               	movl	$0x0, -0x1d0(%rbp)
               	jmp	<addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movl	-0x1d0(%rbp), %eax
               	incq	%rax
               	movl	%eax, -0x1d0(%rbp)
               	movl	-0x1d0(%rbp), %eax
               	cmpl	$0x9, %eax
               	jg	<addr>
               	leaq	-0x1d0(%rbp), %rdi
               	leaq	-0x170(%rbp), %rsi
               	movl	$0xb, %edx
               	movl	$0x4, %ecx
               	leaq	-<rip>, %r8 # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x1d0(%rbp), %esi
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x170(%rbp), %rcx
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3e, %rcx
               	leaq	(%rax,%rcx), %rdx
               	sarq	$0x2, %rdx
               	jmp	<addr>
               	movq	$-0x1, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	%rax, -0x1f0(%rbp)
               	leaq	-0x1f0(%rbp), %rdi
               	leaq	-0x1c8(%rbp), %rsi
               	movl	$0x5, %edx
               	movl	$0x8, %ecx
               	leaq	-<rip>, %r8 # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0x1e0(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rsi)
               	movl	$0x7, -0x1e8(%rbp)
               	leaq	-0x1e8(%rbp), %rdi
               	movl	$0x6, %edx
               	movl	$0x4, %ecx
               	leaq	-<rip>, %r8 # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	(%rbx), %rsi
               	leaq	-0x1e0(%rbp), %rcx
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3e, %rcx
               	leaq	(%rax,%rcx), %rdx
               	sarq	$0x2, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rsi
               	jmp	<addr>
