
inline_asm_goto.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<take_or_fall>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movq	%rax, -0x10(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<pick>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movq	%rax, -0x10(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testl	%eax, %eax
               	je	<addr>
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movl	$0xa, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x14, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<count_down>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rax, %rax
               	incq	%rax
               	decq	%rdi
               	movslq	%edi, %rcx
               	movq	%rax, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<same_target>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movq	%rax, -0x10(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movl	$0x7, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<splice_then_goto>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpl	$0x1, %eax
               	jg	<addr>
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<phi_merge>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movl	$0x5, %eax
               	cmpq	$0xa, %rdi
               	jle	<addr>
               	movl	$0x9, %eax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, -0x10(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %edi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
