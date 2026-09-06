
inline_asm_goto.x64:	file format elf64-x86-64

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

<take_or_fall>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq

<pick>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	je	<addr>
               	jmp	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x14, %eax
               	leave
               	retq

<count_down>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rcx, %rcx
               	incq	%rcx
               	decq	%rdi
               	movslq	%edi, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leave
               	retq

<same_target>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq

<splice_then_goto>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpl	$0x1, %eax
               	jg	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq

<phi_merge>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movl	$0x5, %ecx
               	cmpl	$0xa, %edi
               	jle	<addr>
               	movl	$0x9, %ecx
               	movslq	%ecx, %rax
               	leave
               	retq
               	movq	%rdi, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %ecx
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %eax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	je	<addr>
               	jmp	<addr>
               	movl	$0xa, %eax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x3, %eax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	je	<addr>
               	jmp	<addr>
               	movl	$0xa, %eax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x7, %ecx
               	xorq	%rdx, %rdx
               	incq	%rdx
               	decq	%rcx
               	movslq	%ecx, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpl	$0x1, %eax
               	jg	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpl	$0x1, %eax
               	jg	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movl	$0x5, %ecx
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %ecx
               	movslq	%ecx, %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	movl	$0x5, %ecx
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %ecx
               	movslq	%ecx, %rax
               	cmpl	$0x5, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	xorq	%rax, %rax
               	movl	$0x2a, %eax
               	leave
               	retq
               	movl	$0x8, %eax
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x14, %eax
               	jmp	<addr>
               	movl	$0x14, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
