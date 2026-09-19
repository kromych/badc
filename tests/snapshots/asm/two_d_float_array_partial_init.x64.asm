
two_d_float_array_partial_init.x64:	file format elf64-x86-64

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

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rbx
               	cmpq	$0x0, 0x10(%rbx)
               	je	<addr>
               	movq	0x10(%rbx), %rax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, 0x10(%rbx)
               	movq	0x10(%rbx), %rax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r12d, %r12d
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movq	%r12, %rbx
               	cmpl	$0xc, %ebx
               	jge	<addr>
               	movq	%rbx, %rax
               	shlq	$0x4, %rax
               	leaq	(%rdx,%rax), %rsi
               	addq	$0x0, %rsi
               	movss	(%rsi,%riz), %xmm0
               	leaq	(%rcx,%rax), %rsi
               	addq	$0x0, %rsi
               	movss	(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	(%rdx,%rax), %rsi
               	movss	0x4(%rsi,%riz), %xmm0
               	leaq	(%rcx,%rax), %rsi
               	movss	0x4(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2, %edi
               	leaq	(%rdx,%rax), %rsi
               	movss	0x8(%rsi,%riz), %xmm0
               	leaq	(%rcx,%rax), %rsi
               	movss	0x8(%rsi,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %edi
               	leaq	(%rdx,%rax), %rsi
               	movss	0xc(%rsi,%riz), %xmm0
               	addq	%rcx, %rax
               	movss	0xc(%rax,%riz), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0xc, %ebx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movss	(%rax,%riz), %xmm0
               	movss	0x4(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x8(%rax,%riz), %xmm1
               	addss	%xmm1, %xmm0
               	movapd	%xmm0, %xmm15
               	movq	%rcx, %xmm0
               	addss	%xmm15, %xmm0
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	<rip>, %rax
               	addq	$0x30, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	<rip>, %rax
               	addq	$0x40, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	<rip>, %rax
               	addq	$0x50, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	<rip>, %rax
               	addq	$0x60, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	<rip>, %rax
               	addq	$0x70, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	<rip>, %rax
               	addq	$0x80, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	<rip>, %rax
               	addq	$0x90, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	<rip>, %rax
               	addq	$0xa0, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	<rip>, %rax
               	addq	$0xb0, %rax
               	movss	(%rax,%riz), %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movapd	%xmm0, %xmm14
               	addss	%xmm1, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	xorl	%eax, %eax
               	movsd	0x18(%rsp), %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movsd	0x18(%rsp), %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rdi, %r12
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rcx
               	movq	%rbx, %rax
               	shlq	$0x4, %rax
               	leaq	(%rcx,%rax), %rdx
               	movq	%r12, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	movss	(%rdx,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	leaq	<rip>, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	movss	(%rax,%riz), %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rbx, %rdx
               	movq	%r12, %rcx
               	movb	$0x2, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rdi, %r12
               	jmp	<addr>
               	movq	%rdi, %r12
               	jmp	<addr>
