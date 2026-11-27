
conditional_pointer_null_constant_type.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	leaq	0x8(%rsp), %rax
               	movl	$0x1, 0x8(%rsp)
               	movq	$0x1, 0x10(%rsp)
               	movl	$0x2a, 0x18(%rsp)
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	cmovneq	%rax, %rcx
               	movl	0x10(%rcx), %ecx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	0x10(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
