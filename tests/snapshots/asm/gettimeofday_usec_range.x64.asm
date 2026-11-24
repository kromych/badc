
gettimeofday_usec_range.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	0x10(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x18(%rsp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	cmpq	$0xf4240, %rax          # imm = 0xF4240
               	jge	<addr>
               	movq	0x10(%rsp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	incq	%rbx
               	nopw	(%rax,%rax)
               	cmpl	$0x64, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
