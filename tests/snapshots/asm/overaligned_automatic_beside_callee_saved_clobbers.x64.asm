
overaligned_automatic_beside_callee_saved_clobbers.x64:	file format elf64-x86-64

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

<touch>:
               	movb	%sil, (%rdi)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	addq	%rsi, %rcx
               	movl	%ecx, (%rax)
               	retq

<beside_vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	movq	%rsp, %rbx
               	leaq	(%rbx), %rdi
               	movl	$0x3, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0xa, %edx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r10
               	subq	%r11, %r10
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r10, %rsp
               	movq	%r10, -0x18(%rbp)
               	movl	$0x4, %esi
               	movq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0xa, %esi
               	movq	-0x18(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, -0x30(%rbp)
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
               	xorl	%r13d, %r13d
               	xorl	%r14d, %r14d
               	xorl	%r15d, %r15d
               	movq	-0x30(%rbp), %rbx
               	leaq	(%rbx), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	leaq	(%rbx), %rax
               	andq	$0x3f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movsbq	0x3f(%rbx), %rcx
               	cmpl	$0x3, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	movq	-0x18(%rbp), %r10
               	movsbq	0x9(%r10), %rcx
               	cmpl	$0x4, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	orq	%rcx, %rax
               	leaq	-0x60(%rbp), %rsp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%rbx
               	leave
               	retq

<output_after_the_writes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	subq	$0x80, %rsp
               	andq	$-0x80, %rsp
               	movq	%rsp, %rbx
               	movl	$0xa, %edx
               	movq	$0x5, 0x40(%rbx)
               	leaq	(%rbx), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r10
               	subq	%r11, %r10
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r10, %rsp
               	movq	%r10, -0x18(%rbp)
               	movl	$0x6, %esi
               	movq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0xa, %esi
               	movq	-0x18(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, -0x30(%rbp)
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
               	xorl	%r13d, %r13d
               	xorl	%r14d, %r14d
               	xorl	%r15d, %r15d
               	movq	$0x4d, %rax
               	movq	-0x30(%rbp), %rbx
               	movq	%rax, 0x40(%rbx)
               	leaq	(%rbx), %rax
               	leaq	0x10(%rax), %rcx
               	movq	%rbx, -0x30(%rbp)
               	xorl	%ebx, %ebx
               	xorl	%r12d, %r12d
               	xorl	%r13d, %r13d
               	xorl	%r14d, %r14d
               	xorl	%r15d, %r15d
               	movq	$0x4d, %rax
               	movq	%rax, (%rcx)
               	movq	-0x30(%rbp), %rbx
               	leaq	0x40(%rbx), %rax
               	andq	$0x3f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	leaq	(%rbx), %rcx
               	andq	$0x7f, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	movq	0x40(%rbx), %rcx
               	cmpq	$0x4d, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	orq	%rax, %rcx
               	movq	0x10(%rbx), %rax
               	cmpq	$0x4d, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	movq	0x18(%rbx), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	orq	%rcx, %rax
               	movq	-0x18(%rbp), %r10
               	movsbq	0x9(%r10), %rcx
               	cmpl	$0x6, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x4, %rcx
               	orq	%rcx, %rax
               	leaq	-0x60(%rbp), %rsp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%rbx
               	leave
               	retq

<byte_register_clobber>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r12
               	pushq	%rbx
               	pushq	%r13
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	movq	%rsp, %r12
               	leaq	(%r12), %rdi
               	movl	$0x3, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0xa, %edx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r13
               	subq	%r11, %r13
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r13, %rsp
               	movl	$0x4, %esi
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0xa, %esi
               	movq	%r13, %rdi
               	callq	<addr>
               	movb	$0x1, %bh
               	leaq	(%r12), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	leaq	(%r12), %rax
               	andq	$0x3f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movsbq	0x3f(%r12), %rcx
               	cmpl	$0x3, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	movsbq	0x9(%r13), %rcx
               	cmpl	$0x4, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	orq	%rcx, %rax
               	leaq	-0x30(%rbp), %rsp
               	popq	%r13
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<byte_register_among_all>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	movq	%rsp, %rbx
               	leaq	(%rbx), %rdi
               	movl	$0x3, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0xa, %edx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r10
               	subq	%r11, %r10
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r10, %rsp
               	movq	%r10, -0x18(%rbp)
               	movl	$0x4, %esi
               	movq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0xa, %esi
               	movq	-0x18(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, -0x30(%rbp)
               	movb	$0x1, %bh
               	xorl	%r12d, %r12d
               	xorl	%r13d, %r13d
               	xorl	%r14d, %r14d
               	xorl	%r15d, %r15d
               	movq	-0x30(%rbp), %rbx
               	leaq	(%rbx), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	leaq	(%rbx), %rax
               	andq	$0x3f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movsbq	0x3f(%rbx), %rcx
               	cmpl	$0x3, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	movq	-0x18(%rbp), %r10
               	movsbq	0x9(%r10), %rcx
               	cmpl	$0x4, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	orq	%rcx, %rax
               	leaq	-0x60(%rbp), %rsp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%rbx
               	leave
               	retq

<operand_names_a_candidate>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r12
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	movq	%rsp, %r12
               	leaq	(%r12), %rdi
               	movl	$0x3, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0xa, %edx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rbx, %rsp
               	movl	$0x4, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0xa, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movsbq	0x3f(%r12), %rax
               	movl	$0xa, %ecx
               	movq	%rcx, %rbx
               	addq	%rax, %rbx
               	movq	%r12, -0x20(%rbp)
               	xorl	%r12d, %r12d
               	xorl	%r13d, %r13d
               	xorl	%r14d, %r14d
               	xorl	%r15d, %r15d
               	movq	-0x20(%rbp), %r12
               	leaq	(%r12), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	leaq	(%r12), %rax
               	andq	$0x3f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movsbq	0x3f(%r12), %rcx
               	cmpl	$0x3, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	orq	%rcx, %rax
               	cmpq	$0xd, %rbx
               	setne	%cl
               	movzbq	%cl, %rcx
               	shlq	$0x2, %rcx
               	orq	%rcx, %rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xa, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
