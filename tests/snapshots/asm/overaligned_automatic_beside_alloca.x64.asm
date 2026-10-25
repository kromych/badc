
overaligned_automatic_beside_alloca.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	movsbq	%sil, %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	retq

<with_alloca>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	subq	$0x100, %rsp            # imm = 0x100
               	andq	$-0x100, %rsp
               	movq	%rsp, %rbx
               	movl	$0x5, %r14d
               	leaq	0x40(%rbx), %rdi
               	movl	$0x1, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	$0x5, (%rbx)
               	movq	$0x6, 0x8(%rbx)
               	movq	$0x7, 0x10(%rbx)
               	movq	$0x8, 0x18(%rbx)
               	xorl	%r13d, %r13d
               	movl	$0x1, %r12d
               	movq	%r14, %rax
               	imulq	%r12, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r15
               	subq	%r11, %r15
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r15, %rsp
               	movq	%r14, %rax
               	imulq	%r12, %rax
               	movslq	%eax, %rdx
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	0x40(%rbx), %rax
               	testb	$0x3f, %al
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	(%rbx), %rcx
               	andq	$0xff, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%r13, %rcx
               	movsbq	0x51(%rbx), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movq	0x18(%rbx), %rax
               	cmpq	$0x8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %r13d
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	imulq	%r12, %rax
               	decq	%rax
               	movslq	%eax, %rax
               	movsbq	(%r15,%rax), %rax
               	cmpl	%r12d, %eax
               	setne	%r13b
               	movzbq	%r13b, %r13
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	orq	%rcx, %r13
               	incq	%r12
               	cmpl	$0x3, %r12d
               	jle	<addr>
               	movq	%r13, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%rbx
               	leave
               	retq

<with_vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	subq	$0x80, %rsp
               	andq	$-0x80, %rsp
               	movq	%rsp, %rbx
               	movl	$0x7, %r15d
               	movl	$0x0, (%rbx)
               	movl	%r15d, 0x4(%rbx)
               	movl	$0xe, 0x8(%rbx)
               	movl	$0x15, 0xc(%rbx)
               	movl	$0x1c, 0x10(%rbx)
               	movl	$0x23, 0x14(%rbx)
               	movl	$0x2a, 0x18(%rbx)
               	movl	$0x31, 0x1c(%rbx)
               	xorl	%r13d, %r13d
               	movl	$0x1, %r12d
               	movq	%rsp, %r10
               	movq	%r10, -0x18(%rbp)
               	movq	%r15, %rax
               	imulq	%r12, %rax
               	incq	%rax
               	movslq	%eax, %rdx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r14
               	subq	%r11, %r14
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r14, %rsp
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	(%rbx), %rax
               	testb	$0x7f, %al
               	movl	$0x1, %eax
               	jne	<addr>
               	movl	0x1c(%rbx), %eax
               	cmpl	$0x31, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r15, %rax
               	imulq	%r12, %rax
               	movslq	%eax, %rax
               	movsbq	(%r14,%rax), %rax
               	cmpl	%r12d, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %r13
               	movq	-0x18(%rbp), %r10
               	movq	%r10, %rsp
               	incq	%r12
               	cmpl	$0x3, %r12d
               	jle	<addr>
               	movq	%r13, %rax
               	leaq	-0x50(%rbp), %rsp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
