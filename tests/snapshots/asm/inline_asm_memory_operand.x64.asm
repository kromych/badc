
inline_asm_memory_operand.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xa, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movl	$0x14, %edx
               	movl	$0xa, %eax
               	lock
               	cmpxchgl	%edx, (%rcx)
               	xorq	$0xa, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	-0x18(%rbp), %eax
               	xorq	$0x14, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rcx
               	movl	$0x1e, %edx
               	movl	$0x63, %eax
               	lock
               	cmpxchgl	%edx, (%rcx)
               	xorq	$0x14, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	-0x18(%rbp), %eax
               	xorq	$0x14, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x5, -0x10(%rbp)
               	movl	$0x3, %eax
               	leaq	-0x10(%rbp), %rcx
               	lock
               	xaddl	%eax, (%rcx)
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	-0x10(%rbp), %eax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	$0x64, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movl	$0xc8, %edx
               	movl	$0x64, %eax
               	lock
               	cmpxchgq	%rdx, (%rcx)
               	cmpq	$0x64, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
