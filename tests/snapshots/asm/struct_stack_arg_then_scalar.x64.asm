
struct_stack_arg_then_scalar.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	leaq	0x8(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
