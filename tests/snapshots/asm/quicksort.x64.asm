
quicksort.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<swap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movslq	(%rdi), %rax
               	movslq	(%rsi), %rcx
               	movl	%ecx, (%rdi)
               	movl	%eax, (%rsi)
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<partition>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%r13, 0x20(%rsp)
               	movq	%rdi, %rbx
               	movq	%rdx, %r12
               	movq	%rsi, %r15
               	movslq	%r15d, %r15
               	movslq	%r12d, %r12
               	movslq	(%rbx,%r12,4), %r14
               	movq	%r15, %rax
               	decq	%rax
               	movslq	%eax, %r10
               	movq	%r10, 0x38(%rsp)
               	movslq	%r15d, %rax
               	cmpq	%r12, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	movq	%rax, %r15
               	incq	%r15
               	jmp	<addr>
               	movslq	%r15d, %rax
               	movslq	(%rbx,%rax,4), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	jmp	<addr>
               	movq	0x38(%rsp), %rax
               	movslq	%eax, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movq	%r12, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	movq	0x38(%rsp), %rax
               	movslq	%eax, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	0x38(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	incq	%r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rdi
               	movslq	%r15d, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>

<quicksort>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%r13, 0x20(%rsp)
               	movq	%rdi, %rbx
               	movq	%rdx, %r14
               	movq	%rsi, %r12
               	movslq	%r12d, %r12
               	movslq	%r14d, %r14
               	cmpq	%r14, %r12
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r15
               	movslq	%r15d, %rax
               	decq	%rax
               	movslq	%eax, %rdx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	%r15d, %rax
               	incq	%rax
               	movslq	%eax, %rsi
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movl	$0x14, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorq	%rsi, %rsi
               	movl	$0xc, %eax
               	movl	%eax, (%rbx)
               	movl	$0x4, %edx
               	movl	$0x7, %eax
               	movl	%eax, 0x4(%rbx)
               	movl	$0xf, %eax
               	movl	%eax, 0x8(%rbx)
               	movl	$0x5, %eax
               	movl	%eax, 0xc(%rbx)
               	movl	$0xa, %eax
               	movl	%eax, 0x10(%rbx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	(%rbx), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	0x4(%rbx), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	0x8(%rbx), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	0xc(%rbx), %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	0x10(%rbx), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
