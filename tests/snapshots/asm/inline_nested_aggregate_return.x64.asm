
inline_nested_aggregate_return.x64:	file format elf64-x86-64

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

<make_pair>:
               	movq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rcx
               	leaq	0x1(%rcx), %rdx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	incq	%rsi
               	movl	%esi, (%rcx)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	(%rcx,%rdx), %rax
               	addq	$0x4, %rax
               	addq	$0x5, %rax
               	addq	$0x6, %rax
               	addq	$0x7, %rax
               	addq	$0x8, %rax
               	addq	$0x9, %rax
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	(%rcx,%rdx), %rax
               	incq	%rax
               	addq	$0x2, %rax
               	addq	$0x3, %rax
               	addq	$0x4, %rax
               	addq	$0x5, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	orq	$0x2, %rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	leaq	0x5(%rax), %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	(%rdx,%rcx), %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	orq	$0x4, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	leaq	0x5(%rax), %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	(%rdx,%rcx), %rax
               	cmpq	$0x1a, %rax
               	je	<addr>
               	orq	$0x8, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	shlq	%rax
               	addq	%rdx, %rax
               	cmpq	$0x1a, %rax
               	je	<addr>
               	orq	$0x10, %rbx
               	movl	$0x6, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm1
               	divsd	%xmm15, %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addsd	%xmm15, %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movabsq	$0x4018000000000000, %rcx # imm = 0x4018000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm1
               	addsd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	orq	$0x20, %rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	orq	$0x80, %rbx
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ebx, %ebx
               	jmp	<addr>
