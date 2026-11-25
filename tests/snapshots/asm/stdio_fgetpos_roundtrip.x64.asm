
stdio_fgetpos_roundtrip.x64:	file format elf64-x86-64

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
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movq	%rbx, %rdi
               	leaq	0x10(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movq	%rbx, %rdi
               	leaq	0x10(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
