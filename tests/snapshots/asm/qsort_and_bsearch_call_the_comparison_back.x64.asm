
qsort_and_bsearch_call_the_comparison_back.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	movl	(%rdi), %ecx
               	movl	(%rsi), %edx
               	cmpl	%edx, %ecx
               	setg	%al
               	movzbq	%al, %rax
               	cmpl	%edx, %ecx
               	setl	%cl
               	movzbq	%cl, %rcx
               	subq	%rcx, %rax
               	retq

<ints>:
               	movl	(%rdi), %eax
               	movl	(%rsi), %ecx
               	subq	%rcx, %rax
               	retq

<names>:
               	pushq	%rax
               	movq	(%rdi), %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	popq	%r11
               	retq

<main>:
               	subq	$0x200, %rsp            # imm = 0x200
               	pushq	%rbx
               	leaq	0x60(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%rdi)
               	leaq	-<rip>, %rcx # <addr>
               	movl	$0xc, %esi
               	movl	$0x4, %edx
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	0x60(%rsp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	0x64(%rsp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	0x68(%rsp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	0x6c(%rsp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	0x70(%rsp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	0x74(%rsp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	0x78(%rsp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	0x7c(%rsp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	0x80(%rsp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	0x84(%rsp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	0x88(%rsp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	0x8c(%rsp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0x38(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x20(%rdi)
               	leaq	-<rip>, %rcx # <addr>
               	movl	$0x5, %esi
               	movl	$0x8, %edx
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movq	0x38(%rsp), %rsi
               	movq	0x40(%rsp), %rdx
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %r8
               	movq	0x58(%rsp), %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x7, %ecx
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	leaq	0xc0(%rsp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movl	%ecx, %edx
               	shrq	$0x10, %rdx
               	andq	$0x3, %rdx
               	movl	%edx, (%rsi)
               	movl	%eax, 0x4(%rsi)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	0xc0(%rsp), %rbx
               	leaq	-<rip>, %rcx # <addr>
               	movq	%rbx, %rdi
               	movl	$0x28, %esi
               	movl	$0x8, %edx
               	callq	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rsi
               	leaq	-0x1(%rax), %rcx
               	shlq	$0x3, %rcx
               	addq	%rbx, %rcx
               	movl	(%rcx), %ecx
               	leaq	0xc0(%rsp), %rdx
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
               	leaq	0xc0(%rsp), %rax
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
               	leaq	0x90(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	0x20(%rcx), %r10
               	movq	%r10, 0x20(%rax)
               	movl	0x28(%rcx), %r10d
               	movl	%r10d, 0x28(%rax)
               	movl	$0x0, 0x30(%rsp)
               	jmp	<addr>
               	movb	$0x0, %al
               	callq	<addr>
               	addl	$0x1, 0x30(%rsp)
               	movl	0x30(%rsp), %eax
               	cmpl	$0x9, %eax
               	jg	<addr>
               	leaq	-<rip>, %r8 # <addr>
               	leaq	0x30(%rsp), %rdi
               	leaq	0x90(%rsp), %rsi
               	movl	$0xb, %edx
               	movl	$0x4, %ecx
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	0x30(%rsp), %esi
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x90(%rsp), %rcx
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
               	movq	%rax, 0x10(%rsp)
               	leaq	-<rip>, %r8 # <addr>
               	leaq	0x10(%rsp), %rdi
               	leaq	0x38(%rsp), %rsi
               	movl	$0x5, %edx
               	movl	$0x8, %ecx
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x20(%rsp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rsi)
               	movl	$0x7, 0x18(%rsp)
               	leaq	-<rip>, %r8 # <addr>
               	leaq	0x18(%rsp), %rdi
               	movl	$0x6, %edx
               	movl	$0x4, %ecx
               	callq	<addr>
               	leaq	<rip>, %rdi
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	(%rbx), %rsi
               	leaq	0x20(%rsp), %rcx
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
               	addq	$0x200, %rsp            # imm = 0x200
               	retq
               	leaq	<rip>, %rsi
               	jmp	<addr>
