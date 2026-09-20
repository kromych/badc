
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
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rbx
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, (%rbx)
               	movl	$0x0, 0x8(%rbx)
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	(%rbx), %rax
               	movl	$0x14, %edi
               	callq	*%rax
               	cmpl	$0xd, %r12d
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	cmpl	$0x17, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rcx, (%rax)
               	movl	$0x64, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0xc8, %edi
               	callq	*%rax
               	cmpl	$0x6b, %ebx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	cmpl	$0xcf, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
