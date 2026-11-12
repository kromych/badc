
struct_fn_ptr_field_deref_call.x64:	file format elf64-x86-64

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

<adder3>:
               	leaq	0x3(%rdi), %rax
               	retq

<adder7>:
               	leaq	0x7(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movl	$0x14, %edi
               	callq	*%rax
               	movq	0x8(%rsp), %rcx
               	cmpl	$0xd, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpl	$0x17, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x64, %edi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movl	$0xc8, %edi
               	callq	*%rax
               	movq	0x8(%rsp), %rcx
               	cmpl	$0x6b, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cmpl	$0xcf, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
