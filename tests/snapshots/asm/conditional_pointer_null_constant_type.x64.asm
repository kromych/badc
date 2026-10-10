
conditional_pointer_null_constant_type.x64:	file format elf64-x86-64

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
               	leaq	-0x18(%rbp), %rax
               	movl	$0x1, -0x18(%rbp)
               	movq	$0x1, -0x10(%rbp)
               	movl	$0x2a, -0x8(%rbp)
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rax, %rcx
               	movl	0x10(%rcx), %ecx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	0x10(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
