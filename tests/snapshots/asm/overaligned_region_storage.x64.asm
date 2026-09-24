
overaligned_region_storage.x64:	file format elf64-x86-64

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

<fill>:
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	(%rax,%rax,2), %rcx
               	addq	%rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdi,%rax)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	retq

<check>:
               	leaq	-0x1(%rcx), %rax
               	andq	%rdi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	movzbq	(%rdi,%rax), %rcx
               	leaq	(%rax,%rax,2), %r8
               	addq	%rdx, %r8
               	andq	$0xff, %r8
               	cmpl	%r8d, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<one>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x218, %rsp            # imm = 0x218
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	movl	$0x10, %ecx
               	movq	%rbx, %rdx
               	callq	<addr>
               	popq	%rbx
               	leave
               	retq

<branches>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x428, %rsp            # imm = 0x428
               	pushq	%rbx
               	movslq	%edi, %rdi
               	movq	%rsi, %rbx
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	-0x420(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	-0x420(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	movl	$0x10, %ecx
               	movq	%rbx, %rdx
               	callq	<addr>
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	leaq	0x1(%rbx), %rdx
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	leaq	0x1(%rbx), %rdx
               	movl	$0x10, %ecx
               	callq	<addr>
               	popq	%rbx
               	leave
               	retq

<joined>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x218, %rsp            # imm = 0x218
               	pushq	%rbx
               	movslq	%edi, %rdi
               	movq	%rsi, %rbx
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	leaq	0x2(%rbx), %rdx
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	leaq	0x2(%rbx), %rdx
               	movl	$0x10, %ecx
               	callq	<addr>
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	leaq	0x3(%rbx), %rdx
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	leaq	0x3(%rbx), %rdx
               	movl	$0x10, %ecx
               	callq	<addr>
               	jmp	<addr>

<sequence>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x210, %rsp            # imm = 0x210
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	movl	$0x10, %ecx
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	%rax, %r12
               	andq	$0x1, %r12
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	leaq	0x9(%rbx), %rdx
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	leaq	0x9(%rbx), %rdx
               	movl	$0x10, %ecx
               	callq	<addr>
               	andq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x420, %rsp            # imm = 0x420
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x420(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	leaq	0x14(%rbx), %rdx
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	leaq	0x14(%rbx), %rdx
               	movl	$0x10, %ecx
               	callq	<addr>
               	movq	%rax, %r12
               	andq	$0x1, %r12
               	leaq	-0x420(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	movl	$0x10, %ecx
               	movq	%rbx, %rdx
               	callq	<addr>
               	andq	%rax, %r12
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	leaq	0x14(%rbx), %rax
               	leaq	0x1(%rax), %rdx
               	callq	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	leaq	0x14(%rbx), %rax
               	leaq	0x1(%rax), %rdx
               	movl	$0x10, %ecx
               	callq	<addr>
               	andq	%rax, %r12
               	leaq	-0x420(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	movl	$0x10, %ecx
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	%r12, %rcx
               	andq	%rax, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x420(%rbp), %rdi
               	movl	$0x210, %esi            # imm = 0x210
               	movl	$0x10, %ecx
               	movq	%rbx, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<wide>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x140, %rsp            # imm = 0x140
               	andq	$-0x40, %rsp
               	movq	%rdi, %rbx
               	leaq	(%rsp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	0x100(%rsp), %rdi
               	movl	$0x30, %esi
               	leaq	0x1(%rbx), %rdx
               	callq	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %esi
               	leaq	0x2(%rbx), %rdx
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	movl	$0x40, %ecx
               	movq	%rbx, %rdx
               	callq	<addr>
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	je	<addr>
               	leaq	0x100(%rsp), %rdi
               	movl	$0x30, %esi
               	leaq	0x1(%rbx), %rdx
               	movl	$0x10, %ecx
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x20, %esi
               	leaq	0x2(%rbx), %rdx
               	movl	$0x8, %ecx
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<sum_pair>:
               	testb	$0xf, %dil
               	jne	<addr>
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	addq	%rcx, %rax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<by_value>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rsi, 0x8(%rdi)
               	callq	<addr>
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movl	(%rax), %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	0x4(%rax), %eax
               	testl	%eax, %eax
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	0x4(%rax), %eax
               	testl	%eax, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	0x4(%rax), %eax
               	testl	%eax, %eax
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	0x4(%rax), %eax
               	testl	%eax, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	<rip>, %rax
               	movl	0x4(%rax), %ecx
               	movq	%rcx, (%rdi)
               	movl	0x8(%rax), %eax
               	movq	%rax, 0x8(%rdi)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
