
strtod_family_reads_c99s_subject_sequences.x64:	file format elf64-x86-64

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

<floats>:
               	subq	$0x28, %rsp
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	callq	<addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	ucomiss	%xmm0, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	xorps	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	0x10(%rsp), %rsi
               	callq	<addr>
               	fstpt	(%rsp)
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rdi
               	leaq	0x18(%rsp), %rsi
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x18(%rsp), %rax
               	movl	(%rax), %eax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	fstpt	(%rsp)
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq

<main>:
               	subq	$0xa8, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r14d, %r14d
               	leaq	<rip>, %rax # <addr>
               	movq	%r14, %rcx
               	shlq	$0x5, %rcx
               	leaq	(%rax,%rcx), %r12
               	leaq	0x40(%rsp), %rdi
               	movq	(%r12), %rsi
               	movl	$0x20, %edx
               	callq	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x3, %ebx
               	jge	<addr>
               	movl	0x8(%r12), %r13d
               	callq	<addr>
               	movl	$0x0, (%rax)
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	(%r12), %rdi
               	leaq	0x38(%rsp), %rsi
               	callq	<addr>
               	movq	0x38(%rsp), %r13
               	movq	(%r12), %rax
               	subq	%rax, %r13
               	movsd	%xmm0, 0x28(%rsp)
               	callq	<addr>
               	movsd	0x28(%rsp), %xmm0
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	movq	0x10(%r12), %rax
               	movq	%xmm0, %rdx
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	ucomisd	%xmm0, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	0x8(%r12), %eax
               	cmpl	%eax, %r13d
               	jne	<addr>
               	cmpl	$0x2, %ebx
               	jge	<addr>
               	movl	0x18(%r12), %eax
               	testl	%eax, %eax
               	jl	<addr>
               	cmpl	%eax, %esi
               	je	<addr>
               	jmp	<addr>
               	cmpq	%rax, %rdx
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	cmpl	$0x1, %ebx
               	jne	<addr>
               	leaq	0x40(%rsp), %rdi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3e, %rcx
               	leaq	(%rax,%rcx), %r13
               	sarq	$0x2, %r13
               	jmp	<addr>
               	movq	(%r12), %rdi
               	callq	<addr>
               	jmp	<addr>
               	leaq	0x1(%rbx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	xorl	%eax, %eax
               	incq	%r14
               	cmpl	$0x24, %r14d
               	jb	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0xc8, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0xa8, %rsp
               	retq
               	movl	$0x1, %edi
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%ebx, %ebx
               	movl	$0x1, %edi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0xdc(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0xa8, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0xa8, %rsp
               	retq
               	callq	<addr>
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2c, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	0xb8(%rsp), %rsi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0xb8(%rsp), %rax
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	0xb8(%rsp), %rsi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0xb8(%rsp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2e, %eax
               	je	<addr>
               	movl	$0x2, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	0xb8(%rsp), %rsi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0xb8(%rsp), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %ebx
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	movq	%r14, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0xa8, %rsp
               	retq
