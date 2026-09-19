
array_range_designator.x64:	file format elf64-x86-64

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

<op_read>:
               	movl	$0xb, %eax
               	retq

<op_write>:
               	movl	$0x16, %eax
               	retq

<check_struct>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax
               	imulq	$0x18, %rbx, %r12
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	%r12, %rax
               	movq	0x8(%rax), %rax
               	callq	*%rax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	%r12, %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	callq	<addr>
               	cmpl	$0x16, %eax
               	jne	<addr>
               	callq	<addr>
               	cmpl	$0xb, %eax
               	jne	<addr>
               	callq	<addr>
               	cmpl	$0xb, %eax
               	jne	<addr>
               	callq	<addr>
               	cmpl	$0xb, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	0x14(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<check_const>:
               	xorl	%eax, %eax
               	retq

<dispatch>:
               	movslq	%edi, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax,%rdi,8), %rax
               	jmpq	*%rax
               	movl	$0x64, %eax
               	retq
               	movl	$0xc8, %eax
               	retq
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpl	$0xb, %eax
               	jne	<addr>
               	callq	<addr>
               	cmpl	$0x16, %eax
               	jne	<addr>
               	callq	<addr>
               	cmpl	$0x16, %eax
               	jne	<addr>
               	callq	<addr>
               	cmpl	$0x16, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x3e7, %rax            # imm = 0x3E7
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x3e7, %rax            # imm = 0x3E7
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	cmpq	$0x3e7, %rax            # imm = 0x3E7
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x1f, %eax
               	jmp	<addr>
               	movl	$0x1e, %eax
               	jmp	<addr>
